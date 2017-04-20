#Requires -Version 3.0

# Invoke-SPClientLoadQuery.ps1
#
# Copyright (c) 2017 karamem0
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

function Invoke-SPClientLoadQuery {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Mandatory = $true)]
        [Microsoft.SharePoint.Client.ClientObject]
        $ClientObject,
        [Parameter(Mandatory = $false)]
        [String]
        $Retrievals
    )

    process {
        $objType = $ClientObject.GetType()
        $funcType = [Type]'System.Func`2' | ForEach-Object { $_.MakeGenericType($objType, [Object]) }
        $exprType = [Type]'System.Linq.Expressions.Expression`1' | ForEach-Object { $_.MakeGenericType($funcType) }
        $listType = [Type]'System.Collections.Generic.List`1' | ForEach-Object { $_.MakeGenericType($exprType) }
        $exprList = New-Object $listType
        if (-not [String]::IsNullOrEmpty($Retrievals)) {
            if (Test-GenericSubclassOf -InputType $objType -TestType 'Microsoft.SharePoint.Client.ClientObjectCollection`1') {
                if ((-not $Retrievals.StartsWith('Include(')) -or
                    (-not $Retrievals.EndsWith(')'))) {
                    $Retrievals = 'Include(' + $Retrievals + ')'
                }
                $paramExpr = [System.Linq.Expressions.Expression]::Parameter($objType, $objType.Name)
                $propExpr = Convert-SPClientIncludeExpression -InputString $Retrievals -Expression $paramExpr
                $lambdaExpr = [System.Linq.Expressions.Expression]::Lambda($funcType, $propExpr, $paramExpr)
                $exprList.Add($lambdaExpr)
            } else {
                if (($Retrievals.StartsWith('Include(')) -and
                    ($Retrievals.EndsWith(')'))) {
                    $Retrievals = $Retrievals.Substring(8, $Retrievals.Length - 9)
                }
                $paramExpr = [System.Linq.Expressions.Expression]::Parameter($objType, $objType.Name)
                Split-SPClientExpressionString -InputString $Retrievals -Separator ',' | ForEach-Object {
                    $propExpr = Convert-SPClientMemberAccessExpression -InputString $_ -Expression $paramExpr
                    $castExpr = [System.Linq.Expressions.Expression]::Convert($propExpr, [Object])
                    $lambdaExpr = [System.Linq.Expressions.Expression]::Lambda($funcType, $castExpr, $paramExpr)
                    $exprList.Add($lambdaExpr)
                }
            }
        }
        $loadMethod = $ClientContext.GetType().GetMethod('Load').MakeGenericMethod($objType)
        $loadMethod.Invoke($ClientContext, @($ClientObject, $exprList.ToArray())) | Out-Null
        $ClientContext.ExecuteQuery()
    }

}

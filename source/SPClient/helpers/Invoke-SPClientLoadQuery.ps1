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
        [string]
        $Retrievals
    )

    process {
        $ObjType = $ClientObject.GetType()
        $FuncType = [type]'System.Func`2' | &{ process { $_.MakeGenericType($ObjType, [object]) } }
        $ExprType = [type]'System.Linq.Expressions.Expression`1' | &{ process { $_.MakeGenericType($FuncType) } }
        $ListType = [type]'System.Collections.Generic.List`1' | &{ process{ $_.MakeGenericType($ExprType) } }
        $LambdaExprList = New-Object $ListType
        if (-not [string]::IsNullOrEmpty($Retrievals)) {
            if (Test-GenericSubclassOf -InputType $ObjType -TestType 'Microsoft.SharePoint.Client.ClientObjectCollection`1') {
                if (-not ($Retrievals.StartsWith('Include(') -and $Retrievals.EndsWith(')'))) {
                    $Retrievals = 'Include(' + $Retrievals + ')'
                }
                $ParamExpr = [System.Linq.Expressions.Expression]::Parameter($ObjType, $ObjType.Name)
                $PropExpr = Convert-SPClientIncludeExpression -InputString $Retrievals -Expression $ParamExpr
                $LambdaExpr = [System.Linq.Expressions.Expression]::Lambda($FuncType, $PropExpr, $ParamExpr)
                $LambdaExprList.Add($LambdaExpr)
            } else {
                if ($Retrievals.StartsWith('Include(') -and $Retrievals.EndsWith(')')) {
                    $Retrievals = $Retrievals.Substring(8, $Retrievals.Length - 9)
                }
                $ParamExpr = [System.Linq.Expressions.Expression]::Parameter($ObjType, $ObjType.Name)
                $Splits = Split-SPClientExpressionString -InputString $Retrievals -Separator ','
                $Splits | ForEach-Object {
                    $PropExpr = Convert-SPClientMemberAccessExpression -InputString $_ -Expression $ParamExpr
                    $CastExpr = [System.Linq.Expressions.Expression]::Convert($PropExpr, [object])
                    $LambdaExpr = [System.Linq.Expressions.Expression]::Lambda($FuncType, $CastExpr, $ParamExpr)
                    $LambdaExprList.Add($LambdaExpr)
                }
            }
        }
        $LoadMethod = $ClientContext.GetType().GetMethod('Load').MakeGenericMethod($ObjType)
        $LoadMethod.Invoke($ClientContext, @($ClientObject, $LambdaExprList.ToArray())) | Out-Null
        $ClientContext.ExecuteQuery()
    }

}

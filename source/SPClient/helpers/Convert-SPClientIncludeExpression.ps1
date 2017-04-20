#Requires -Version 3.0

# Convert-SPClientIncludeExpression.ps1
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

function Convert-SPClientIncludeExpression {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]
        $InputString,
        [Parameter(Mandatory = $true)]
        [System.Linq.Expressions.Expression]
        $Expression
    )

    process {
        if (-not $InputString.StartsWith('Include(')) {
            throw "Cannot convert expression because 'InputString' parameter does not start with 'Include(  '."
        }
        if (-not $InputString.EndsWith(')')) {
            throw "Cannot convert expression because 'InputString' parameter does not end with ')'."
        }
        $InputString = $InputString.Substring(8, $InputString.Length - 9)
        $itemType = $Expression.Type.BaseType.GenericTypeArguments[0]
        $funcType = [type]'System.Func`2' | ForEach-Object { $_.MakeGenericType($itemType, [object]) }
        $exprType = [type]'System.Linq.Expressions.Expression`1' | ForEach-Object { $_.MakeGenericType($funcType) }
        $paramExpr = [System.Linq.Expressions.Expression]::Parameter($itemType, $itemType.Name)
        $lambdaExprArray = Split-SPClientExpressionString -InputString $InputString -Separator ',' | ForEach-Object {
            $propExpr = Convert-SPClientMemberAccessExpression -InputString $_ -Expression $paramExpr
            $castExpr = [System.Linq.Expressions.Expression]::Convert($propExpr, [object])
            $lambdaExpr = [System.Linq.Expressions.Expression]::Lambda($funcType, $castExpr, $paramExpr)
            Write-Output $lambdaExpr
        }
        $arrayExpr = [System.Linq.Expressions.Expression]::NewArrayInit($exprType, [System.Linq.Expressions.Expression[]]$lambdaExprArray)
        $includeExpr = [System.Linq.Expressions.Expression]::Call( `
            [Microsoft.SharePoint.Client.ClientObjectQueryableExtension].GetMethod('Include').MakeGenericMethod($itemType), `
            [System.Linq.Expressions.Expression[]]@($Expression, $arrayExpr)
        )
        Write-Output $includeExpr
    }

}

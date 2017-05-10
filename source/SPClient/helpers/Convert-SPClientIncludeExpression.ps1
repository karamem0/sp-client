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
            throw "Cannot convert expression because 'InputString' parameter does not start with 'Include('."
        }
        if (-not $InputString.EndsWith(')')) {
            throw "Cannot convert expression because 'InputString' parameter does not end with ')'."
        }
        $InputString = $InputString.Substring(8, $InputString.Length - 9)
        $ItemType = $Expression.Type.BaseType.GenericTypeArguments[0]
        $FuncType = [type]'System.Func`2' | &{ process { $_.MakeGenericType($ItemType, [object]) } }
        $ExprType = [type]'System.Linq.Expressions.Expression`1' | &{ process { $_.MakeGenericType($FuncType) } }
        $ParamExpr = [System.Linq.Expressions.Expression]::Parameter($ItemType, $ItemType.Name)
        $LambdaExprArray = Split-SPClientExpressionString -InputString $InputString -Separator ',' | ForEach-Object {
            $PropExpr = Convert-SPClientMemberAccessExpression -InputString $_ -Expression $ParamExpr
            $CastExpr = [System.Linq.Expressions.Expression]::Convert($PropExpr, [object])
            $LambdaExpr = [System.Linq.Expressions.Expression]::Lambda($FuncType, $CastExpr, $ParamExpr)
            Write-Output $LambdaExpr
        }
        $ArrayExpr = [System.Linq.Expressions.Expression]::NewArrayInit($ExprType, [System.Linq.Expressions.Expression[]]$LambdaExprArray)
        $IncludeExpr = [System.Linq.Expressions.Expression]::Call( `
            [Microsoft.SharePoint.Client.ClientObjectQueryableExtension].GetMethod('Include').MakeGenericMethod($ItemType), `
            [System.Linq.Expressions.Expression[]]@($Expression, $ArrayExpr)
        )
        Write-Output $IncludeExpr
    }

}

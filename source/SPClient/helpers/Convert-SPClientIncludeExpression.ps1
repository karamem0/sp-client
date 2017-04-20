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
        [Parameter(Position = 0, Mandatory = $true)]
        [String]
        $InputString,
        [Parameter(Position = 1, Mandatory = $true)]
        [System.Linq.Expressions.Expression]
        $Expression
    )

    process {
        if (-not $InputString.StartsWith('Include(')) {
            throw '$InputString doesn''t start with "Include(".'
        }
        if (-not $InputString.EndsWith(')')) {
            throw '$InputString doesn''t end with ")".'
        }
        $buffer = ''
        $depth = 0
        $properties = New-Object System.Collections.ArrayList
        for ($index = 8; $index -lt $InputString.Length - 1; $index += 1) {
            if ($InputString[$index] -eq ',') {
                if ($depth -eq 0) {
                    $properties.Add($buffer.Trim()) | Out-Null
                    $buffer = ''
                    continue
                }
            }
            if ($InputString[$index] -eq '.') {
                if ($InputString.Substring($index + 1).StartsWith('Include(')) {
                    $depth += 1
                }
            }
            if ($InputString[$index] -eq ')') {
                $depth -= 1
            }
            $buffer += $InputString[$index]
        }
        if ($depth -ne 0) {
            throw 'Braces is not closed.'
        }
        $properties.Add($buffer) | Out-Null
        $itemType = $Expression.Type.BaseType.GenericTypeArguments[0]
        $funcType = [Type]'System.Func`2' | ForEach-Object { $_.MakeGenericType($itemType, [Object]) }
        $exprType = [Type]'System.Linq.Expressions.Expression`1' | ForEach-Object { $_.MakeGenericType($funcType) }
        $paramExpr = [System.Linq.Expressions.Expression]::Parameter($itemType, $itemType.Name)
        $lambdaExprArray = $properties | ForEach-Object {
            $propExpr = Convert-SPClientMemberAccessExpression -InputString $_ -Expression $paramExpr
            $castExpr = [System.Linq.Expressions.Expression]::Convert($propExpr, [Object])
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

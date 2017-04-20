#Requires -Version 3.0

# Convert-SPClientMemberAccessExpression.ps1
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

function Convert-SPClientMemberAccessExpression {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [String]
        $InputString,
        [Parameter(Mandatory = $true)]
        [System.Linq.Expressions.Expression]
        $Expression
    )

    process {
        $expr = $Expression
        $type = $Expression.Type
        Split-SPClientExpressionString -InputString $InputString -Separator '.' | ForEach-Object {
            if (Test-GenericSubclassOf -InputType $type -TestType 'Microsoft.SharePoint.Client.ClientObjectCollection`1') {
                $expr = Convert-SPClientIncludeExpression -InputString $_ -Expression $expr
            } else {
                $prop = $type.GetProperty($_)
                if ($prop -eq $null) {
                    throw "Cannot convert expression because '${type}' has no member named '${_}'."
                }
                $expr = [System.Linq.Expressions.Expression]::Property($expr, $prop)
                $type = $prop.PropertyType
            }
        }
        Write-Output $expr
    }

}

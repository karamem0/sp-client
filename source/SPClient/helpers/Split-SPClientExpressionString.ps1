#Requires -Version 3.0

# Split-SPClientExpressionString.ps1
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

function Split-SPClientExpressionString {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [String]
        $InputString,
        [Parameter(Mandatory = $true)]
        [String]
        $Separator
    )

    process {
        $buffer = ''
        $depth = 0
        for ($index = 0; $index -lt $InputString.Length; $index += 1) {
            if ($InputString[$index] -eq $Separator) {
                if ($depth -eq 0) {
                    Write-Output $buffer.Trim()
                    $buffer = ''
                    continue
                }
            }
            if ($InputString[$index] -eq '(') {
                $depth += 1
            }
            if ($InputString[$index] -eq ')') {
                $depth -= 1
            }
            $buffer += $InputString[$index]
        }
        if ($depth -ne 0) {
            throw 'Cannot convert expression because braces is not closed.'
        }
        Write-Output $buffer.Trim()
    }

}

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
        [string]
        $InputString,
        [Parameter(Mandatory = $true)]
        [string]
        $Separator
    )

    process {
        $Buffer = ''
        $Depth = 0
        for ($Index = 0; $Index -lt $InputString.Length; $Index += 1) {
            if ($InputString[$Index] -eq $Separator) {
                if ($Depth -eq 0) {
                    Write-Output $Buffer.Trim()
                    $Buffer = ''
                    continue
                }
            }
            if ($InputString[$Index] -eq '(') {
                $Depth += 1
            }
            if ($InputString[$Index] -eq ')') {
                $Depth -= 1
            }
            $Buffer += $InputString[$Index]
        }
        if ($Depth -ne 0) {
            throw 'Cannot convert expression because braces is not closed.'
        }
        Write-Output $Buffer.Trim()
    }

}

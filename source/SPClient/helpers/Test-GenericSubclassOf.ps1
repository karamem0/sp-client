#Requires -Version 3.0

# Test-GenericSubclassOf.ps1
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

function Test-GenericSubclassOf {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [Type]
        $InputType,
        [Parameter(Mandatory = $true)]
        [Type]
        $TestType
    )

    process {
        while ($InputType -ne $null -and $InputType -ne [Object]) {
            $type = $InputType
            if ($type.IsGenericType) {
                $type = $type.GetGenericTypeDefinition()
            }
            if ($type -eq $TestType) {
                Write-Output $true
                return
            }
            $InputType = $InputType.BaseType
        }
        Write-Output $false
    }

}

#Requires -Version 3.0

<#
  Split-RetrievalExpressionString.ps1

  Copyright (c) 2017 karamem0

  This software is released under the MIT License.
  https://github.com/karamem0/SPClient/blob/master/LICENSE
#>

function Split-RetrievalExpressionString {

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

#Requires -Version 3.0

<#
  Test-GenericSubclassOf.ps1

  Copyright (c) 2017 karamem0

  This software is released under the MIT License.
  https://github.com/karamem0/SPClient/blob/master/LICENSE
#>

function Test-GenericSubclassOf {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [type]
        $InputType,
        [Parameter(Mandatory = $true)]
        [type]
        $TestType
    )

    process {
        while ($InputType -ne $null -and $InputType -ne [object]) {
            $Type = $InputType
            if ($Type.IsGenericType) {
                $Type = $Type.GetGenericTypeDefinition()
            }
            if ($Type -eq $TestType) {
                Write-Output $true
                return
            }
            $InputType = $InputType.BaseType
        }
        Write-Output $false
    }

}

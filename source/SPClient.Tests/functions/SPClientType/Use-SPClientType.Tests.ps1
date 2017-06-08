#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'Use-SPClientType' {

    Context 'Success' {

        It 'Loads assemblies from current directory' {
            Mock Get-Location { Convert-Path -Path "$($SPClient.ModulePath)\..\..\lib" }
            $Params = @{
                PassThru = $true
            }
            $Result = Use-SPClientType @Params
            $Result | Should Not BeNullOrEmpty
        }

        It 'Loads assemblies from literal path' {
            $LiteralPath = Convert-Path -Path "$($SPClient.ModulePath)\..\..\lib"
            $Params = @{
                LiteralPath = $LiteralPath
                PassThru = $true
            }
            $Result = Use-SPClientType @Params
            $Result | Should Not BeNullOrEmpty
        }

    }

}

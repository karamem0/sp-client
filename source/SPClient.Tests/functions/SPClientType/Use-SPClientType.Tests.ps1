#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'Use-SPClientType' {

    Context 'Success' {

        It 'Loads assemblies of the latest version' {
            $Result = Use-SPClientType
            $Result | Should BeNullOrEmpty
        }

        It 'Loads assemblies of the specified version' {
            $Params = @{
                Version = '16'
            }
            $Result = Use-SPClientType @Params
            $Result | Should BeNullOrEmpty
        }

        It 'Loads assemblies from literal path' {
            $Params = @{
                LiteralPath = "$($PSScriptRoot)\..\..\..\..\lib"
            }
            $Result = Use-SPClientType @Params
            $Result | Should BeNullOrEmpty
        }

    }

    Context 'Failure' {

        It 'Throws an error when root directory is not exists' {
            Mock Test-Path { Write-Output $false }
            $Throw = {
                $Params = @{}
                $Result = Use-SPClientType @Params
            }
            $Throw | Should Throw 'Cannot find SharePoint Client Component assemblies.'
        }

        It 'Throws an error when version directory is not exists' {
            Mock Get-ChildItem { Write-Output $false }
            $Throw = {
                $Params = @{}
                $Result = Use-SPClientType @Params
            }
            $Throw | Should Throw 'Cannot find SharePoint Client Component assemblies.'
        }

        It 'Throws an error when literal path is not exists' {
            $Throw = {
                $Params = @{
                    LiteralPath = 'Z:\'
                }
                $Result = Use-SPClientType @Params
            }
            $Throw | Should Throw 'Cannot find SharePoint Client Component assemblies.'
        }

    }

}

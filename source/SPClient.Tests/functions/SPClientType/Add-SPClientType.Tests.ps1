#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'Add-SPClientType' {

    It 'Loads assemblies of the latest version' {
        $Result = Add-SPClientType
        $Result | Should BeNullOrEmpty
    }

    It 'Loads assemblies of the specified version' {
        $Params = @{
            Version = '16'
        }
        $Result = Add-SPClientType @Params
        $Result | Should BeNullOrEmpty
    }

    It 'Loads assemblies from literal path' {
        $Params = @{
            LiteralPath = 'C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\16\ISAPI'
        }
        $Result = Add-SPClientType @Params
        $Result | Should BeNullOrEmpty
    }

    It 'Throws an error when root directory is not exists' {
        Mock Test-Path { Write-Output $false }
        $Throw = {
            $Params = @{}
            $Result = Add-SPClientType @Params
        }
        $Throw | Should Throw 'Cannot find SharePoint Client Component assemblies.'
    }

    It 'Throws an error when version directory is not exists' {
        Mock Get-ChildItem { Write-Output $false }
        $Throw = {
            $Params = @{}
            $Result = Add-SPClientType @Params
        }
        $Throw | Should Throw 'Cannot find SharePoint Client Component assemblies.'
    }

    It 'Throws an error when literal path is not exists' {
        $Throw = {
            $Params = @{
                LiteralPath = 'Z:\'
            }
            $Result = Add-SPClientType @Params
        }
        $Throw | Should Throw 'Cannot find SharePoint Client Component assemblies.'
    }

}

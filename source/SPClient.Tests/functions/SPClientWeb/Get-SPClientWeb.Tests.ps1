#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'Get-SPClientWeb' {

    It 'Gets all webs' {
        $Result = Get-SPClientWeb
        $Result | Should Not BeNullOrEmpty
        $Result | Should BeOfType 'Microsoft.SharePoint.Client.Web'
    }

    It 'Gets a web by id' {
        $Params = @{
            Identity = $TestConfig.WebId
        }
        $Result = Get-SPClientWeb @Params
        $Result | Should Not BeNullOrEmpty
        $Result | Should BeOfType 'Microsoft.SharePoint.Client.Web'
        $Result.Id | Should Be $Params.Identity
    }

    It 'Gets a web by url' {
        $Params = @{
            Url = $TestConfig.WebUrl
        }
        $Result = Get-SPClientWeb @Params
        $Result | Should Not BeNullOrEmpty
        $Result | Should BeOfType 'Microsoft.SharePoint.Client.Web'
        $Result.ServerRelativeUrl | Should Be $Params.Url
    }

    It 'Gets the default web' {
        $Params = @{
            Default = $true
        }
        $Result = Get-SPClientWeb @Params
        $Result | Should Not BeNullOrEmpty
        $Result | Should BeOfType 'Microsoft.SharePoint.Client.Web'
    }

    It 'Gets the root web' {
        $Params = @{
            Root = $true
        }
        $Result = Get-SPClientWeb @Params
        $Result | Should Not BeNullOrEmpty
        $Result | Should BeOfType 'Microsoft.SharePoint.Client.Web'
        $Result.ServerRelativeUrl | Should Be $TestConfig.SiteUrl
    }

    It 'Throws an error when the web could not be found by id' {
        $Throw = {
            $Params = @{
                Identity = [guid]::Empty
            }
            $Result = Get-SPClientWeb @Params
            $Result | Should Not BeNullOrEmpty
        }
        $Throw | Should Throw
    }

    It 'Throws an error when the web could not be found by url' {
        $Throw = {
            $Params = @{
                Url = '/TestWeb0'
            }
            $Result = Get-SPClientWeb @Params
            $Result | Should Not BeNullOrEmpty
        }
        $Throw | Should Throw
    }

}

#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'Get-SPClientWeb' {

    Context 'Success' {

        It 'Gets all webs' {
            $Result = Get-SPClientWeb
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.Web'
        }

        It 'Gets a web by id' {
            $Params = @{
                Identity = $SPClient.TestConfig.WebId
            }
            $Result = Get-SPClientWeb @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.Web'
            $Result.Id | Should Be $Params.Identity
        }

        It 'Gets a web by url' {
            $Params = @{
                Url = $SPClient.TestConfig.WebUrl
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
            $Result.ServerRelativeUrl | Should Be $SPClient.TestConfig.SiteUrl
        }

    }

    Context 'Failure' {

        It 'Throws an error when the web could not be found by id' {
            $Throw = {
                $Params = @{
                    Identity = 'C89E2D46-4542-4A29-9FBC-01FFA1FBECDD'
                }
                $Result = Get-SPClientWeb @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'The specified web could not be found.'
        }

        It 'Throws an error when the web could not be found by url' {
            $Throw = {
                $Params = @{
                    Url = '/TestWeb0'
                }
                $Result = Get-SPClientWeb @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'The specified web could not be found.'
        }

    }

}

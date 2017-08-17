#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'Get-SPClientWeb' {

    Context 'Success' {

        It 'Gets child subsites' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $Params = @{
                ParentObject = $Web
                Scope = 'All'
            }
            $Result = Get-SPClientWeb @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.Web'
            $Result.Count | Should Be 2
            $Result[0].Title | Should Be 'Test Web 2'
            $Result[1].Title | Should Be 'Test Web 3'
        }

        It 'Gets descendant subsites' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $Params = @{
                ParentObject = $Web
                Scope = 'RecursiveAll'
            }
            $Result = Get-SPClientWeb @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.Web'
            $Result.Count | Should Be 3
            $Result[0].Title | Should Be 'Test Web 2'
            $Result[1].Title | Should Be 'Test Web 3'
            $Result[2].Title | Should Be 'Test Web 4'
        }

        It 'Gets the default site' {
            $Params = @{
                Path = 'Default'
            }
            $Result = Get-SPClientWeb @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.Web'
        }

        It 'Gets the root site' {
            $Params = @{
                Path = 'Root'
            }
            $Result = Get-SPClientWeb @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.Web'
            $Result.ServerRelativeUrl | Should Be $SPClient.TestConfig.SiteUrl
        }

        It 'Gets a site by id' {
            $Params = @{
                Identity = $SPClient.TestConfig.WebId
            }
            $Result = Get-SPClientWeb @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.Web'
            $Result.Id | Should Be $Params.Identity
        }

        It 'Gets a site by url' {
            $Params = @{
                Url = $SPClient.TestConfig.WebUrl
            }
            $Result = Get-SPClientWeb @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.Web'
            $Result.ServerRelativeUrl | Should Be $Params.Url
        }

    }

    Context 'Failure' {

        It 'Throws an error when the site could not be found by id' {
            $Throw = {
                $Params = @{
                    Identity = 'C89E2D46-4542-4A29-9FBC-01FFA1FBECDD'
                }
                $Result = Get-SPClientWeb @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'The specified site could not be found.'
        }

        It 'Throws an error when the site could not be found by url' {
            $Throw = {
                $Params = @{
                    Url = '/TestWeb0'
                }
                $Result = Get-SPClientWeb @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'The specified site could not be found.'
        }

    }

}

#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'Get-SPClientWebTemplate' {

    Context 'Success' {

        Context 'Site Collection' {

            It 'Gets all site templates' {
                $Params = @{ }
                $Result = Get-SPClientWebTemplate @Params
                $Result | Should Not BeNullOrEmpty
                $Result | Should BeOfType 'Microsoft.SharePoint.Client.WebTemplate'
            }

            It 'Gets a template by name' {
                $Params = @{
                    Name = 'STS#0'
                }
                $Result = Get-SPClientWebTemplate @Params
                $Result | Should Not BeNullOrEmpty
                $Result | Should BeOfType 'Microsoft.SharePoint.Client.WebTemplate'
                $Result.Name | Should Be 'STS#0'
            }

        }

        Context 'Site' {

            It 'Gets all site templates' {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $Params = @{
                    Web = $Web
                }
                $Result = Get-SPClientWebTemplate @Params
                $Result | Should Not BeNullOrEmpty
                $Result | Should BeOfType 'Microsoft.SharePoint.Client.WebTemplate'
            }

            It 'Gets a template by name' {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $Params = @{
                    Web = $Web
                    Name = 'STS#0'
                }
                $Result = Get-SPClientWebTemplate @Params
                $Result | Should Not BeNullOrEmpty
                $Result | Should BeOfType 'Microsoft.SharePoint.Client.WebTemplate'
                $Result.Name | Should Be 'STS#0'
            }

        }

    }

    Context 'Failure' {

        It 'Throws an error when the site template could not be found by name' {
            $Throw = {
                $Params = @{
                    Name = 'TEST#0'
                }
                $Result = Get-SPClientWebTemplate @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'The specified site template could not be found.'
        }

    }

}

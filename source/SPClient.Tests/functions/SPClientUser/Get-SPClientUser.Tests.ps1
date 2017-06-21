#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'Get-SPClientUser' {

    Context 'Success' {

        It 'Returns all users' {
            $Params = @{ }
            $Result = Get-SPClientUser @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.User'
        }

        It 'Returns a user by id' {
            $Params = @{
                Identity = $SPClient.TestConfig.UserId
            }
            $Result = Get-SPClientUser @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.User'
        }

        It 'Returns a user by name' {
            $Params = @{
                Name = $SPClient.TestConfig.UserName
            }
            $Result = Get-SPClientUser @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.User'
        }

        It 'Returns a user by email' {
            $Params = @{
                Email = $SPClient.TestConfig.UserEmail
            }
            $Result = Get-SPClientUser @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.User'
        }

        It 'Returns current user' {
            $Params = @{
                Current = $true
            }
            $Result = Get-SPClientUser @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.User'
        }

    }

    Context 'Failure' {

        It 'Throws an error when the user could not be found by id' {
            $Throw = {
                $Params = @{
                    Identity = -1
                }
                $Result = Get-SPClientUser @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'The specified user could not be found.'
        }

        It 'Throws an error when the user could not be found by name' {
            $Throw = {
                $Params = @{
                    Name = 'TestUser0'
                }
                $Result = Get-SPClientUser @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'The specified user could not be found.'
        }

        It 'Throws an error when the user could not be found by email' {
            $Throw = {
                $Params = @{
                    Email = 'testuser0@example.com'
                }
                $Result = Get-SPClientUser @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'The specified user could not be found.'
        }

    }

}

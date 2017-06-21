#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'Get-SPClientGroup' {

    Context 'Success' {

        It 'Returns all groups' {
            $Params = @{ }
            $Result = Get-SPClientGroup @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.Group'
        }

        It 'Returns a SharePoint group by id' {
            $Params = @{
                Identity = $SPClient.TestConfig.GroupId
            }
            $Result = Get-SPClientGroup @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.Group'
        }

        It 'Returns a SharePoint group by name' {
            $Params = @{
                Name = $SPClient.TestConfig.GroupName
            }
            $Result = Get-SPClientGroup @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.Group'
        }

    }

    Context 'Failure' {

        It 'Throws an error when the group could not be found by id' {
            $Throw = {
                $Params = @{
                    Identity = -1
                }
                $Result = Get-SPClientGroup @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'The specified group could not be found.'
        }

        It 'Throws an error when the group could not be found by name' {
            $Throw = {
                $Params = @{
                    Name = 'Test Group 0'
                }
                $Result = Get-SPClientGroup @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'The specified group could not be found.'
        }

    }

}

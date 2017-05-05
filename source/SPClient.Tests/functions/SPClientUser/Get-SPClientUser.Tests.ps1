#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'Get-SPClientUser' {
        
    It 'Returns all users' {
        $Web = Get-SPClientWeb -Identity $TestConfig.WebId
        $Params = @{
            ParentObject = $Web
        }
        $Result = Get-SPClientUser @Params
        $Result | Should Not BeNullOrEmpty
        $Result | Should BeOfType 'Microsoft.SharePoint.Client.User'
    }

    It 'Returns a user by id' {
        $Web = Get-SPClientWeb -Identity $TestConfig.WebId
        $Params = @{
            ParentObject = $Web
            Identity = $TestConfig.UserId
        }
        $Result = Get-SPClientUser @Params
        $Result | Should Not BeNullOrEmpty
        $Result | Should BeOfType 'Microsoft.SharePoint.Client.User'
    }

    It 'Returns a user by name' {
        $Web = Get-SPClientWeb -Identity $TestConfig.WebId
        $Params = @{
            ParentObject = $Web
            Name = $TestConfig.UserName
        }
        $Result = Get-SPClientUser @Params
        $Result | Should Not BeNullOrEmpty
        $Result | Should BeOfType 'Microsoft.SharePoint.Client.User'
    }

    It 'Returns a user by email' {
        $Web = Get-SPClientWeb -Identity $TestConfig.WebId
        $Params = @{
            ParentObject = $Web
            Email = $TestConfig.UserEmail
        }
        $Result = Get-SPClientUser @Params
        $Result | Should Not BeNullOrEmpty
        $Result | Should BeOfType 'Microsoft.SharePoint.Client.User'
    }

    It 'Throws an error when the user could not be found by name' {
        $Throw = {
            $Web = Get-SPClientWeb -Identity $TestConfig.WebId
            $Params = @{
                ParentObject = $Web
                Identity = 'TestUser0'
            }
            $Result = Get-SPClientUser @Params
            $Result | Should Not BeNullOrEmpty
        }
        $Throw | Should Throw
    }

}

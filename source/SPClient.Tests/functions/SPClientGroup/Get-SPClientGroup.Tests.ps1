#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'Get-SPClientGroup' {

    It 'Returns all groups' {
        $Web = Get-SPClientWeb -Identity $TestConfig.WebId
        $Params = @{
            ParentObject = $Web
        }
        $Result = Get-SPClientGroup @Params
        $Result | Should Not BeNullOrEmpty
        $Result | Should BeOfType 'Microsoft.SharePoint.Client.Group'
    }

    It 'Returns a SharePoint group by id' {
        $Web = Get-SPClientWeb -Identity $TestConfig.WebId
        $Params = @{
            ParentObject = $Web
            Identity = $TestConfig.GroupId
        }
        $Result = Get-SPClientGroup @Params
        $Result | Should Not BeNullOrEmpty
        $Result | Should BeOfType 'Microsoft.SharePoint.Client.Group'
    }

    It 'Returns a SharePoint group by name' {
        $Web = Get-SPClientWeb -Identity $TestConfig.WebId
        $Params = @{
            ParentObject = $Web
            Name = $TestConfig.GroupName
        }
        $Result = Get-SPClientGroup @Params
        $Result | Should Not BeNullOrEmpty
        $Result | Should BeOfType 'Microsoft.SharePoint.Client.Group'
    }

    It 'Throws an error when the group could not be found by id' {
        $Throw = {
            $Web = Get-SPClientWeb -Identity $TestConfig.WebId
            $Params = @{
                ParentObject = $Web
                Identity = -1
            }
            $Result = Get-SPClientGroup @Params
            $Result | Should Not BeNullOrEmpty
        }
        $Throw | Should Throw
    }

    It 'Throws an error when the group could not be found by name' {
        $Throw = {
            $Web = Get-SPClientWeb -Identity $TestConfig.WebId
            $Params = @{
                ParentObject = $Web
                Name = 'TestGroup0'
            }
            $Result = Get-SPClientGroup @Params
            $Result | Should Not BeNullOrEmpty
        }
        $Throw | Should Throw
    }

}

#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'Get-SPClientField' {

    It 'Returns all fields' {
        $Web = Get-SPClientWeb -Identity $TestConfig.WebId
        $List = Get-SPClientList -ParentObject $Web -Identity $TestConfig.ListId
        $Params = @{
            ParentObject = $List
        }
        $Result = Get-SPClientField @Params
        $Result | Should Not BeNullOrEmpty
        $Result | Should BeOfType 'Microsoft.SharePoint.Client.Field'
    }

    It 'Returns a field by id' {
        $Web = Get-SPClientWeb -Identity $TestConfig.WebId
        $List = Get-SPClientList -ParentObject $Web -Identity $TestConfig.ListId
        $Params = @{
            ParentObject = $List
            Identity = $TestConfig.FieldId
        }
        $Result = Get-SPClientField @Params
        $Result | Should Not BeNullOrEmpty
        $Result | Should BeOfType 'Microsoft.SharePoint.Client.Field'
        $Result.Id | Should Be $Params.Identity
    }

    It 'Returns a field by title' {
        $Web = Get-SPClientWeb -Identity $TestConfig.WebId
        $List = Get-SPClientList -ParentObject $Web -Identity $TestConfig.ListId
        $Params = @{
            ParentObject = $List
            Name = $TestConfig.FieldTitle
        }
        $Result = Get-SPClientField @Params
        $Result | Should Not BeNullOrEmpty
        $Result | Should BeOfType 'Microsoft.SharePoint.Client.Field'
        $Result.Title | Should Be $Params.Name
    }

    It 'Returns a field by internal name' {
        $Web = Get-SPClientWeb -Identity $TestConfig.WebId
        $List = Get-SPClientList -ParentObject $Web -Identity $TestConfig.ListId
        $Params = @{
            ParentObject = $List
            Name = $TestConfig.FieldName
        }
        $Result = Get-SPClientField @Params
        $Result | Should Not BeNullOrEmpty
        $Result | Should BeOfType 'Microsoft.SharePoint.Client.Field'
        $Result.InternalName | Should Be $Params.Name
    }

    It 'Throws an error when the field could not be found by id' {
        $Throw = {
            $Web = Get-SPClientWeb -Identity $TestConfig.WebId
            $List = Get-SPClientList -ParentObject $Web -Identity $TestConfig.ListId
            $Params = @{
                ParentObject = $List
                Identity = [guid]::Empty
            }
            $Result = Get-SPClientField @Params
            $Result | Should Not BeNullOrEmpty
        }
        $Throw | Should Throw
    }

    It 'Throws an error when the field could not be found by name' {
        $Throw = {
            $Web = Get-SPClientWeb -Identity $TestConfig.WebId
            $List = Get-SPClientList -ParentObject $Web -Identity $TestConfig.ListId
            $Params = @{
                ParentObject = $List
                Name = 'Test Field 0'
            }
            $Result = Get-SPClientField @Params
            $Result | Should Not BeNullOrEmpty
        }
        $Throw | Should Throw
    }

}

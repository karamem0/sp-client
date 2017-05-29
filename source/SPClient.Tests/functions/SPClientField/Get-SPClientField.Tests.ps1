#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'Get-SPClientField' {

    Context 'Success' {

        It 'Returns all fields' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
            $List = $Web.Lists.GetById($TestConfig.ListId)
            $Params = @{
                ParentList = $List
            }
            $Result = Get-SPClientField @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.Field'
        }

        It 'Returns a field by id' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
            $List = $Web.Lists.GetById($TestConfig.ListId)
            $Params = @{
                ParentList = $List
                Identity = $TestConfig.FieldId
            }
            $Result = Get-SPClientField @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.Field'
            $Result.Id | Should Be $Params.Identity
        }

        It 'Returns a field by title' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
            $List = $Web.Lists.GetById($TestConfig.ListId)
            $Params = @{
                ParentList = $List
                Name = $TestConfig.FieldTitle
            }
            $Result = Get-SPClientField @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.Field'
            $Result.Title | Should Be $Params.Name
        }

        It 'Returns a field by internal name' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
            $List = $Web.Lists.GetById($TestConfig.ListId)
            $Params = @{
                ParentList = $List
                Name = $TestConfig.FieldName
            }
            $Result = Get-SPClientField @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.Field'
            $Result.InternalName | Should Be $Params.Name
        }

    }

    Context 'Failure' {

        It 'Throws an error when the field could not be found by id' {
            $Throw = {
                $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
                $List = $Web.Lists.GetById($TestConfig.ListId)
                $Params = @{
                    ParentList = $List
                    Identity = 'CB656852-E59C-4596-9161-47A91BB25A38'
                }
                $Result = Get-SPClientField @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'The specified field could not be found.'
        }

        It 'Throws an error when the field could not be found by name' {
            $Throw = {
                $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
                $List = $Web.Lists.GetById($TestConfig.ListId)
                $Params = @{
                    ParentList = $List
                    Name = 'Test Field 0'
                }
                $Result = Get-SPClientField @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'The specified field could not be found.'
        }

    }

}

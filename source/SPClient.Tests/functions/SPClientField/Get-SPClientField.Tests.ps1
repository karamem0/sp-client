#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'Get-SPClientField' {

    Context 'Success' {

        Context 'Site Column' {

            It 'Returns all fields' {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $Params = @{
                    ParentObject = $Web
                }
                $Result = Get-SPClientField @Params
                $Result | Should Not BeNullOrEmpty
                $Result | Should BeOfType 'Microsoft.SharePoint.Client.Field'
            }

            It 'Returns a field by id' {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $Params = @{
                    ParentObject = $Web
                    Identity = $SPClient.TestConfig.FieldId
                }
                $Result = Get-SPClientField @Params
                $Result | Should Not BeNullOrEmpty
                $Result | Should BeOfType 'Microsoft.SharePoint.Client.Field'
                $Result.Id | Should Be $Params.Identity
            }

            It 'Returns a field by title' {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $Params = @{
                    ParentObject = $Web
                    Name = $SPClient.TestConfig.FieldTitle
                }
                $Result = Get-SPClientField @Params
                $Result | Should Not BeNullOrEmpty
                $Result | Should BeOfType 'Microsoft.SharePoint.Client.Field'
                $Result.Title | Should Be $Params.Name
            }

            It 'Returns a field by internal name' {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $Params = @{
                    ParentObject = $Web
                    Name = $SPClient.TestConfig.FieldName
                }
                $Result = Get-SPClientField @Params
                $Result | Should Not BeNullOrEmpty
                $Result | Should BeOfType 'Microsoft.SharePoint.Client.Field'
                $Result.InternalName | Should Be $Params.Name
            }

        }

        Context 'List Column' {

            It 'Returns all fields' {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
                $Params = @{
                    ParentObject = $List
                }
                $Result = Get-SPClientField @Params
                $Result | Should Not BeNullOrEmpty
                $Result | Should BeOfType 'Microsoft.SharePoint.Client.Field'
            }

            It 'Returns a field by id' {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
                $Params = @{
                    ParentObject = $List
                    Identity = $SPClient.TestConfig.FieldId
                }
                $Result = Get-SPClientField @Params
                $Result | Should Not BeNullOrEmpty
                $Result | Should BeOfType 'Microsoft.SharePoint.Client.Field'
                $Result.Id | Should Be $Params.Identity
            }

            It 'Returns a field by title' {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
                $Params = @{
                    ParentObject = $List
                    Name = $SPClient.TestConfig.FieldTitle
                }
                $Result = Get-SPClientField @Params
                $Result | Should Not BeNullOrEmpty
                $Result | Should BeOfType 'Microsoft.SharePoint.Client.Field'
                $Result.Title | Should Be $Params.Name
            }

            It 'Returns a field by internal name' {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
                $Params = @{
                    ParentObject = $List
                    Name = $SPClient.TestConfig.FieldName
                }
                $Result = Get-SPClientField @Params
                $Result | Should Not BeNullOrEmpty
                $Result | Should BeOfType 'Microsoft.SharePoint.Client.Field'
                $Result.InternalName | Should Be $Params.Name
            }

        }

    }

    Context 'Failure' {

        It 'Throws an error when the field could not be found by id' {
            $Throw = {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
                $Params = @{
                    ParentObject = $List
                    Identity = 'CB656852-E59C-4596-9161-47A91BB25A38'
                }
                $Result = Get-SPClientField @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'The specified field could not be found.'
        }

        It 'Throws an error when the field could not be found by name' {
            $Throw = {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
                $Params = @{
                    ParentObject = $List
                    Name = 'Test Field 0'
                }
                $Result = Get-SPClientField @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'The specified field could not be found.'
        }

    }

}

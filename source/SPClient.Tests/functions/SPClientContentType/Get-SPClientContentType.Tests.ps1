#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'Get-SPClientContentType' {

    Context 'Success' {

        Context 'Site Content Type' {

            It 'Returns all content types' {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $Params = @{
                    ParentObject = $Web
                }
                $Result = Get-SPClientContentType @Params
                $Result | Should Not BeNullOrEmpty
                $Result | Should BeOfType 'Microsoft.SharePoint.Client.ContentType'
            }

            It 'Returns a content type by id' {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $Params = @{
                    ParentObject = $Web
                    Identity = $SPClient.TestConfig.WebContentTypeId
                }
                $Result = Get-SPClientContentType @Params
                $Result | Should Not BeNullOrEmpty
                $Result | Should BeOfType 'Microsoft.SharePoint.Client.ContentType'
                $Result.StringId | Should Be $Params.Identity
            }

            It 'Returns a content type by name' {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $Params = @{
                    ParentObject = $Web
                    Name = $SPClient.TestConfig.WebContentTypeName
                }
                $Result = Get-SPClientContentType @Params
                $Result | Should Not BeNullOrEmpty
                $Result | Should BeOfType 'Microsoft.SharePoint.Client.ContentType'
                $Result.Name | Should Be $Params.Name
            }

        }

        Context 'List Content Type' {

            It 'Returns all content types' {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
                $Params = @{
                    ParentObject = $List
                }
                $Result = Get-SPClientContentType @Params
                $Result | Should Not BeNullOrEmpty
                $Result | Should BeOfType 'Microsoft.SharePoint.Client.ContentType'
            }

            It 'Returns a content type by id' {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
                $Params = @{
                    ParentObject = $List
                    Identity = $SPClient.TestConfig.ListContentTypeId
                }
                $Result = Get-SPClientContentType @Params
                $Result | Should Not BeNullOrEmpty
                $Result | Should BeOfType 'Microsoft.SharePoint.Client.ContentType'
                $Result.StringId | Should Be $Params.Identity
            }

            It 'Returns a content type by name' {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
                $Params = @{
                    ParentObject = $List
                    Name = $SPClient.TestConfig.ListContentTypeName
                }
                $Result = Get-SPClientContentType @Params
                $Result | Should Not BeNullOrEmpty
                $Result | Should BeOfType 'Microsoft.SharePoint.Client.ContentType'
                $Result.Name | Should Be $Params.Name
            }

        }

    }

    Context 'Failure' {

        It 'Throws an error when the content type could not be found by id' {
            $Throw = {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $Params = @{
                    ParentObject = $Web
                    Identity = '0x0100E29372CEECF346BD82ADB95FFF0C637D'
                }
                $Result = Get-SPClientContentType @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'The specified content type could not be found.'
        }

        It 'Throws an error when the content type could not be found by name' {
            $Throw = {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $Params = @{
                    ParentObject = $Web
                    Name = 'Test Content Type 0'
                }
                $Result = Get-SPClientContentType @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'The specified content type could not be found.'
        }

    }

}

#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'Get-SPClientFolder' {

    Context 'Success' {

        It 'Returns all folders' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $List = $Web.Lists.GetById($SPClient.TestConfig.DocLibId)
            $Folder = $List.RootFolder
            $Params = @{
                ParentObject = $Folder
            }
            $Result = Get-SPClientFolder @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.Folder'
        }

        It 'Returns a folder by id' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $Params = @{
                Web = $Web
                Identity = $SPClient.TestConfig.FolderId
                Retrieval = 'ListItemAllFields'
            }
            $Result = Get-SPClientFolder @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.Folder'
            $Result.ListItemAllFields['UniqueId'] | Should Be $SPClient.TestConfig.FolderId
        }

        It 'Returns a folder by name' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $List = $Web.Lists.GetById($SPClient.TestConfig.DocLibId)
            $Folder = $List.RootFolder
            $Params = @{
                ParentObject = $Folder
                Name = $SPClient.TestConfig.FolderName
            }
            $Result = Get-SPClientFolder @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.Folder'
            $Result.Name | Should Be $SPClient.TestConfig.FolderName
        }

        It 'Returns a folder by relative url' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $Params = @{
                Web = $Web
                Url = $SPClient.TestConfig.FolderUrl
            }
            $Result = Get-SPClientFolder @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.Folder'
            $Result.ServerRelativeUrl | Should Be $SPClient.TestConfig.FolderUrl
        }

        It 'Returns a folder by absolute url' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $Params = @{
                Web = $Web
                Url = $SPClient.TestConfig.RootUrl + $SPClient.TestConfig.FolderUrl
            }
            $Result = Get-SPClientFolder @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.Folder'
            $Result.ServerRelativeUrl | Should Be $SPClient.TestConfig.FolderUrl
        }

    }

    Context 'Failure' {

        It 'Throws an error when the folder could not be found by id' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $Throw = {
                $Params = @{
                    Web = $Web
                    Identity = '3283BFB6-BE26-41B4-9D8A-82E3E2EC87B5'
                }
                $Result = Get-SPClientFolder @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'The specified folder could not be found.'
        }

        It 'Throws an error when the folder could not be found by name' {
            $Throw = {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $List = $Web.Lists.GetById($SPClient.TestConfig.DocLibId)
                $Folder = $List.RootFolder
                $Params = @{
                    ParentObject = $Folder
                    Name = 'TestFolder0'
                }
                $Result = Get-SPClientFolder @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'The specified folder could not be found.'
        }

        It 'Throws an error when the folder could not be found by url' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $Throw = {
                $Params = @{
                    Web = $Web
                    Url = "$($SPClient.TestConfig.FolderUrl)/TestFolder0"
                }
                $Result = Get-SPClientFolder @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'The specified folder could not be found.'
        }

    }

}

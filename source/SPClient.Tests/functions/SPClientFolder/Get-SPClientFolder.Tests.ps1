#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'Get-SPClientFolder' {

    Context 'Success' {

        It 'Returns all folders' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
            $List = $Web.Lists.GetById($TestConfig.DocLibId)
            $Folder = $List.RootFolder
            $Params = @{
                ParentFolder = $Folder
            }
            $Result = Get-SPClientFolder @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.Folder'
        }

        It 'Returns a folder by id' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
            $Params = @{
                ParentWeb = $Web
                Identity = $TestConfig.FolderId
            }
            $Result = Get-SPClientFolder @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.Folder'
        }

        It 'Returns a folder by name' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
            $List = $Web.Lists.GetById($TestConfig.DocLibId)
            $Folder = $List.RootFolder
            $Params = @{
                ParentFolder = $Folder
                Name = $TestConfig.FolderName
            }
            $Result = Get-SPClientFolder @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.Folder'
        }

        It 'Returns a folder by url' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
            $Params = @{
                ParentWeb = $Web
                Url = $TestConfig.FolderUrl
            }
            $Result = Get-SPClientFolder @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.Folder'
        }

    }

    Context 'Failure' {

        It 'Throws an error when the folder could not be found by id' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
            $Throw = {
                $Params = @{
                    ParentWeb = $Web
                    Identity = '3283BFB6-BE26-41B4-9D8A-82E3E2EC87B5'
                }
                $Result = Get-SPClientFolder @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'The specified folder could not be found.'
        }

        It 'Throws an error when the folder could not be found by name' {
            $Throw = {
                $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
                $List = $Web.Lists.GetById($TestConfig.DocLibId)
                $Folder = $List.RootFolder
                $Params = @{
                    ParentFolder = $Folder
                    Name = 'TestFolder0'
                }
                $Result = Get-SPClientFolder @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'The specified folder could not be found.'
        }

        It 'Throws an error when the folder could not be found by url' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
            $Throw = {
                $Params = @{
                    ParentWeb = $Web
                    Url = "$($TestConfig.FolderUrl)/TestFolder0"
                }
                $Result = Get-SPClientFolder @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'The specified folder could not be found.'
        }

    }

}

#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'Remove-SPClientFolder' {

    Context 'Success' {

        BeforeEach {
            try {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $Folder = $Web.GetFolderById($SPClient.TestConfig.FolderId)
                $Folder = $Folder.Folders.Add('TestFolder0')
                $Folder.Update()
                $SPClient.ClientContext.Load($Folder)
                $SPClient.ClientContext.ExecuteQuery()
            } catch {
                Write-Host $_ -ForegroundColor Yellow 
            }
        }

        It 'Removes a folder by loaded client object' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $Folder = $Web.GetFolderByServerRelativeUrl("$($SPClient.TestConfig.FolderUrl)/TestFolder0")
            $SPClient.ClientContext.Load($Folder)
            $SPClient.ClientContext.ExecuteQuery()
            $Params = @{
                ClientObject = $Folder
            }
            $Result = Remove-SPClientFolder @Params
            $Result | Should BeNullOrEmpty
        }

        It 'Removes a folder by unloaded client object' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $Folder = $Web.GetFolderByServerRelativeUrl("$($SPClient.TestConfig.FolderUrl)/TestFolder0")
            $Params = @{
                ClientObject = $Folder
            }
            $Result = Remove-SPClientFolder @Params
            $Result | Should BeNullOrEmpty
        }

        It 'Removes a folder by id' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $Folder = $Web.GetFolderByServerRelativeUrl("$($SPClient.TestConfig.FolderUrl)/TestFolder0")
            $SPClient.ClientContext.Load($Folder)
            $SPClient.ClientContext.ExecuteQuery()
            $Params = @{
                Web = $Web
                Identity = $Folder.UniqueId
            }
            $Result = Remove-SPClientFolder @Params
            $Result | Should BeNullOrEmpty
        }

        It 'Removes a folder by name' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $Folder = $Web.GetFolderByServerRelativeUrl($SPClient.TestConfig.FolderUrl)
            $Params = @{
                ParentObject = $Folder
                Name = "TestFolder0"
            }
            $Result = Remove-SPClientFolder @Params
            $Result | Should BeNullOrEmpty
        }

        It 'Removes a folder by url' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $Params = @{
                Web = $Web
                Url = "$($SPClient.TestConfig.FolderUrl)/TestFolder0"
            }
            $Result = Remove-SPClientFolder @Params
            $Result | Should BeNullOrEmpty
        }

    }

    Context 'Failure' {

        It 'Throws an error when the folder could not be found by id' {
            $Throw = {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $Params = @{
                    Web = $Web
                    Identity = '031B8E12-4B3C-46E8-B4C5-3EDFC73D23BF'
                }
                $Result = Remove-SPClientFolder @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'The specified folder could not be found.'
        }

        It 'Throws an error when the folder could not be found by name' {
            $Throw = {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $Folder = $Web.GetFolderByServerRelativeUrl($SPClient.TestConfig.FolderUrl)
                $Params = @{
                    ParentObject = $Folder
                    Name = "TestFolder0"
                }
                $Result = Remove-SPClientFolder @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'The specified folder could not be found.'
        }

        It 'Throws an error when the folder could not be found by url' {
            $Throw = {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $Params = @{
                    Web = $Web
                    Url = "$($SPClient.TestConfig.FolderUrl)/TestFolder0"
                }
                $Result = Remove-SPClientFolder @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'The specified folder could not be found.'
        }

    }

}

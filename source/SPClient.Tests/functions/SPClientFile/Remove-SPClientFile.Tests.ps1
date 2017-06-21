#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'Remove-SPClientFile' {

    Context 'Success' {

        BeforeEach {
            try {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $Folder = $Web.GetFolderById($SPClient.TestConfig.FolderId)
                $Buffer = [System.Text.Encoding]::UTF8.GetBytes('TestFile0')
                $Stream = New-Object System.IO.MemoryStream(@(, $Buffer))
                $File = New-Object Microsoft.SharePoint.Client.FileCreationInformation
                $File.Url = 'TestFile0.txt'
                $File.ContentStream = $Stream
                $File = $Folder.Files.Add($File)
                $File.Update()
                $SPClient.ClientContext.Load($File)
                $SPClient.ClientContext.ExecuteQuery()
            } catch {
                Write-Host $_ -ForegroundColor Yellow 
            }
        }

        It 'Removes a file by loaded client object' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $Folder = $Web.GetFolderById($SPClient.TestConfig.FolderId)
            $File = $Folder.Files.GetByUrl('TestFile0.txt')
            $SPClient.ClientContext.Load($File)
            $SPClient.ClientContext.ExecuteQuery()
            $Params = @{
                ClientObject = $File
            }
            $Result = Remove-SPClientFile @Params
            $Result | Should BeNullOrEmpty
        }

        It 'Removes a file by unloaded client object' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $Folder = $Web.GetFolderById($SPClient.TestConfig.FolderId)
            $File = $Folder.Files.GetByUrl('TestFile0.txt')
            $Params = @{
                ClientObject = $File
            }
            $Result = Remove-SPClientFile @Params
            $Result | Should BeNullOrEmpty
        }

        It 'Removes a file by id' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $Folder = $Web.GetFolderById($SPClient.TestConfig.FolderId)
            $File = $Folder.Files.GetByUrl('TestFile0.txt')
            $SPClient.ClientContext.Load($File)
            $SPClient.ClientContext.ExecuteQuery()
            $Params = @{
                ParentWeb = $Web
                Identity = $File.UniqueId
            }
            $Result = Remove-SPClientFile @Params
            $Result | Should BeNullOrEmpty
        }

        It 'Removes a file by name' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $Folder = $Web.GetFolderById($SPClient.TestConfig.FolderId)
            $Params = @{
                ParentFolder = $Folder
                Name = "TestFile0.txt"
            }
            $Result = Remove-SPClientFile @Params
            $Result | Should BeNullOrEmpty
        }

        It 'Removes a file by url' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $Params = @{
                ParentWeb = $Web
                Url = "$($SPClient.TestConfig.FolderUrl)/TestFile0.txt"
            }
            $Result = Remove-SPClientFile @Params
            $Result | Should BeNullOrEmpty
        }

    }

    Context 'Failure' {

        It 'Throws an error when the file could not be found by id' {
            $Throw = {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $Params = @{
                    ParentWeb = $Web
                    Identity = '7308CB07-2BB0-483B-8856-B9F540497C25'
                }
                $Result = Remove-SPClientFile @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'The specified file could not be found.'
        }

        It 'Throws an error when the file could not be found by name' {
            $Throw = {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $Folder = $Web.GetFolderById($SPClient.TestConfig.FolderId)
                $Params = @{
                    ParentFolder = $Folder
                    Name = "TestFile0.txt"
                }
                $Result = Remove-SPClientFile @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'The specified file could not be found.'
        }

        It 'Throws an error when the file could not be found by url' {
            $Throw = {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $Params = @{
                    ParentWeb = $Web
                    Url = "$($SPClient.TestConfig.FolderUrl)/TestFile0.txt"
                }
                $Result = Remove-SPClientFile @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'The specified file could not be found.'
        }

    }

}

#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'New-SPClientFile' {

    Context 'Success' {

        AfterEach {
            try {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $File = $Web.GetFileByServerRelativeUrl("$($SPClient.TestConfig.FolderUrl)/TestFile0.txt")
                $File.DeleteObject()
                $SPClient.ClientContext.ExecuteQuery()
            } catch {
                Write-Host $_ -ForegroundColor Yellow 
            }
        }

        It 'Creates a new file by stream' {
            $Buffer = [System.Text.Encoding]::UTF8.GetBytes('TestFile0')
            $Stream = New-Object System.IO.MemoryStream(@(, $Buffer))
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $Folder = $Web.GetFolderByServerRelativeUrl($SPClient.TestConfig.FolderUrl)
            $Params = @{
                ParentFolder = $Folder
                ContentStream = $Stream
                Name = 'TestFile0.txt'
            }
            $Result = New-SPClientFile @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.File'
            $Result.Name | Should Be 'TestFile0.txt'
        }

        It 'Creates a new file by path' {
            $FolderPath = [System.IO.Path]::GetTempPath()
            $FilePath = [System.IO.Path]::Combine($FolderPath, 'TestFile0.txt')
            [System.IO.File]::WriteAllText($FilePath, 'TestFile0')
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $Folder = $Web.GetFolderByServerRelativeUrl($SPClient.TestConfig.FolderUrl)
            $Params = @{
                ParentFolder = $Folder
                ContentPath = $FilePath
            }
            $Result = New-SPClientFile @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.File'
            $Result.Name | Should Be 'TestFile0.txt'
        }

        It 'Creates a new file by path and file name' {
            $FilePath = [System.IO.Path]::GetTempFileName()
            [System.IO.File]::WriteAllText($FilePath, 'TestFile0')
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $Folder = $Web.GetFolderByServerRelativeUrl($SPClient.TestConfig.FolderUrl)
            $Params = @{
                ParentFolder = $Folder
                ContentPath = $FilePath
                Name = 'TestFile0.txt'
            }
            $Result = New-SPClientFile @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.File'
            $Result.Name | Should Be 'TestFile0.txt'
        }

    }

}

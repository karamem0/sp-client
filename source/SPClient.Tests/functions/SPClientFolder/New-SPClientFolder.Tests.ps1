#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'New-SPClientFolder' {

    Context 'Success' {

        AfterEach {
            try {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $Folder = $Web.GetFolderByServerRelativeUrl("$($SPClient.TestConfig.FolderUrl)/TestFolder0")
                $Folder.DeleteObject()
                $SPClient.ClientContext.ExecuteQuery()
            } catch {
                Write-Host $_ -ForegroundColor Yellow 
            }
        }

        It 'Creates a new folder' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $Folder = $Web.GetFolderByServerRelativeUrl($SPClient.TestConfig.FolderUrl)
            $Params = @{
                ParentObject = $Folder
                Name = 'TestFolder0'
            }
            $Result = New-SPClientFolder @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.Folder'
            $Result.Name | Should Be 'TestFolder0'
        }

    }

}

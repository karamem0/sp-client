#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'ConvertTo-SPClientListItem' {

    Context 'Success' {

        It 'Converts a file to list item' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
            $File = $Web.GetFileById($TestConfig.FileId)
            $Params = @{
                File = $File
            }
            $Result = ConvertTo-SPClientListItem @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.ListItem'
        }

        It 'Converts a folder to list item' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
            $Folder = $Web.GetFolderById($TestConfig.FolderId)
            $Params = @{
                Folder = $Folder
            }
            $Result = ConvertTo-SPClientListItem @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.ListItem'
        }

    }

}

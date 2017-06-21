#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'New-SPClientListItemAttachment' {

    Context 'Success' {

        AfterEach {
            try {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
                $ListItem = $List.GetItemById($SPClient.TestConfig.ListItemId)
                $Attachment = $ListItem.AttachmentFiles.GetByFileName('TestAttachment0.txt')                
                $Attachment.DeleteObject()
                $SPClient.ClientContext.ExecuteQuery()
            } catch {
                Write-Host $_ -ForegroundColor Yellow 
            }
        }

        It 'Creates a new attachment by stream' {
            $Buffer = [System.Text.Encoding]::UTF8.GetBytes('TestAttachment0')
            $Stream = New-Object System.IO.MemoryStream(@(, $Buffer))
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
            $ListItem = $List.GetItemById($SPClient.TestConfig.ListItemId)
            $Params = @{
                ParentListItem = $ListItem
                ContentStream = $Stream
                Name = 'TestAttachment0.txt'
            }
            $Result = New-SPClientListItemAttachment @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.Attachment'
            $Result.FileName | Should Be 'TestAttachment0.txt'
        }

        It 'Creates a new attachment by path' {
            $FolderPath = [System.IO.Path]::GetTempPath()
            $FilePath = [System.IO.Path]::Combine($FolderPath, 'TestAttachment0.txt')
            [System.IO.File]::WriteAllText($FilePath, 'TestAttachment0')
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
            $ListItem = $List.GetItemById($SPClient.TestConfig.ListItemId)
            $Params = @{
                ParentListItem = $ListItem
                ContentPath = $FilePath
            }
            $Result = New-SPClientListItemAttachment @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.Attachment'
            $Result.FileName | Should Be 'TestAttachment0.txt'
        }

        It 'Creates a new attachment by path and file name' {
            $FilePath = [System.IO.Path]::GetTempFileName()
            [System.IO.File]::WriteAllText($FilePath, 'TestAttachment0')
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
            $ListItem = $List.GetItemById($SPClient.TestConfig.ListItemId)
            $Params = @{
                ParentListItem = $ListItem
                ContentPath = $FilePath
                Name = 'TestAttachment0.txt'
            }
            $Result = New-SPClientListItemAttachment @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.Attachment'
            $Result.FileName | Should Be 'TestAttachment0.txt'
        }

    }

}

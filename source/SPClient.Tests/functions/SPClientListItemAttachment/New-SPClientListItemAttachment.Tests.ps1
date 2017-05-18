#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'New-SPClientListItemAttachment' {

    Context 'Success' {

        AfterEach {
            try {
                $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
                $List = $Web.Lists.GetById($TestConfig.ListId)
                $ListItem = $List.GetItemById($TestConfig.ListItemId)
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
            $Web = Get-SPClientWeb -Identity $TestConfig.WebId
            $List = Get-SPClientList -ParentObject $Web -Identity $TestConfig.ListId
            $ListItem = Get-SPClientListItem -ParentObject $List -Identity $TestConfig.ListItemId
            $Params = @{
                ParentObject = $ListItem
                ContentStream = $Stream
                FileName = 'TestAttachment0.txt'
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
            $Web = Get-SPClientWeb -Identity $TestConfig.WebId
            $List = Get-SPClientList -ParentObject $Web -Identity $TestConfig.ListId
            $ListItem = Get-SPClientListItem -ParentObject $List -Identity $TestConfig.ListItemId
            $Params = @{
                ParentObject = $ListItem
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
            $Web = Get-SPClientWeb -Identity $TestConfig.WebId
            $List = Get-SPClientList -ParentObject $Web -Identity $TestConfig.ListId
            $ListItem = Get-SPClientListItem -ParentObject $List -Identity $TestConfig.ListItemId
            $Params = @{
                ParentObject = $ListItem
                ContentPath = $FilePath
                FileName = 'TestAttachment0.txt'
            }
            $Result = New-SPClientListItemAttachment @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.Attachment'
            $Result.FileName | Should Be 'TestAttachment0.txt'
        }

    }

}

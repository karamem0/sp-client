#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'Remove-SPClientListItemAttachment' {

    Context 'Success' {

        BeforeEach {
            try {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
                $ListItem = $List.GetItemById($SPClient.TestConfig.ListItemId)
                $Buffer = [System.Text.Encoding]::UTF8.GetBytes('TestAttachment0')
                $Stream = New-Object System.IO.MemoryStream(@(, $Buffer))
                $Attachment = New-Object Microsoft.SharePoint.Client.AttachmentCreationInformation
                $Attachment.FileName = 'TestAttachment0.txt'
                $Attachment.ContentStream = $Stream
                $Attachment = $ListItem.AttachmentFiles.Add($Attachment)
                $SPClient.ClientContext.Load($Attachment)
                $SPClient.ClientContext.ExecuteQuery()
            } catch {
                Write-Host $_ -ForegroundColor Yellow 
            }
        }

        It 'Removes a attachment by loaded client object' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
            $ListItem = $List.GetItemById($SPClient.TestConfig.ListItemId)
            $Attachment = $ListItem.AttachmentFiles.GetByFileName('TestAttachment0.txt')
            $SPClient.ClientContext.Load($Attachment)
            $SPClient.ClientContext.ExecuteQuery()
            $Params = @{
                ClientObject = $Attachment
            }
            $Result = Remove-SPClientListItemAttachment @Params
            $Result | Should BeNullOrEmpty
        }

        It 'Removes a attachment by unloaded client object' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
            $ListItem = $List.GetItemById($SPClient.TestConfig.ListItemId)
            $Attachment = $ListItem.AttachmentFiles.GetByFileName('TestAttachment0.txt')
            $Params = @{
                ClientObject = $Attachment
            }
            $Result = Remove-SPClientListItemAttachment @Params
            $Result | Should BeNullOrEmpty
        }

        It 'Removes a attachment by file name' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
            $ListItem = $List.GetItemById($SPClient.TestConfig.ListItemId)
            $Params = @{
                ParentListItem = $ListItem
                FileName = 'TestAttachment0.txt'
            }
            $Result = Remove-SPClientListItemAttachment @Params
            $Result | Should BeNullOrEmpty
        }

    }

    Context 'Failure' {

        It 'Throws an error when the attachment could not be found by file name' {
            $Throw = {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
                $ListItem = $List.GetItemById($SPClient.TestConfig.ListItemId)
                $Params = @{
                    ParentListItem = $ListItem
                    FileName = 'TestAttachment0.txt'
                }
                $Result = Remove-SPClientListItemAttachment @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'The specified attachment could not be found.'
        }

    }

}

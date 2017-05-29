#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'Get-SPClientListItemAttachment' {

    Context 'Success' {

        It 'Returns all attachments' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
            $List = $Web.Lists.GetById($TestConfig.ListId)
            $ListItem = $List.GetItemById($TestConfig.ListItemId)
            $Params = @{
                ParentListItem = $ListItem
            }
            $Result = Get-SPClientListItemAttachment @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.Attachment'
        }

        It 'Returns a list by file name' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
            $List = $Web.Lists.GetById($TestConfig.ListId)
            $ListItem = $List.GetItemById($TestConfig.ListItemId)
            $Params = @{
                ParentListItem = $ListItem
                Name = $TestConfig.AttachmentFileName
            }
            $Result = Get-SPClientListItemAttachment @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.Attachment'
        }

    }

    Context 'Failure' {

        It 'Throws an error when the attachment could not be found by file name' {
            $Throw = {
                $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
                $List = $Web.Lists.GetById($TestConfig.ListId)
                $ListItem = $List.GetItemById($TestConfig.ListItemId)
                $Params = @{
                    ParentListItem = $ListItem
                    Name = 'TestAttachment0.txt'
                }
                $Result = Get-SPClientListItemAttachment @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'The specified attachment could not be found.'
        }

    }

}

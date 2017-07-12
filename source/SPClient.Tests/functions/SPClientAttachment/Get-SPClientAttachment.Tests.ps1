#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'Get-SPClientAttachment' {

    Context 'Success' {

        It 'Returns all attachments' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
            $ListItem = $List.GetItemById($SPClient.TestConfig.ListItemId)
            $Params = @{
                ParentObject = $ListItem
            }
            $Result = Get-SPClientAttachment @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.Attachment'
        }

        It 'Returns a attachment by file name' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
            $ListItem = $List.GetItemById($SPClient.TestConfig.ListItemId)
            $Params = @{
                ParentObject = $ListItem
                Name = $SPClient.TestConfig.AttachmentFileName
            }
            $Result = Get-SPClientAttachment @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.Attachment'
        }

    }

    Context 'Failure' {

        It 'Throws an error when the attachment could not be found by file name' {
            $Throw = {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
                $ListItem = $List.GetItemById($SPClient.TestConfig.ListItemId)
                $Params = @{
                    ParentObject = $ListItem
                    Name = 'TestAttachment0.txt'
                }
                $Result = Get-SPClientAttachment @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'The specified attachment could not be found.'
        }

    }

}

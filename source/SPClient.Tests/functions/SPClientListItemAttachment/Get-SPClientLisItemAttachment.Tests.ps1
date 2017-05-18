#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'Get-SPClientListItemAttachment' {

    Context 'Success' {

        It 'Returns all attachments' {
            $Web = Get-SPClientWeb -Identity $TestConfig.WebId
            $List = Get-SPClientList -ParentObject $Web -Identity $TestConfig.ListId
            $ListItem = Get-SPClientListItem -ParentObject $List -Identity $TestConfig.ListItemId
            $Params = @{
                ParentObject = $ListItem
            }
            $Result = Get-SPClientListItemAttachment @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.Attachment'
        }

        It 'Returns a list by file name' {
            $Web = Get-SPClientWeb -Identity $TestConfig.WebId
            $List = Get-SPClientList -ParentObject $Web -Identity $TestConfig.ListId
            $ListItem = Get-SPClientListItem -ParentObject $List -Identity $TestConfig.ListItemId
            $Params = @{
                ParentObject = $ListItem
                FileName = $TestConfig.AttachmentFileName
            }
            $Result = Get-SPClientListItemAttachment @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.Attachment'
        }

    }

    Context 'Failure' {

        It 'Throws an error when the attachment could not be found by file name' {
            $Throw = {
                $Web = Get-SPClientWeb -Identity $TestConfig.WebId
                $List = Get-SPClientList -ParentObject $Web -Identity $TestConfig.ListId
                $ListItem = Get-SPClientListItem -ParentObject $List -Identity $TestConfig.ListItemId
                $Params = @{
                    ParentObject = $ListItem
                    FileName = 'TestAttachment0.txt'
                }
                $Result = Get-SPClientListItemAttachment @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'The specified attachment could not be found.'
        }

    }

}

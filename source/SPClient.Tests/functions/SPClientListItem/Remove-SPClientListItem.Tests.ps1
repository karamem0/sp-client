#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'Remove-SPClientListItem' {

    Context 'Success' {

        BeforeEach {
            try {
                $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
                $List = Get-SPClientList -ParentObject $Web -Identity $TestConfig.ListId
                $ListItem = New-Object Microsoft.SharePoint.Client.ListItemCreationInformation
                $ListItem = $List.AddItem($ListItem)
                $ListItem['Title'] = 'Test List Item 0'
                $ListItem.Update()
                $SPClient.ClientContext.Load($ListItem)
                $SPClient.ClientContext.ExecuteQuery()
            } catch {
                Write-Host $_ -ForegroundColor Yellow 
            }
        }

        It 'Removes a list item by loaded client object' {
            $Query = `
                '<Where>' + `
                '<Eq>' + `
                '<FieldRef Name="Title" />' + `
                '<Value Type="Text">Test List Item 0</Value>' + `
                '</Eq>' + `
                '</Where>'
            $Web = Get-SPClientWeb -Identity $TestConfig.WebId
            $List = Get-SPClientList -ParentObject $Web -Identity $TestConfig.ListId
            $ListItem = Get-SPClientListItem -ParentObject $List -Query $Query
            $ListItem = $ListItem[0]
            $Params = @{
                ClientObject = $ListItem
            }
            $Result = Remove-SPClientListItem @Params
            $Result | Should BeNullOrEmpty
        }

        It 'Removes a list item by unloaded client object' {
            $Query = `
                '<Where>' + `
                '<Eq>' + `
                '<FieldRef Name="Title" />' + `
                '<Value Type="Text">Test List Item 0</Value>' + `
                '</Eq>' + `
                '</Where>'
            $Web = Get-SPClientWeb -Identity $TestConfig.WebId
            $List = Get-SPClientList -ParentObject $Web -Identity $TestConfig.ListId
            $ListItem = Get-SPClientListItem -ParentObject $List -Query $Query
            $ListItem = $ListItem[0]
            $ListItem = $List.GetItemById($ListItem.Id)
            $Params = @{
                ClientObject = $ListItem
            }
            $Result = Remove-SPClientListItem @Params
            $Result | Should BeNullOrEmpty
        }

        It 'Removes a list item by id' {
            $Query = `
                '<Where>' + `
                '<Eq>' + `
                '<FieldRef Name="Title" />' + `
                '<Value Type="Text">Test List Item 0</Value>' + `
                '</Eq>' + `
                '</Where>'
            $Web = Get-SPClientWeb -Identity $TestConfig.WebId
            $List = Get-SPClientList -ParentObject $Web -Identity $TestConfig.ListId
            $ListItem = Get-SPClientListItem -ParentObject $List -Query $Query
            $ListItem = $ListItem[0]
            $Params = @{
                ParentObject = $List
                Identity = $ListItem.Id
            }
            $Result = Remove-SPClientListItem @Params
            $Result | Should BeNullOrEmpty
        }

    }

    Context 'Failure' {

        It 'Throws an error when the list could not be found by id' {
            $Throw = {
                $Web = Get-SPClientWeb -Identity $TestConfig.WebId
                $List = Get-SPClientList -ParentObject $Web -Identity $TestConfig.ListId
                $Params = @{
                    ParentObject = $List
                    Identity = -1
                }
                $Result = Remove-SPClientListItem @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'The specified list item could not be found.'
        }

    }

}

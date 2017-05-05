#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'Remove-SPClientListItem' {

    BeforeEach {
        try {
            $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
            $List = Get-SPClientList -ParentObject $Web -Identity $TestConfig.ListId
            $ListItem = New-Object Microsoft.SharePoint.Client.ListItemCreationInformation
            $ListItem = $List.AddItem($ListItem)
            $ListItem['Title'] = 'Test List Item 0'
            $ListItem.Update()
            $SPClient.ClientContext.ExecuteQuery()
        } catch {
            Write-Host " [BeforeEach] $($_)" -ForegroundColor Yellow 
        }
    }

    It 'Removes a list item by loaded client object' {
        $Query = `
            '<Query>' + `
            '<Where>' + `
            '<Eq>' + `
            '<FieldRef Name="Title" />' + `
            '<Value Type="Text">Test List Item 0</Value>' + `
            '</Eq>' + `
            '</Where>' + `
            '</Query>'
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
            '<Query>' + `
            '<Where>' + `
            '<Eq>' + `
            '<FieldRef Name="Title" />' + `
            '<Value Type="Text">Test List Item 0</Value>' + `
            '</Eq>' + `
            '</Where>' + `
            '</Query>'
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
            '<Query>' + `
            '<Where>' + `
            '<Eq>' + `
            '<FieldRef Name="Title" />' + `
            '<Value Type="Text">Test List Item 0</Value>' + `
            '</Eq>' + `
            '</Where>' + `
            '</Query>'
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

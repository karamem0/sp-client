#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'Get-SPClientListItem' {

    It 'Returns all list items' {
        $Web = Get-SPClientWeb -Identity $TestConfig.WebId
        $List = Get-SPClientList -ParentObject $Web -Identity $TestConfig.ListId
        $Params = @{
            ParentObject = $List
        }
        $Result = Get-SPClientListItem @Params
        $Result | Should Not BeNullOrEmpty
        $Result | Should BeOfType 'Microsoft.SharePoint.Client.ListItem'
    }

    It 'Returns list items with folder url' {
        $Web = Get-SPClientWeb -Identity $TestConfig.WebId
        $List = Get-SPClientList -ParentObject $Web -Identity $TestConfig.ListId
        $Params = @{
            ParentObject = $List
            FolderUrl = $Web.ServerRelativeUrl.TrimEnd('/') + "/$($TestConfig.ListInternalName)"
        }
        $Result = Get-SPClientListItem @Params
        $Result | Should Not BeNullOrEmpty
        $Result | Should BeOfType 'Microsoft.SharePoint.Client.ListItem'
    }

    It 'Returns list items with scope' {
        $Web = Get-SPClientWeb -Identity $TestConfig.WebId
        $List = Get-SPClientList -ParentObject $Web -Identity $TestConfig.ListId
        $Params = @{
            ParentObject = $List
            Scope = 'Recursive'
        }
        $Result = Get-SPClientListItem @Params
        $Result | Should Not BeNullOrEmpty
        $Result | Should BeOfType 'Microsoft.SharePoint.Client.ListItem'
    }

    It 'Returns list items with view fields' {
        $Web = Get-SPClientWeb -Identity $TestConfig.WebId
        $List = Get-SPClientList -ParentObject $Web -Identity $TestConfig.ListId
        $Params = @{
            ParentObject = $List
            ViewFields = `
                '<ViewFields>' + `
                '<FieldRef Name="ID"/>' + `
                '<FieldRef Name="FileRef"/>' + `
                '</ViewFields>'
        }
        $Result = Get-SPClientListItem @Params
        $Result | Should Not BeNullOrEmpty
        $Result | Should BeOfType 'Microsoft.SharePoint.Client.ListItem'
    }

    It 'Returns list items with row limit' {
        $Web = Get-SPClientWeb -Identity $TestConfig.WebId
        $List = Get-SPClientList -ParentObject $Web -Identity $TestConfig.ListId
        $Params = @{
            ParentObject = $List
            RowLimit = 2
        }
        $Result = Get-SPClientListItem @Params
        $Result | Should Not BeNullOrEmpty
        $Result | Should BeOfType 'Microsoft.SharePoint.Client.ListItem'
        $Result.Count | Should Be 2
    }

    It 'Returns list items with position' {
        $Web = Get-SPClientWeb -Identity $TestConfig.WebId
        $List = Get-SPClientList -ParentObject $Web -Identity $TestConfig.ListId
        $Params = @{
            ParentObject = $List
            RowLimit = 2
        }
        $Result = Get-SPClientListItem @Params
        $Position = $Result.ListItemCollectionPosition
        while ($Position -ne $null) {
            $Params = @{
                ParentObject = $List
                RowLimit = 2
                Position = $Position
            }
            $Result = Get-SPClientListItem @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.ListItem'
            $Position = $Result.ListItemCollectionPosition
        }
    }

    It 'Returns list items with query' {
        $Web = Get-SPClientWeb -Identity $TestConfig.WebId
        $List = Get-SPClientList -ParentObject $Web -Identity $TestConfig.ListId
        $Params = @{
            ParentObject = $List
            Query = `
                '<Query>' + `
                '<Where>' + `
                '<Eq>' + `
                '<FieldRef Name="Title"/>' + `
                '<Value Type="Text">Test List Item 1</Value>' + `
                '</Eq>' + `
                '</Where>' + `
                '</Query>'
        }
        $Result = Get-SPClientListItem @Params
        $Result | Should Not BeNullOrEmpty
        $Result | Should BeOfType 'Microsoft.SharePoint.Client.ListItem'
    }

    It 'Returns a list item by id' {
        $Web = Get-SPClientWeb -Identity $TestConfig.WebId
        $List = Get-SPClientList -ParentObject $Web -Identity $TestConfig.ListId
        $Params = @{
            ParentObject = $List
            Identity = $TestConfig.ListItemId
        }
        $Result = Get-SPClientListItem @Params
        $Result | Should Not BeNullOrEmpty
        $Result | Should BeOfType 'Microsoft.SharePoint.Client.ListItem'
    }

}

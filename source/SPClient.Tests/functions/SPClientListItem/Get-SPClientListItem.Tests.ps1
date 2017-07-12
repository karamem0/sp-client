#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'Get-SPClientListItem' {

    Context 'Success' {

        It 'Returns all list items' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
            $Params = @{
                ParentObject = $List
            }
            $Result = Get-SPClientListItem @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.ListItem'
        }

        It 'Returns list items with folder url' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
            $Params = @{
                ParentObject = $List
                FolderUrl = "$($SPClient.TestConfig.WebUrl)/$($SPClient.TestConfig.ListInternalName)"
            }
            $Result = Get-SPClientListItem @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.ListItem'
        }

        It 'Returns list items with scope' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
            $Params = @{
                ParentObject = $List
                Scope = 'Recursive'
            }
            $Result = Get-SPClientListItem @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.ListItem'
        }

        It 'Returns list items with view column names' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
            $Params = @{
                ParentObject = $List
                ViewFields = @('ID', 'FileRef')
            }
            $Result = Get-SPClientListItem @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.ListItem'
        }

        It 'Returns list items with view column client objects' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
            $Params = @{
                ParentObject = $List
                ViewFields = @(
                    $List.Fields.GetByInternalNameOrTitle('ID')
                    $List.Fields.GetByInternalNameOrTitle('FileRef')
                )
            }
            $Result = Get-SPClientListItem @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.ListItem'
        }

        It 'Returns list items with row limit' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
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
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
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

        It 'Returns list items with simple query' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
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

        It 'Returns list items with complexed query' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
            $Params = @{
                ParentObject = $List
                Query = `
                    '<Where>' + `
                    '<Eq>' + `
                    '<FieldRef Name="Title"/>' + `
                    '<Value Type="Text">Test List Item 1</Value>' + `
                    '</Eq>' + `
                    '</Where>' + `
                    '<OrderBy>' + `
                    '<FieldRef Name="Title" Ascending="FALSE"/>' + `
                    '</OrderBy>'
            }
            $Result = Get-SPClientListItem @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.ListItem'
        }

        It 'Returns a list item by id' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
            $Params = @{
                ParentObject = $List
                Identity = $SPClient.TestConfig.ListItemId
            }
            $Result = Get-SPClientListItem @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.ListItem'
        }

        It 'Returns a list item by guid' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
            $Params = @{
                ParentObject = $List
                IdentityGuid = $SPClient.TestConfig.ListItemUniqueId
            }
            $Result = Get-SPClientListItem @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.ListItem'
        }

    }

    Context 'Failure' {

        It 'Throws an error when the list could not be found by id' {
            $Throw = {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
                $Params = @{
                    ParentObject = $List
                    Identity = -1
                }
                $Result = Get-SPClientListItem @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'The specified list item could not be found.'
        }

        It 'Throws an error when the list could not be found by guid' {
            $Throw = {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
                $Params = @{
                    ParentObject = $List
                    IdentityGuid = '95BBF208-A139-4E6B-BB8C-B7D1BC7CFB60'
                }
                $Result = Get-SPClientListItem @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'The specified list item could not be found.'
        }

    }

}

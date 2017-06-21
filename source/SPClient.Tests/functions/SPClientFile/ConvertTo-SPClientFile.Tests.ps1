#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'ConvertTo-SPClientFile' {

    Context 'Success' {

        It 'Converts a list item to file' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $List = $Web.Lists.GetById($SPClient.TestConfig.DocLibId)
            $Caml = New-object Microsoft.SharePoint.Client.CamlQuery
            $Caml.ViewXml =  `
                '<View Scope="RecursiveAll">' + `
                '<RowLimit>1</RowLimit>' + `
                '<Query>' + `
                '<Where>' + `
                '<Eq>' + `
                '<FieldRef Name="UniqueId"/>' + `
                '<Value Type="Guid">' + $SPClient.TestConfig.FileId + '</Value>' + `
                '</Eq>' + `
                '</Where>' + `
                '</Query>' + `
                '</View>'
            $ListItems = $List.GetItems($Caml)
            $SPClient.ClientContext.Load($ListItems)
            $SPClient.ClientContext.ExecuteQuery()
            $ListItem = $ListItems[0]
            $Params = @{
                ListItem = $ListItem
            }
            $Result = ConvertTo-SPClientFile @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.File'
            $Result.Name | Should Be $SPClient.TestConfig.FileName
        }

    }

    Context 'Failure' {

        It 'Throws an error when the list item is a folder' {
            $Throw = {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $List = $Web.Lists.GetById($SPClient.TestConfig.DocLibId)
                $Caml = New-object Microsoft.SharePoint.Client.CamlQuery
                $Caml.ViewXml =  `
                    '<View Scope="RecursiveAll">' + `
                    '<RowLimit>1</RowLimit>' + `
                    '<Query>' + `
                    '<Where>' + `
                    '<Eq>' + `
                    '<FieldRef Name="UniqueId"/>' + `
                    '<Value Type="Guid">' + $SPClient.TestConfig.FolderId + '</Value>' + `
                    '</Eq>' + `
                    '</Where>' + `
                    '</Query>' + `
                    '</View>'
                $ListItems = $List.GetItems($Caml)
                $SPClient.ClientContext.Load($ListItems)
                $SPClient.ClientContext.ExecuteQuery()
                $ListItem = $ListItems[0]
                $Params = @{
                    ListItem = $ListItem
                }
                $Result = ConvertTo-SPClientFile @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'Cannot convert list item to file because it is a folder or it is located in a document library.'
        }

        It 'Throws an error when the list item is not located in a document library' {
            $Throw = {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
                $ListItem = $List.GetItemById($SPClient.TestConfig.ListItemId)
                $Params = @{
                    ListItem = $ListItem
                }
                $Result = ConvertTo-SPClientFile @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'Cannot convert list item to file because it is a folder or it is located in a document library.'
        }

    }

}

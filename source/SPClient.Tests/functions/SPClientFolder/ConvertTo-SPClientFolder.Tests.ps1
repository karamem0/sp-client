#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'ConvertTo-SPClientFolder' {

    Context 'Success' {

        It 'Converts a list item to folder' {
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
                InputObject = $ListItem
            }
            $Result = ConvertTo-SPClientFolder @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.Folder'
            $Result.Name | Should Be $SPClient.TestConfig.FolderName
        }

    }

    Context 'Failure' {

        It 'Throws an error when the list item is a file' {
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
                    InputObject = $ListItem
                }
                $Result = ConvertTo-SPClientFolder @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'Cannot convert list item to folder because it is not a folder.'
        }

    }


}

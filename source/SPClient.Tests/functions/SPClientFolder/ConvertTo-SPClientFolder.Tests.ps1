#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'ConvertTo-SPClientFolder' {

    Context 'Success' {

        It 'Converts a list item to folder' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
            $List = $Web.Lists.GetById($TestConfig.DocLibId)
            $Caml = New-object Microsoft.SharePoint.Client.CamlQuery
            $Caml.ViewXml =  `
                '<View Scope="RecursiveAll">' + `
                '<RowLimit>1</RowLimit>' + `
                '<Query>' + `
                '<Where>' + `
                '<Eq>' + `
                '<FieldRef Name="UniqueId"/>' + `
                '<Value Type="Guid">' + $TestConfig.FolderId + '</Value>' + `
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
            $Result = ConvertTo-SPClientFolder @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.Folder'
            $Result.Name | Should Be $TestConfig.FolderName
        }

    }

    Context 'Failure' {

        It 'Throws an error when the list item is a file' {
            $Throw = {
                $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
                $List = $Web.Lists.GetById($TestConfig.DocLibId)
                $Caml = New-object Microsoft.SharePoint.Client.CamlQuery
                $Caml.ViewXml =  `
                    '<View Scope="RecursiveAll">' + `
                    '<RowLimit>1</RowLimit>' + `
                    '<Query>' + `
                    '<Where>' + `
                    '<Eq>' + `
                    '<FieldRef Name="UniqueId"/>' + `
                    '<Value Type="Guid">' + $TestConfig.FileId + '</Value>' + `
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
                $Result = ConvertTo-SPClientFolder @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'Cannot convert list item to folder because it is not a folder.'
        }

    }


}

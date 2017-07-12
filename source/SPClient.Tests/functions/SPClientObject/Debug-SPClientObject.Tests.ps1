#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'Debug-SPClientObject' {

    Context 'Success' {

        It 'Dumps a site' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $SPClient.ClientContext.Load($Web)
            $SPClient.ClientContext.ExecuteQuery()
            $Params = @{
                InputObject = $Web
            }
            $Result = Debug-SPClientObject @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'System.Collections.Generic.Dictionary`2[string,object]'
        }

        It 'Dumps a list collection' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $ListCollection = $Web.Lists
            $SPClient.ClientContext.Load($ListCollection)
            $SPClient.ClientContext.ExecuteQuery()
            $Params = @{
                InputObject = $ListCollection
            }
            $Result = Debug-SPClientObject @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'System.Collections.Generic.Dictionary`2[string,object]'
        }

        It 'Dumps a site with hierarchy' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $SPClient.ClientContext.Load($Web)
            $SPClient.ClientContext.Load($Web.RootFolder)
            $SPClient.ClientContext.Load($Web.Lists)
            $SPClient.ClientContext.ExecuteQuery()
            $Params = @{
                InputObject = $Web
            }
            $Result = Debug-SPClientObject @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'System.Collections.Generic.Dictionary`2[string,object]'
        }

        It 'Dumps a list item' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
            $ListItem = $List.GetItemById($SPClient.TestConfig.ListItemId)
            $SPClient.ClientContext.Load($ListItem)
            $SPClient.ClientContext.ExecuteQuery()
            $Params = @{
                InputObject = $ListItem
            }
            $Result = Debug-SPClientObject @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'System.Collections.Generic.Dictionary`2[string,object]'
        }

    }

}

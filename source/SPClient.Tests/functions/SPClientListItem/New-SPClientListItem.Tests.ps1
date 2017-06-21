#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'New-SPClientListItem' {

    Context 'Success' {

        AfterEach {
            try {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
                $Caml = New-Object Microsoft.SharePoint.Client.CamlQuery
                $Caml.ViewXml = `
                    '<View>' + `
                    '<Query>' + `
                    '<Where>' + `
                    '<Eq>' + `
                    '<FieldRef Name="Title" />' + `
                    '<Value Type="Text">Test List Item 0</Value>' + `
                    '</Eq>' + `
                    '</Where>' + `
                    '</Query>' + `
                    '</View>'
                $ListItems = $List.GetItems($Caml)
                $SPClient.ClientContext.Load($ListItems)
                $SPClient.ClientContext.ExecuteQuery()
                foreach ($ListItem in $ListItems) {
                    $ListItem = $List.GetItemById($ListItem.Id)
                    $ListItem.DeleteObject()
                    $SPClient.ClientContext.ExecuteQuery()
                }
            } catch {
                Write-Host $_ -ForegroundColor Yellow 
            }
        }

        It 'Creates a new list item with mandatory parameters' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
            $Params = @{
                ParentList = $List
                FieldValues = @{
                    Title = 'Test List Item 0'
                }
            }
            $Result = New-SPClientListItem @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.ListItem'
        }

        It 'Creates a new list item with all parameters' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
            $Params = @{
                ParentList = $List
                FieldValues = @{
                    Title = 'Test List Item 0'
                    TestField1 = 'Test List Item 0'
                    TestField2 = 'Test List Item 0'
                    TestField3 = 'Test Value 1'
                    TestField5 = 4
                    TestField6 = 5
                    TestField7 = [datetime]::UtcNow.Date
                }
            }
            $Result = New-SPClientListItem @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.ListItem'
            $Result['Title'] | Should Be 'Test List Item 0'
            $Result['TestField1'] | Should Be 'Test List Item 0'
            $Result['TestField2'] | Should Be 'Test List Item 0'
            $Result['TestField3'] | Should Be 'Test Value 1'
            $Result['TestField5'] | Should Be 4
            $Result['TestField6'] | Should Be 5
            $Result['TestField7'] | Should Be $([datetime]::UtcNow.Date)
        }

    }

}

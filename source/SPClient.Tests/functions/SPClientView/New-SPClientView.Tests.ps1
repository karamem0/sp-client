#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'New-SPClientView' {

    Context 'Success' {

        AfterEach {
            try {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
                $SPClient.ClientContext.Load($List.Views)
                $SPClient.ClientContext.ExecuteQuery()
                for ($index = $List.Views.Count - 1; $index -ge 0; $index--) {
                    $View = $List.Views[$index]
                    $SPClient.ClientContext.Load($View)
                    $SPClient.ClientContext.ExecuteQuery()
                    if ($View.ServerRelativeUrl -like '*/TestView0.aspx') {
                        $View.DeleteObject()
                        $SPClient.ClientContext.ExecuteQuery()
                    }
                }
            } catch {
                Write-Host $_ -ForegroundColor Yellow 
            }
        }

        It 'Creates a new view with mandatory parameters' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
            $Params = @{
                ParentList = $List
                Name = 'TestView0'
            }
            $Result = New-SPClientView @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.View'
            $Result.Title | Should Be 'TestView0'
            $Result.Paged | Should Be $false
            $Result.RowLimit | Should Be 0
            $Result.ViewType | Should Be 'HTML'
            $Result.PersonalView | Should Be $false
        }

        It 'Creates a new view with all parameters' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
            $Params = @{
                ParentList = $List
                Name = 'TestView0'
                Title = 'Test View 0'
                ViewFields = @('ID', 'Title')
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
                RowLimit = 2
                Paged = $true
                SetAsDefaultView = $true
                ViewType = 'Grid'
                PersonalView = $false
            }
            $Result = New-SPClientView @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.View'
            $Result.Title | Should Be 'Test View 0'
            $Result.Paged | Should Be $true
            $Result.RowLimit | Should Be 2
            $Result.ViewType | Should Be 'GRID'
            $Result.PersonalView | Should Be $false
        }

    }

}

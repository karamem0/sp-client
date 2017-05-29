#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'Remove-SPClientView' {

    Context 'Success' {

        BeforeEach {
            try {
                $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
                $List = $Web.Lists.GetById($TestConfig.ListId)
                $View = New-Object Microsoft.SharePoint.Client.ViewCreationInformation
                $View.Title = 'TestView0'
                $View.ViewFields = @('ID', 'Title')
                $View = $List.Views.Add($View)
                $View.Title = 'Test View 0'
                $View.Update()
                $SPClient.ClientContext.Load($View)
                $SPClient.ClientContext.ExecuteQuery()
            } catch {
                Write-Host $_ -ForegroundColor Yellow 
            }
        }

        It 'Removes a view by loaded client object' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
            $List = $Web.Lists.GetById($TestConfig.ListId)
            $View = $List.Views.GetByTitle('Test View 0')
            $SPClient.ClientContext.Load($View)
            $SPClient.ClientContext.ExecuteQuery()
            $Params = @{
                ClientObject = $View
            }
            $Result = Remove-SPClientView @Params
            $Result | Should BeNullOrEmpty
        }

        It 'Removes a view by unloaded client object' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
            $List = $Web.Lists.GetById($TestConfig.ListId)
            $View = $List.Views.GetByTitle('Test View 0')
            $Params = @{
                ClientObject = $View
            }
            $Result = Remove-SPClientView @Params
            $Result | Should BeNullOrEmpty
        }

        It 'Removes a view by id' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
            $List = $Web.Lists.GetById($TestConfig.ListId)
            $View = $List.Views.GetByTitle('Test View 0')
            $SPClient.ClientContext.Load($View)
            $SPClient.ClientContext.ExecuteQuery()
            $Params = @{
                ParentList = $List
                Identity = $View.Id
            }
            $Result = Remove-SPClientView @Params
            $Result | Should BeNullOrEmpty
        }

        It 'Removes a view by url' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
            $List = $Web.Lists.GetById($TestConfig.ListId)
            $Params = @{
                ParentList = $List
                Url = "$($TestConfig.ListUrl)/TestView0.aspx"
            }
            $Result = Remove-SPClientView @Params
            $Result | Should BeNullOrEmpty
        }

        It 'Removes a view by title' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
            $List = $Web.Lists.GetById($TestConfig.ListId)
            $Params = @{
                ParentList = $List
                Title = 'Test View 0'
            }
            $Result = Remove-SPClientView @Params
            $Result | Should BeNullOrEmpty
        }

    }

    Context 'Failure' {

        It 'Throws an error when the view could not be found by id' {
            $Throw = {
                $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
                $List = $Web.Lists.GetById($TestConfig.ListId)
                $Params = @{
                    ParentList = $List
                    Identity = '538BAEA3-24BE-4411-AA54-4700C5735AF7'
                }
                $Result = Remove-SPClientView @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'The specified view could not be found.'
        }

        It 'Throws an error when the view could not be found by url' {
            $Throw = {
                $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
                $List = $Web.Lists.GetById($TestConfig.ListId)
                $Params = @{
                    ParentList = $List
                    Url = "$($TestConfig.ListUrl)/TestView0.aspx"
                }
                $Result = Remove-SPClientView @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'The specified view could not be found.'
        }

        It 'Throws an error when the view could not be found by title' {
            $Throw = {
                $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
                $List = $Web.Lists.GetById($TestConfig.ListId)
                $Params = @{
                    ParentList = $List
                    Title = 'Test View 0'
                }
                $Result = Remove-SPClientView @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'The specified view could not be found.'
        }

    }

}

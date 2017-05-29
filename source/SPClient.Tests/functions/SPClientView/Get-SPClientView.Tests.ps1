#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'Get-SPClientView' {

    Context 'Success' {

        It 'Gets all views' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
            $List = $Web.Lists.GetById($TestConfig.ListId)
            $Params = @{
                ParentList = $List
            }
            $Result = Get-SPClientView @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.View'
        }

        It 'Gets a view by id' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
            $List = $Web.Lists.GetById($TestConfig.ListId)
            $Params = @{
                ParentList = $List
                Identity = $TestConfig.ViewId
            }
            $Result = Get-SPClientView @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.View'
        }

        It 'Gets a view by url' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
            $List = $Web.Lists.GetById($TestConfig.ListId)
            $Params = @{
                ParentList = $List
                Url = $TestConfig.ViewUrl
            }
            $Result = Get-SPClientView @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.View'
        }

        It 'Gets a view by title' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
            $List = $Web.Lists.GetById($TestConfig.ListId)
            $Params = @{
                ParentList = $List
                Title = $TestConfig.ViewTitle
            }
            $Result = Get-SPClientView @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.View'
        }

        It 'Gets the default view' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
            $List = $Web.Lists.GetById($TestConfig.ListId)
            $Params = @{
                ParentList = $List
                Default = $true
            }
            $Result = Get-SPClientView @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.View'
        }

    }

    Context 'Failure' {

        It 'Throws an error when the view could not be found by id' {
            $Throw = {
                $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
                $List = $Web.Lists.GetById($TestConfig.ListId)
                $Params = @{
                    ParentList = $List
                    Identity = [guid]::Empty
                }
                $Result = Get-SPClientView @Params
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
                $Result = Get-SPClientView @Params
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
                $Result = Get-SPClientView @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'The specified view could not be found.'
        }

    }

}

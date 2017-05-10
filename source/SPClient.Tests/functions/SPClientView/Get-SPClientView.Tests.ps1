#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'Get-SPClientView' {

    Context 'Success' {

        It 'Gets all views' {
            $Web = Get-SPClientWeb -Identity $TestConfig.WebId
            $List = Get-SPClientList -ParentObject $web -Identity $TestConfig.ListId
            $Params = @{
                ParentObject = $List
            }
            $Result = Get-SPClientView @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.View'
        }

        It 'Gets a view by id' {
            $Web = Get-SPClientWeb -Identity $TestConfig.WebId
            $List = Get-SPClientList -ParentObject $web -Identity $TestConfig.ListId
            $Params = @{
                ParentObject = $List
                Identity = $TestConfig.ViewId
            }
            $Result = Get-SPClientView @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.View'
        }

        It 'Gets a view by url' {
            $Web = Get-SPClientWeb -Identity $TestConfig.WebId
            $List = Get-SPClientList -ParentObject $web -Identity $TestConfig.ListId
            $Params = @{
                ParentObject = $List
                Url = $TestConfig.ViewUrl
            }
            $Result = Get-SPClientView @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.View'
        }

        It 'Gets a view by title' {
            $Web = Get-SPClientWeb -Identity $TestConfig.WebId
            $List = Get-SPClientList -ParentObject $web -Identity $TestConfig.ListId
            $Params = @{
                ParentObject = $List
                Title = $TestConfig.ViewTitle
            }
            $Result = Get-SPClientView @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.View'
        }

        It 'Gets the default view' {
            $Web = Get-SPClientWeb -Identity $TestConfig.WebId
            $List = Get-SPClientList -ParentObject $web -Identity $TestConfig.ListId
            $Params = @{
                ParentObject = $List
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
                $Web = Get-SPClientWeb -Identity $TestConfig.WebId
                $List = Get-SPClientList -ParentObject $web -Identity $TestConfig.ListId
                $Params = @{
                    ParentObject = $List
                    Identity = [guid]::Empty
                }
                $Result = Get-SPClientView @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'The specified view could not be found.'
        }

        It 'Throws an error when the view could not be found by url' {
            $Throw = {
                $Web = Get-SPClientWeb -Identity $TestConfig.WebId
                $List = Get-SPClientList `
                    -ParentObject $Web `
                    -Identity $TestConfig.ListId `
                    -Retrievals 'RootFolder.ServerRelativeUrl'
                $Params = @{
                    ParentObject = $List
                    Url = "$($TestConfig.ListUrl)/TestView0.aspx"
                }
                $Result = Get-SPClientView @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'The specified view could not be found.'
        }

        It 'Throws an error when the view could not be found by title' {
            $Throw = {
                $Web = Get-SPClientWeb -Identity $TestConfig.WebId
                $List = Get-SPClientList -ParentObject $web -Identity $TestConfig.ListId
                $Params = @{
                    ParentObject = $List
                    Title = 'Test View 0'
                }
                $Result = Get-SPClientView @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'The specified view could not be found.'
        }

    }

}

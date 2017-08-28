#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'Get-SPClientList' {

    Context 'Success' {

        It 'Returns all lists' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $Params = @{
                ParentObject = $Web
            }
            $Result = Get-SPClientList @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.List'
        }

        It 'Returns a list by id' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $Params = @{
                ParentObject = $Web
                Identity = $SPClient.TestConfig.ListId
            }
            $Result = Get-SPClientList @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.List'
            $Result.Id | Should Be $SPClient.TestConfig.ListId
        }

        It 'Returns a list by relative url' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $Params = @{
                ParentObject = $Web
                Url = $SPClient.TestConfig.ListUrl
                Retrieval = 'Title,RootFolder.ServerRelativeUrl'
            }
            $Result = Get-SPClientList @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.List'
            $Result.RootFolder.ServerRelativeUrl | Should Be $SPClient.TestConfig.ListUrl
        }

        It 'Returns a list by absolute url' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $Params = @{
                ParentObject = $Web
                Url = $SPClient.TestConfig.RootUrl + $SPClient.TestConfig.ListUrl
                Retrieval = 'Title,RootFolder.ServerRelativeUrl'
            }
            $Result = Get-SPClientList @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.List'
            $Result.RootFolder.ServerRelativeUrl | Should Be $SPClient.TestConfig.ListUrl  
        }

        It 'Returns a list by title' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $Params = @{
                ParentObject = $Web
                Name = $SPClient.TestConfig.ListTitle
            }
            $Result = Get-SPClientList @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.List'
            $Result.Title | Should Be $SPClient.TestConfig.ListTitle
        }

        It 'Returns a list by internal name' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $Params = @{
                ParentObject = $Web
                Name = $SPClient.TestConfig.ListName
                Retrieval = 'Title,RootFolder.Name'
            }
            $Result = Get-SPClientList @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.List'
            $Result.RootFolder.Name | Should Be $SPClient.TestConfig.ListName
        }

    }

    Context 'Failure' {

        It 'Throws an error when the list could not be found by id' {
            $Throw = {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $Params = @{
                    ParentObject = $Web
                    Identity = '080F7947-C4F0-4796-A055-D3FDEE1E9D82'
                }
                $Result = Get-SPClientList @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'The specified list could not be found.'
        }

        It 'Throws an error when the list could not be found by url' {
            $Throw = {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $Params = @{
                    ParentObject = $Web
                    Url = "$($SPClient.TestConfig.WebUrl)/Lists/TestList0"
                }
                $Result = Get-SPClientList @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'The specified list could not be found.'
        }

        It 'Throws an error when the list could not be found by name' {
            $Throw = {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $Params = @{
                    ParentObject = $Web
                    Name = 'TestList0'
                }
                $Result = Get-SPClientList @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'The specified list could not be found.'
        }

    }

}

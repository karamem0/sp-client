#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'Get-SPClientList' {

    Context 'Success' {

        It 'Returns all lists' {
            $Web = Get-SPClientWeb -Identity $TestConfig.WebId
            $Params = @{
                ParentObject = $Web
            }
            $Result = Get-SPClientList @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.List'
        }

        It 'Returns a list by id' {
            $Web = Get-SPClientWeb -Identity $TestConfig.WebId
            $Params = @{
                ParentObject = $Web
                Identity = $TestConfig.ListId
            }
            $Result = Get-SPClientList @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.List'
            $Result.Id | Should Be $Params.Identity
        }

        It 'Returns a list by url' {
            $Web = Get-SPClientWeb -Identity $TestConfig.WebId
            $Params = @{
                ParentObject = $Web
                Url = $TestConfig.ListUrl
                Retrievals = 'Title,RootFolder.ServerRelativeUrl'
            }
            $Result = Get-SPClientList @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.List'
            $Result.RootFolder.ServerRelativeUrl | Should Be $Params.Url   
        }

        It 'Returns a list by title' {
            $Web = Get-SPClientWeb -Identity $TestConfig.WebId
            $Params = @{
                ParentObject = $Web
                Name = $TestConfig.ListTitle
            }
            $Result = Get-SPClientList @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.List'
            $Result.Title | Should Be $Params.Name
        }

        It 'Returns a list by internal name' {
            $Web = Get-SPClientWeb -Identity $TestConfig.WebId
            $Params = @{
                ParentObject = $Web
                Name = $TestConfig.ListName
                Retrievals = 'Title,RootFolder.Name'
            }
            $Result = Get-SPClientList @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.List'
            $Result.RootFolder.Name | Should Be $Params.Name 
        }

    }

    Context 'Failure' {

        It 'Throws an error when the list could not be found by id' {
            $Throw = {
                $Web = Get-SPClientWeb -Identity $TestConfig.WebId
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
                $Web = Get-SPClientWeb -Identity $TestConfig.WebId
                $Params = @{
                    ParentObject = $Web
                    Url = "$($TestConfig.WebUrl)/Lists/TestList0"
                }
                $Result = Get-SPClientList @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'The specified list could not be found.'
        }

        It 'Throws an error when the list could not be found by name' {
            $Throw = {
                $Web = Get-SPClientWeb -Identity $TestConfig.WebId
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

#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'Remove-SPClientList' {

    Context 'Success' {

        BeforeEach {
            try {
                $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
                $List = New-Object Microsoft.SharePoint.Client.ListCreationInformation
                $List.Title = 'TestList0'
                $List.TemplateType = 100
                $List = $Web.Lists.Add($List)
                $List.Title = 'Test List 0'
                $List.Update()
                $SPClient.ClientContext.Load($List)
                $SPClient.ClientContext.ExecuteQuery()
            } catch {
                Write-Host $_ -ForegroundColor Yellow 
            }
        }

        It 'Removes a list by loaded client object' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
            $List = $Web.Lists.GetByTitle('Test List 0')
            $SPClient.ClientContext.Load($List)
            $SPClient.ClientContext.ExecuteQuery()
            $Params = @{
                ClientObject = $List
            }
            $Result = Remove-SPClientList @Params
            $Result | Should BeNullOrEmpty
        }

        It 'Removes a list by unloaded client object' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
            $List = $Web.Lists.GetByTitle('Test List 0')
            $Params = @{
                ClientObject = $List
            }
            $Result = Remove-SPClientList @Params
            $Result | Should BeNullOrEmpty
        }

        It 'Removes a list by id' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
            $List = $Web.Lists.GetByTitle('Test List 0')
            $SPClient.ClientContext.Load($List)
            $SPClient.ClientContext.ExecuteQuery()
            $Params = @{
                ParentWeb = $Web
                Identity = $List.Id
            }
            $Result = Remove-SPClientList @Params
            $Result | Should BeNullOrEmpty
        }

        It 'Removes a list by url' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
            $Params = @{
                ParentWeb = $Web
                Url = "$($TestConfig.WebUrl)/Lists/TestList0"
            }
            $Result = Remove-SPClientList @Params
            $Result | Should BeNullOrEmpty
        }

        It 'Removes a list by title' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
            $Params = @{
                ParentWeb = $Web
                Name = 'Test List 0'
            }
            $Result = Remove-SPClientList @Params
            $Result | Should BeNullOrEmpty
        }

        It 'Removes a list by internal name' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
            $Params = @{
                ParentWeb = $Web
                Name = 'TestList0'
            }
            $Result = Remove-SPClientList @Params
            $Result | Should BeNullOrEmpty
        }

    }

    Context 'Failure' {

        It 'Throws an error when the list could not be found by id' {
            $Throw = {
                $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
                $Params = @{
                    ParentWeb = $Web
                    Identity = '080F7947-C4F0-4796-A055-D3FDEE1E9D82'
                }
                $Result = Remove-SPClientList @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'The specified list could not be found.'
        }

        It 'Throws an error when the list could not be found by url' {
            $Throw = {
                $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
                $Params = @{
                    ParentWeb = $Web
                    Url = "$($TestConfig.WebUrl)/Lists/TestList0"
                }
                $Result = Remove-SPClientList @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'The specified list could not be found.'
        }

        It 'Throws an error when the list could not be found by name' {
            $Throw = {
                $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
                $Params = @{
                    ParentWeb = $Web
                    Name = 'TestList0'
                }
                $Result = Remove-SPClientList @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'The specified list could not be found.'
        }

    }

}

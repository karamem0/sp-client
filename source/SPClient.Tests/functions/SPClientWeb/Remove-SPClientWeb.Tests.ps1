#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'Remove-SPClientWeb' {

    Context 'Success' {

        BeforeEach {
            try {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $WebCollection = $Web.Webs
                $Web = New-Object Microsoft.SharePoint.Client.WebCreationInformation
                $Web.Url = 'TestWeb0'
                $Web.Language = '1033'
                $Web.WebTemplate = 'STS#1'
                $Web.Title = 'Test Web 0'
                $Web.Description = ''
                $Web = $WebCollection.Add($Web)
                $Web.Update()
                $SPClient.ClientContext.Load($Web)
                $SPClient.ClientContext.ExecuteQuery()
            } catch {
                Write-Host $_ -ForegroundColor Yellow 
            }
        }

        It 'Removes a site by loaded client object' {
            $Web = $SPClient.ClientContext.Site.OpenWeb("$($SPClient.TestConfig.WebUrl)/TestWeb0")
            $SPClient.ClientContext.Load($Web)
            $SPClient.ClientContext.ExecuteQuery()
            $Params = @{
                ClientObject = $Web
            }
            $Result = Remove-SPClientWeb @Params
            $Result | Should BeNullOrEmpty
        }

        It 'Removes a site by unloaded client object' {
            $Web = $SPClient.ClientContext.Site.OpenWeb("$($SPClient.TestConfig.WebUrl)/TestWeb0")
            $Params = @{
                ClientObject = $Web
            }
            $Result = Remove-SPClientWeb @Params
            $Result | Should BeNullOrEmpty
        }

        It 'Removes a site by id' {
            $Web = $SPClient.ClientContext.Site.OpenWeb("$($SPClient.TestConfig.WebUrl)/TestWeb0")
            $SPClient.ClientContext.Load($Web)
            $SPClient.ClientContext.ExecuteQuery()
            $Params = @{
                Identity = $Web.Id
            }
            $Result = Remove-SPClientWeb @Params
            $Result | Should BeNullOrEmpty
        }

        It 'Removes a site by relative url' {
            $Web = $SPClient.ClientContext.Site.OpenWeb("$($SPClient.TestConfig.WebUrl)/TestWeb0")
            $SPClient.ClientContext.Load($Web)
            $SPClient.ClientContext.ExecuteQuery()
            $Params = @{
                Url = $Web.ServerRelativeUrl
            }
            $Result = Remove-SPClientWeb @Params
            $Result | Should BeNullOrEmpty
        }

        It 'Removes a site by absolute url' {
            $Web = $SPClient.ClientContext.Site.OpenWeb("$($SPClient.TestConfig.WebUrl)/TestWeb0")
            $SPClient.ClientContext.Load($Web)
            $SPClient.ClientContext.ExecuteQuery()
            $Params = @{
                Url = $SPClient.TestConfig.RootUrl + $Web.ServerRelativeUrl
            }
            $Result = Remove-SPClientWeb @Params
            $Result | Should BeNullOrEmpty
        }

    }

    Context 'Failure' {

        It 'Throws an error when the site could not be found by id' {
            $Throw = {
                $Params = @{
                    Identity = 'C89E2D46-4542-4A29-9FBC-01FFA1FBECDD'
                }
                $Result = Remove-SPClientWeb @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'The specified site could not be found.'
        }

        It 'Throws an error when the site could not be found by url' {
            $Throw = {
                $Params = @{
                    Url = "$($SPClient.TestConfig.WebUrl)/TestWeb0"
                }
                $Result = Remove-SPClientWeb @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'The specified site could not be found.'
        }

    }

}

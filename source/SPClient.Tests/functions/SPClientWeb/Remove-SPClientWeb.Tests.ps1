#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'Remove-SPClientWeb' {

    Context 'Success' {

        BeforeEach {
            try {
                $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
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

        It 'Removes a web by loaded client object' {
            $Web = Get-SPClientWeb -Url "$($TestConfig.WebUrl)/TestWeb0"
            $Params = @{
                ClientObject = $Web
            }
            $Result = Remove-SPClientWeb @Params
            $Result | Should BeNullOrEmpty
        }

        It 'Removes a web by unloaded client object' {
            $PathMethod = New-Object Microsoft.SharePoint.Client.ObjectPathMethod( `
                $SPClient.ClientContext, `
                $SPClient.ClientContext.Site.Path, `
                'OpenWeb', `
                [object[]]"$($TestConfig.WebUrl)/TestWeb0")
            $Web = New-Object Microsoft.SharePoint.Client.Web($SPClient.ClientContext, $PathMethod);
            $Params = @{
                ClientObject = $Web
            }
            $Result = Remove-SPClientWeb @Params
            $Result | Should BeNullOrEmpty
        }

        It 'Removes a web by id' {
            $Web = Get-SPClientWeb -Url "$($TestConfig.WebUrl)/TestWeb0"
            $Params = @{
                Identity = $Web.Id
            }
            $Result = Remove-SPClientWeb @Params
            $Result | Should BeNullOrEmpty
        }

        It 'Removes a web by url' {
            $Web = Get-SPClientWeb -Url "$($TestConfig.WebUrl)/TestWeb0"
            $Params = @{
                Url = $Web.ServerRelativeUrl
            }
            $Result = Remove-SPClientWeb @Params
            $Result | Should BeNullOrEmpty
        }

    }

    Context 'Failure' {

        It 'Throws an error when the web could not be found by id' {
            $Throw = {
                $Params = @{
                    Identity = 'C89E2D46-4542-4A29-9FBC-01FFA1FBECDD'
                }
                $Result = Remove-SPClientWeb @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'The specified web could not be found.'
        }

        It 'Throws an error when the web could not be found by url' {
            $Throw = {
                $Params = @{
                    Url = "$($TestConfig.WebUrl)/TestWeb0"
                }
                $Result = Remove-SPClientWeb @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'The specified web could not be found.'
        }

    }

}

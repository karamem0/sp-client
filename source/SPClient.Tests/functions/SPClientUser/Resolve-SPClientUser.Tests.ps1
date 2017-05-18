#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'Resolve-SPClientUser' {

    Context 'Success' {

        AfterEach {
            try {
                $Web = $SPClient.ClientContext.Site.RootWeb
                $User = $Web.SiteUsers.GetByEmail("testuser0@$($Env:LoginDomain)")
                $Web.SiteUsers.Remove($User)
                $SPClient.ClientContext.ExecuteQuery()
            } catch {
                Write-Host $_ -ForegroundColor Yellow 
            }
        }

        It 'Resolves a user exists on the web' {
            $Params = @{
                Name = "testuser1@$($Env:LoginDomain)"
            }
            $Result = Resolve-SPClientUser @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.User'
        }

        It 'Resolves a user does not exist on the web' {
            $Params = @{
                Name = "testuser0@$($Env:LoginDomain)"
            }
            $Result = Resolve-SPClientUser @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.User'
        }

    }

    Context 'Failure' {

        It 'Throws an error when the user could not be found' {
            $Throw = {
                $Params = @{
                    Name = "testuser4@$($Env:LoginDomain)"
                }
                $Result = Resolve-SPClientUser @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'The specified user could not be found.'
        }

    }

}

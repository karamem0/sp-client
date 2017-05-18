#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'Remove-SPClientUser' {

    Context 'Success' {

        BeforeEach {
            try {
                $Web = $SPClient.ClientContext.Site.RootWeb
                $User = New-Object Microsoft.SharePoint.Client.UserCreationInformation
                $User.LoginName = "i:0#.f|membership|testuser0@$($Env:LoginDomain)"
                $User.Title = 'Test User 0'
                $User.Email = "testuser0@$($Env:LoginDomain)"
                $User = $Web.SiteUsers.Add($User)
                $User.Update()
                $SPClient.ClientContext.Load($User)
                $SPClient.ClientContext.ExecuteQuery()
            } catch {
                Write-Host $_ -ForegroundColor Yellow 
            }
        }

        It 'Removes a user by loaded client object' {
            $User = Get-SPClientUser -Email "testuser0@$($Env:LoginDomain)"
            $Params = @{
                ClientObject = $User
            }
            $Result = Remove-SPClientUser @Params
            $Result | Should BeNullOrEmpty
        }

        It 'Removes a user by unloaded client object' {
            $Web = $SPClient.ClientContext.Site.RootWeb
            $User = $Web.SiteUsers.GetByEmail("testuser0@$($Env:LoginDomain)")
            $Params = @{
                ClientObject = $User
            }
            $Result = Remove-SPClientUser @Params
            $Result | Should BeNullOrEmpty
        }
        It 'Removes a user by id' {
            $User = Get-SPClientUser -Email "testuser0@$($Env:LoginDomain)"
            $Params = @{
                Identity = $User.Id
            }
            $Result = Remove-SPClientUser @Params
            $Result | Should BeNullOrEmpty
        }

        It 'Removes a user by name' {
            $Params = @{
                Name = "i:0#.f|membership|testuser0@$($Env:LoginDomain)"
            }
            $Result = Remove-SPClientUser @Params
            $Result | Should BeNullOrEmpty
        }

        It 'Removes a user by email' {
            $Params = @{
                Email = "testuser0@$($Env:LoginDomain)"
            }
            $Result = Remove-SPClientUser @Params
            $Result | Should BeNullOrEmpty
        }

    }

    Context 'Failure' {

        It 'Throws an error when the user could not be found by id' {
            $Throw = {
                $Params = @{
                    Identity = -1
                }
                $Result = Remove-SPClientUser @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'The specified user could not be found.'

        It 'Throws an error when the group could not be found by name' {
            $Throw = {
                $Params = @{
                    Name = "i:0#.f|membership|testuser0@$($Env:LoginDomain)"
                }
                $Result = Remove-SPClientUser @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'The specified user could not be found.'
        }
        }

        It 'Throws an error when the group could not be found by email' {
            $Throw = {
                $Params = @{
                    Email = "testuser0@$($Env:LoginDomain)"
                }
                $Result = Remove-SPClientUser @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'The specified user could not be found.'
        }

    }

}

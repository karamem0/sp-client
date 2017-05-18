#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'New-SPClientUser' {

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

        It 'Creates a new user with mandatory parameters' {
            $Params = @{
                LoginName = "i:0#.f|membership|testuser0@$($Env:LoginDomain)"
            }
            $Result = New-SPClientUser @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.User'
            $Result.LoginName | Should Be "i:0#.f|membership|testuser0@$($Env:LoginDomain)"
            $Result.Title | Should Be 'Test User 0'
            $Result.Email | Should Be "testuser0@$($Env:LoginDomain)"
            $Result.IsSiteAdmin | Should Be $false
        }

        It 'Creates a new view with all parameters' {
            $Params = @{
                LoginName = "i:0#.f|membership|testuser0@$($Env:LoginDomain)"
                Title = 'Test User 0 (testuser0@example.com)'
                Email = 'testuser0@example.com'
                IsSiteAdmin = $true
            }
            $Result = New-SPClientUser @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.User'
            $Result.LoginName | Should Be "i:0#.f|membership|testuser0@$($Env:LoginDomain)"
            $Result.Title | Should Be 'Test User 0 (testuser0@example.com)'
            $Result.Email | Should Be 'testuser0@example.com'
            $Result.IsSiteAdmin | Should Be $true
        }

    }

}

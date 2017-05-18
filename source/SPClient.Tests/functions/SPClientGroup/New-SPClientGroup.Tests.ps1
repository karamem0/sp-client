#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'New-SPClientGroup' {

    Context 'Success' {

        AfterEach {
            try {
                $Web = $SPClient.ClientContext.Site.RootWeb
                $Web.SiteGroups.RemoveByLoginName('Test Group 0')
                $SPClient.ClientContext.ExecuteQuery()
            } catch {
                Write-Host $_ -ForegroundColor Yellow 
            }
        }

        It 'Creates a new group with mandatory parameters' {
            $Web = Get-SPClientWeb -Identity $TestConfig.WebId
            $User = Get-SPClientUser -Current
            $Params = @{
                Name = 'Test Group 0'
                Retrievals = '*,Owner.Id,Users.Include(Id)'
            }
            $Result = New-SPClientGroup @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.Group'
            $Result.Title | Should Be 'Test Group 0'
            $Result.Description | Should BeNullOrEmpty
            $Result.Owner.Id | Should Be $User.Id
        }

        It 'Creates a new group with all parameters' {
            $Web = Get-SPClientWeb -Identity $TestConfig.WebId
            $User = Get-SPClientUser -Identity $TestConfig.UserId
            $Params = @{
                Name = 'Test Group 0'
                Description = 'Test Group 0'
                Owner = $User
                Users = $User
                Retrievals = '*,Owner.Id,Users.Include(Id)'
            }
            $Result = New-SPClientGroup @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.Group'
            $Result.Title | Should Be 'Test Group 0'
            $Result.Description | Should Be 'Test Group 0'
            $Result.Owner.Id | Should Be $TestConfig.UserId
            $Result.Users[0].Id | Should Be $TestConfig.UserId
        }

    }

}

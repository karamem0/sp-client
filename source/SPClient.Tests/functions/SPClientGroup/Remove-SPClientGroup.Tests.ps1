#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'Remove-SPClientGroup' {

    Context 'Success' {

        BeforeEach {
            try {
                $Web = $SPClient.ClientContext.Site.RootWeb
                $Group = New-Object Microsoft.SharePoint.Client.GroupCreationInformation
                $Group.Title = 'Test Group 0'
                $Group.Description = 'Test Group 0'
                $Group = $Web.SiteGroups.Add($Group)
                $Group.Owner = $Group
                $Group.Update()
                $SPClient.ClientContext.Load($Group)
                $SPClient.ClientContext.ExecuteQuery()
            } catch {
                Write-Host $_ -ForegroundColor Yellow 
            }
        }

        It 'Removes a group by loaded client object' {
            $Group = Get-SPClientGroup -Name 'Test Group 0'
            $Params = @{
                ClientObject = $Group
            }
            $Result = Remove-SPClientGroup @Params
            $Result | Should BeNullOrEmpty
        }

        It 'Removes a group by unloaded client object' {
            $Web = $SPClient.ClientContext.Site.RootWeb
            $Group = $Web.SiteGroups.GetByName('Test Group 0')
            $Params = @{
                ClientObject = $Group
            }
            $Result = Remove-SPClientGroup @Params
            $Result | Should BeNullOrEmpty
        }

        It 'Removes a group by id' {
            $Group = Get-SPClientGroup -Name 'Test Group 0'
            $Params = @{
                Identity = $Group.Id
            }
            $Result = Remove-SPClientGroup @Params
            $Result | Should BeNullOrEmpty
        }

        It 'Removes a group by name' {
            $Params = @{
                Name = 'Test Group 0'
            }
            $Result = Remove-SPClientGroup @Params
            $Result | Should BeNullOrEmpty
        }

    }

    Context 'Failure' {

        It 'Throws an error when the group could not be found by id' {
            $Throw = {
                $Params = @{
                    Identity = -1
                }
                $Result = Remove-SPClientGroup @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'The specified group could not be found.'
        }

        It 'Throws an error when the group could not be found by name' {
            $Throw = {
                $Params = @{
                    Name = 'Test Group 0'
                }
                $Result = Remove-SPClientGroup @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'The specified group could not be found.'
        }

    }

}

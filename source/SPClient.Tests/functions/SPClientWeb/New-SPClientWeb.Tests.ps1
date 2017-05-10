#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'New-SPClientWeb' {

    Context 'Success' {

        AfterEach {
            try {
                $PathMethod = New-Object Microsoft.SharePoint.Client.ObjectPathMethod( `
                    $SPClient.ClientContext, `
                    $SPClient.ClientContext.Site.Path, `
                    'OpenWeb', `
                    [object[]]"$($TestConfig.WebUrl)/TestWeb0")
                $Web = New-Object Microsoft.SharePoint.Client.Web($SPClient.ClientContext, $PathMethod);
                $Web.DeleteObject()
                $SPClient.ClientContext.ExecuteQuery()
            } catch {
                Write-Host $_ -ForegroundColor Yellow 
            }
        }

        It 'Creates a new web with mandatory parameters' {
            $Web = Get-SPClientWeb -Identity $TestConfig.WebId
            $Params = @{
                ParentObject = $Web
                Url = 'TestWeb0'
            }
            $Result = New-SPClientWeb @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.Web'
            $Result.Title | Should Be 'Team Site'
            $Result.Description | Should Be ''
            $Result.Language | Should Be 1033
            $Result.WebTemplate | Should Be 'STS'
            $Result.Configuration | Should Be 0
        }

        It 'Creates a new web with all parameters' {
            $Web = Get-SPClientWeb -Identity $TestConfig.WebId
            $Params = @{
                ParentObject = $Web
                Url = 'TestWeb0'
                Title = 'Test Web 0'
                Description = 'Test Web 0'
                Language = 1041
                Template = 'STS#1'
                UniquePermissions = $true
            }
            $Result = New-SPClientWeb @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.Web'
            $Result.Title | Should Be 'Test Web 0'
            $Result.Description | Should Be 'Test Web 0'
            $Result.Language | Should Be 1041
            $Result.WebTemplate | Should Be 'STS'
            $Result.Configuration | Should Be 1
        }

    }

}

#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'Clear-SPClientPermission' {

    Context 'Success' {

        BeforeEach {
            try {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
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

        AfterEach {
            try {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $List = $Web.Lists.GetByTitle('Test List 0')
                $List.DeleteObject()
                $SPClient.ClientContext.ExecuteQuery()
            } catch {
                Write-Host $_ -ForegroundColor Yellow 
            }
        }

        It 'Clears permissions' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $List = $Web.Lists.GetByTitle('Test List 0')
            $List.BreakRoleInheritance($false, $false)
            $Params = @{
                ClientObject = $List
                PassThru = $true
            }
            $Result = Clear-SPClientPermission @Params
            $Result | Should Not BeNullOrEmpty
        }

    }

    Context 'Failure' {

        It 'Throws an error when has not unique permission' {
            $Throw = {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
                $Params = @{
                    ClientObject = $List
                    PassThru = $true
                }
                $Result = Clear-SPClientPermission @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'This operation is not allowed on an object that inherits permissions.'
        }

    }

}

#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'Clear-SPClientPermission' {

    Context 'Success' {

        BeforeEach {
            try {
                $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
                $List = New-Object Microsoft.SharePoint.Client.ListCreationInformation
                $List.Title = 'TestList0'
                $List.TemplateType = 100
                $List = $Web.Lists.Add($List)
                $List.Update()
                $SPClient.ClientContext.Load($List)
                $SPClient.ClientContext.ExecuteQuery()
            } catch {
                Write-Host $_ -ForegroundColor Yellow 
            }
        }

        AfterEach {
            try {
                $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
                $List = $Web.Lists.GetByTitle('TestList0')
                $List.DeleteObject()
                $SPClient.ClientContext.ExecuteQuery()
            } catch {
                Write-Host $_ -ForegroundColor Yellow 
            }
        }

        It 'Clears permissions' {
            $Web = Get-SPClientWeb -Identity $TestConfig.WebId
            $List = Get-SPClientList -ParentObject $Web -Title 'TestList0'
            $List.BreakRoleInheritance($false, $false)
            $Params = @{
                ClientObject = $List
            }
            $Result = Clear-SPClientPermission @Params
            $Result | Should Not BeNullOrEmpty
        }

    }

    Context 'Failure' {

        It 'Throws an error when has not unique permission' {
            $Throw = {
                $Web = Get-SPClientWeb -Identity $TestConfig.WebId
                $List = Get-SPClientList -ParentObject $Web -Identity $TestConfig.ListId
                $Params = @{
                    ClientObject = $List
                }
                $Result = Clear-SPClientPermission @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'This operation is not allowed on an object that inherits permissions.'
        }

    }

}

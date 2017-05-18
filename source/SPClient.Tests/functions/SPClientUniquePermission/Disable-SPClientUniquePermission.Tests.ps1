#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'Disable-SPClientUniquePermission' {

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

        It 'Disables unique permission' {
            $Web = Get-SPClientWeb -Identity $TestConfig.WebId
            $List = Get-SPClientList -ParentObject $Web -Title 'TestList0'
            $List.BreakRoleInheritance($false, $false)
            $Params = @{
                ClientObject = $List
            }
            $Result = Disable-SPClientUniquePermission @Params
            $Result | Should BeNullOrEmpty
            $List.HasUniqueRoleAssignments | Should Be $false
        }

    }

}

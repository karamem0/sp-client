#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'Enable-SPClientUniqueRoleAssignments' {

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
            Write-Host " [BeforeEach] $($_)" -ForegroundColor Yellow 
        }
    }

    AfterEach {
        try {
            $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
            $List = $Web.Lists.GetByTitle('TestList0')
            $List.DeleteObject()
            $SPClient.ClientContext.ExecuteQuery()
        } catch {
            Write-Host " [AfterEach] $($_)" -ForegroundColor Yellow 
        }
    }

    It 'Enables unique role assignment' {
        $Web = Get-SPClientWeb -Identity $TestConfig.WebId
        $List = Get-SPClientList -ParentObject $Web -Title 'TestList0'
        $Params = @{
            ClientObject = $List
            CopyRoleAssignments = $true
            ClearSubscopes = $true
        }
        $Result = Enable-SPClientUniqueRoleAssignments @Params
        $Result | Should BeNullOrEmpty
        $List.HasUniqueRoleAssignments | Should Be $true
    }

}

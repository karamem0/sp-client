#Requires -Version 3.0

. "${PSScriptRoot}\..\..\TestInitialize.ps1"

Describe 'Disable-SPClientUniqueRoleAssignments' {

    BeforeEach {
        Add-SPClientType
        Connect-SPClientContext `
            -Url $TestConfig.LoginUrl `
            -Online `
            -UserName $TestConfig.LoginUserName `
            -Password (ConvertTo-SecureString -String $TestConfig.LoginPassword -AsPlainText -Force)
    }

    It 'Disables unique role assignment' {
        try {
            $list = Get-SPClientList -Title $TestConfig.ListTitle
            $list | Enable-SPClientUniqueRoleAssignments
            $result = $list | Disable-SPClientUniqueRoleAssignments
            $result | Should Be $null
            $list.HasUniqueRoleAssignments | Should Be $false
        } finally { }
    }

}

#Requires -Version 3.0

. "${PSScriptRoot}\..\..\TestInitialize.ps1"

Describe 'Enable-SPClientUniqueRoleAssignments' {

    BeforeEach {
        Add-SPClientType
        Connect-SPClientContext `
            -Url $TestConfig.LoginUrl `
            -Online `
            -UserName $TestConfig.LoginUserName `
            -Password (ConvertTo-SecureString -String $TestConfig.LoginPassword -AsPlainText -Force)
    }

    It 'Enables unique role assignment' {
        try {
            $list = Get-SPClientList -Title $TestConfig.ListTitle
            $param = @{
                CopyRoleAssignments = $true
                ClearSubscopes = $true
            }
            $result = $list | Enable-SPClientUniqueRoleAssignments @param
            $result | Should Be $null
            $list.HasUniqueRoleAssignments | Should Be $true
        } finally {
            $list = Get-SPClientList -Title $TestConfig.ListTitle
            $list | Disable-SPClientUniqueRoleAssignments
        }
    }

}

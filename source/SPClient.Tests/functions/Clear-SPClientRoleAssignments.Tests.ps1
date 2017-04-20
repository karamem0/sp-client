#Requires -Version 3.0

. "${PSScriptRoot}\..\TestInitialize.ps1"

Describe 'Clear-SPClientRoleAssignments' {

    BeforeEach {
        Add-SPClientType
        Connect-SPClientContext `
            -Url $TestConfig.LoginUrl `
            -Online `
            -UserName $TestConfig.LoginUserName `
            -Password (ConvertTo-SecureString -String $TestConfig.LoginPassword -AsPlainText -Force)
    }

    It 'Clears web role assignments' {
        try {
            $web = Get-SPClientWeb -Url $TestConfig.WebUrl
            $web | Enable-SPClientUniqueRoleAssignments
            $result = $web | Clear-SPClientRoleAssignments
            $result | Should Not Be $null
            $result.RoleAssignments | ForEach-Object {
                Write-Host "$(' ' * 3)$($_.Member.LoginName)"
                $_.RoleDefinitionBindings | ForEach-Object {
                    Write-Host "$(' ' * 3)$($_.Name)"
                }
            }
        } finally {
            $web = Get-SPClientWeb -Url $TestConfig.WebUrl
            $web | Disable-SPClientUniqueRoleAssignments
        }
    }

    It 'Clears list role assignments' {
        try {
            $list = Get-SPClientList -Title $TestConfig.ListTitle
            $list | Enable-SPClientUniqueRoleAssignments
            $result = $list | Clear-SPClientRoleAssignments
            $result | Should Not Be $null
            $result.RoleAssignments | ForEach-Object {
                Write-Host "$(' ' * 3)$($_.Member.LoginName)"
                $_.RoleDefinitionBindings | ForEach-Object {
                    Write-Host "$(' ' * 3)$($_.Name)"
                }
            }
        } finally {
            $list = Get-SPClientList -Title $TestConfig.ListTitle
            $list | Disable-SPClientUniqueRoleAssignments
        }
    }

    It 'Clears item role assignments' {
        try {
            $list = Get-SPClientList -Title $TestConfig.ListTitle
            $item = ($list | Get-SPClientListItem -RowLimit 1)[0]
            $item | Enable-SPClientUniqueRoleAssignments
            $result = $item | Clear-SPClientRoleAssignments
            $result | Should Not Be $null
            $result.RoleAssignments | ForEach-Object {
                Write-Host "$(' ' * 3)$($_.Member.LoginName)"
                $_.RoleDefinitionBindings | ForEach-Object {
                    Write-Host "$(' ' * 3)$($_.Name)"
                }
            }
        } finally {
            $item = ($list | Get-SPClientListItem -RowLimit 1)[0]
            $item | Disable-SPClientUniqueRoleAssignments
        }
    }

    It 'Throws an error when has not unique role assignments' {
        try {
            $throw = {
                $list = Get-SPClientList -Title $TestConfig.ListTitle
                $list | Disable-SPClientUniqueRoleAssignments
                $result = $list | Clear-SPClientRoleAssignments
                $result.RoleAssignments | ForEach-Object {
                    Write-Host "$(' ' * 3)$($_.Member.LoginName)"
                    $_.RoleDefinitionBindings | ForEach-Object {
                        Write-Host "$(' ' * 3)$($_.Name)"
                    }
                }
            }
            $throw | Should Throw 'This operation is not allowed on an object that inherits permissions.'
        } finally { }
    }

}

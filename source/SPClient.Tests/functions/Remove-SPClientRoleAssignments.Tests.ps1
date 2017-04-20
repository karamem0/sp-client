#Requires -Version 3.0

. "${PSScriptRoot}\..\TestInitialize.ps1"

Describe 'Remove-SPClientRoleAssignments' {

    BeforeEach {
        Add-SPClientType
        Connect-SPClientContext `
            -Url $TestConfig.LoginUrl `
            -Online `
            -UserName $TestConfig.LoginUserName `
            -Password (ConvertTo-SecureString -String $TestConfig.LoginPassword -AsPlainText -Force)
    }

    It 'Removes a role assignment by role name' {
        try {
            $user = Get-SPClientUser -Name $TestConfig.DomainUserName
            $list = Get-SPClientList -Title $TestConfig.ListTitle
            $list | Enable-SPClientUniqueRoleAssignments
            $list | Add-SPClientRoleAssignments -Member $user -Roles 'Read', 'Contribute', 'Edit'
            $param = @{
                Member = $user
                Roles = 'Read'
            }
            $result = $list | Remove-SPClientRoleAssignments @param
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

    It 'Removes a role assignment by role type' {
        try {
            $user = Get-SPClientUser -Name $TestConfig.DomainUserName
            $list = Get-SPClientList -Title $TestConfig.ListTitle
            $list | Enable-SPClientUniqueRoleAssignments
            $list | Add-SPClientRoleAssignments -Member $user -Roles 'Read', 'Contribute', 'Edit'
            $param = @{
                Member = $user
                Roles = [Microsoft.SharePoint.Client.RoleType]::Reader
            }
            $result = $list | Remove-SPClientRoleAssignments @param
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

    It 'Removes role assignments by role name' {
        try {
            $user = Get-SPClientUser -Name $TestConfig.DomainUserName
            $list = Get-SPClientList -Title $TestConfig.ListTitle
            $list | Enable-SPClientUniqueRoleAssignments
            $list | Add-SPClientRoleAssignments -Member $user -Roles 'Read', 'Contribute', 'Edit'
            $param = @{
                Member = $user
                Roles = @(
                    [Microsoft.SharePoint.Client.RoleType]::Reader
                    [Microsoft.SharePoint.Client.RoleType]::Contributor
                )
            }
            $result = $list | Remove-SPClientRoleAssignments @param
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

    It 'Removes role assignments by role type' {
        try {
            $user = Get-SPClientUser -Name $TestConfig.DomainUserName
            $list = Get-SPClientList -Title $TestConfig.ListTitle
            $list | Enable-SPClientUniqueRoleAssignments
            $list | Add-SPClientRoleAssignments -Member $user -Roles 'Read', 'Contribute', 'Edit'
            $param = @{
                Member = $user
                Roles = @(
                    'Read'
                    'Contribute'
                )
            }
            $result = $list | Remove-SPClientRoleAssignments @param
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

    It 'Removes all role assignments' {
        try {
            $user = Get-SPClientUser -Name $TestConfig.DomainUserName
            $list = Get-SPClientList -Title $TestConfig.ListTitle
            $list | Enable-SPClientUniqueRoleAssignments
            $list | Add-SPClientRoleAssignments -Member $user -Roles 'Read', 'Contribute', 'Edit'
            $param = @{
                Member = $user
                All = $true
            }
            $result = $list | Remove-SPClientRoleAssignments @param
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

    It 'Throws an error when has not unique role assignments' {
        try {
            $throw = {
                $user = Get-SPClientUser -Name $TestConfig.DomainUserName
                $list = Get-SPClientList -Title $TestConfig.ListTitle
                $list | Disable-SPClientUniqueRoleAssignments
                $param = @{
                    Member = $user
                    Roles = 'Full Control'
                }
                $result = $list | Remove-SPClientRoleAssignments @param
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

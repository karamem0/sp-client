#Requires -Version 3.0

. "${PSScriptRoot}\..\..\TestInitialize.ps1"

Describe 'Add-SPClientRoleAssignments' {

    BeforeEach {
        Add-SPClientType
        Connect-SPClientContext `
            -Url $TestConfig.LoginUrl `
            -Online `
            -UserName $TestConfig.LoginUserName `
            -Password (ConvertTo-SecureString -String $TestConfig.LoginPassword -AsPlainText -Force)
    }

    It 'Adds a role assignment to the domain user by role name' {
        try {
            $user = Get-SPClientUser -Name $TestConfig.DomainUserName
            $list = Get-SPClientList -Title $TestConfig.ListTitle
            $list | Enable-SPClientUniqueRoleAssignments
            $param = @{
                Member = $user
                Roles = 'Full Control'
            }
            $result = $list | Add-SPClientRoleAssignments @param
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

    It 'Adds a role assignment to the domain user by role type' {
        try {
            $user = Get-SPClientUser -Name $TestConfig.DomainUserName
            $list = Get-SPClientList -Title $TestConfig.ListTitle
            $list | Enable-SPClientUniqueRoleAssignments
            $param = @{
                Member = $user
                Roles = [Microsoft.SharePoint.Client.RoleType]::Administrator
            }
            $result = $list | Add-SPClientRoleAssignments @param
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

    It 'Adds a role assignment to the domain group by role name' {
        try {
            $user = Get-SPClientUser -Name $TestConfig.DomainUserName
            $list = Get-SPClientList -Title $TestConfig.ListTitle
            $list | Enable-SPClientUniqueRoleAssignments
            $param = @{
                Member = $user
                Roles = 'Full Control'
            }
            $result = $list | Add-SPClientRoleAssignments @param
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

    It 'Adds a role assignment to the domain group by role type' {
        try {
            $user = Get-SPClientUser -Name $TestConfig.DomainUserName
            $list = Get-SPClientList -Title $TestConfig.ListTitle
            $list | Enable-SPClientUniqueRoleAssignments
            $param = @{
                Member = $user
                Roles = [Microsoft.SharePoint.Client.RoleType]::Administrator
            }
            $result = $list | Add-SPClientRoleAssignments @param
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

    It 'Adds a role assignment to the SharePoint group by role name' {
        try {
            $user = Get-SPClientUser -Name $TestConfig.DomainUserName
            $list = Get-SPClientList -Title $TestConfig.ListTitle
            $list | Enable-SPClientUniqueRoleAssignments
            $param = @{
                Member = $user
                Roles = 'Full Control'
            }
            $result = $list | Add-SPClientRoleAssignments @param
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

    It 'Adds a role assignment to the SharePoint group by role type' {
        try {
            $user = Get-SPClientUser -Name $TestConfig.DomainUserName
            $list = Get-SPClientList -Title $TestConfig.ListTitle
            $list | Enable-SPClientUniqueRoleAssignments
            $param = @{
                Member = $user
                Roles = [Microsoft.SharePoint.Client.RoleType]::Administrator
            }
            $result = $list | Add-SPClientRoleAssignments @param
            $result | Should Not Be $null
            $result.Member | ForEach-Object { Write-Host $_.LoginName }
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

    It 'Adds role assignmenst by role name' {
        try {
            $user = Get-SPClientUser -Name $TestConfig.DomainUserName
            $list = Get-SPClientList -Title $TestConfig.ListTitle
            $list | Enable-SPClientUniqueRoleAssignments
            $param = @{
                Member = $user
                Roles = @(
                    'Read'
                    'Contribute'
                    'Edit'
                    'Full Control'
                )
            }
            $result = $list | Add-SPClientRoleAssignments @param
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

    It 'Adds role assignmenst by role type' {
        try {
            $user = Get-SPClientUser -Name $TestConfig.DomainUserName
            $list = Get-SPClientList -Title $TestConfig.ListTitle
            $list | Enable-SPClientUniqueRoleAssignments
            $param = @{
                Member = $user
                Roles = @(
                    [Microsoft.SharePoint.Client.RoleType]::Reader
                    [Microsoft.SharePoint.Client.RoleType]::Contributor
                    [Microsoft.SharePoint.Client.RoleType]::Editor
                    [Microsoft.SharePoint.Client.RoleType]::Administrator
                )
            }
            $result = $list | Add-SPClientRoleAssignments @param
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
                $result = $list | Add-SPClientRoleAssignments @param
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

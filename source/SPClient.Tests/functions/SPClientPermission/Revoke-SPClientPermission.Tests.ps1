#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'Revoke-SPClientPermission' {

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

        It 'Revokes a permission by role name' {
            $Web = Get-SPClientWeb -Identity $TestConfig.WebId
            $List = Get-SPClientList -ParentObject $Web -Title 'TestList0'
            $Group = Get-SPClientGroup -Identity $TestConfig.GroupId
            $List.BreakRoleInheritance($false, $false)
            $RoleDefinitionBindings = New-Object Microsoft.SharePoint.Client.RoleDefinitionBindingCollection($SPClient.ClientContext)
            $RoleDefinition = $SPClient.ClientContext.Site.RootWeb.RoleDefinitions.GetByName('Full Control')
            $RoleDefinitionBindings.Add($RoleDefinition)
            $List.RoleAssignments.Add($Group, $RoleDefinitionBindings) | Out-Null
            $Params = @{
                ClientObject = $List
                Member = $Group
                Roles = 'Full Control'
            }
            $Result = Revoke-SPClientPermission @Params
            $Result | Should Not BeNullOrEmpty
        }

        It 'Revokes a permission by role type' {
            $Web = Get-SPClientWeb -Identity $TestConfig.WebId
            $List = Get-SPClientList -ParentObject $Web -Title 'TestList0'
            $Group = Get-SPClientGroup -Identity $TestConfig.GroupId
            $List.BreakRoleInheritance($false, $false)
            $RoleDefinitionBindings = New-Object Microsoft.SharePoint.Client.RoleDefinitionBindingCollection($SPClient.ClientContext)
            $RoleDefinition = $SPClient.ClientContext.Site.RootWeb.RoleDefinitions.GetByName('Full Control')
            $RoleDefinitionBindings.Add($RoleDefinition)
            $List.RoleAssignments.Add($Group, $RoleDefinitionBindings) | Out-Null
            $Params = @{
                ClientObject = $List
                Member = $Group
                Roles = [Microsoft.SharePoint.Client.RoleType]::Administrator
            }
            $Result = Revoke-SPClientPermission @Params
            $Result | Should Not BeNullOrEmpty
        }

        It 'Revokes permissions by role name' {
            $Web = Get-SPClientWeb -Identity $TestConfig.WebId
            $List = Get-SPClientList -ParentObject $Web -Title 'TestList0'
            $Group = Get-SPClientGroup -Identity $TestConfig.GroupId
            $List.BreakRoleInheritance($false, $false)
            $RoleDefinitionBindings = New-Object Microsoft.SharePoint.Client.RoleDefinitionBindingCollection($SPClient.ClientContext)
            $RoleDefinition1 = $SPClient.ClientContext.Site.RootWeb.RoleDefinitions.GetByName('Read')
            $RoleDefinition2 = $SPClient.ClientContext.Site.RootWeb.RoleDefinitions.GetByName('Contribute')
            $RoleDefinition3 = $SPClient.ClientContext.Site.RootWeb.RoleDefinitions.GetByName('Edit')
            $RoleDefinitionBindings.Add($RoleDefinition1)
            $RoleDefinitionBindings.Add($RoleDefinition2)
            $RoleDefinitionBindings.Add($RoleDefinition3)
            $List.RoleAssignments.Add($Group, $RoleDefinitionBindings) | Out-Null
            $Params = @{
                ClientObject = $List
                Member = $Group
                Roles = @(
                    'Read'
                    'Contribute'
                )
            }
            $Result = Revoke-SPClientPermission @Params
            $Result | Should Not BeNullOrEmpty
        }

        It 'Revokes permissions by role type' {
            $Web = Get-SPClientWeb -Identity $TestConfig.WebId
            $List = Get-SPClientList -ParentObject $Web -Title 'TestList0'
            $Group = Get-SPClientGroup -Identity $TestConfig.GroupId
            $List.BreakRoleInheritance($false, $false)
            $RoleDefinitionBindings = New-Object Microsoft.SharePoint.Client.RoleDefinitionBindingCollection($SPClient.ClientContext)
            $RoleDefinition1 = $SPClient.ClientContext.Site.RootWeb.RoleDefinitions.GetByName('Read')
            $RoleDefinition2 = $SPClient.ClientContext.Site.RootWeb.RoleDefinitions.GetByName('Contribute')
            $RoleDefinition3 = $SPClient.ClientContext.Site.RootWeb.RoleDefinitions.GetByName('Edit')
            $RoleDefinitionBindings.Add($RoleDefinition1)
            $RoleDefinitionBindings.Add($RoleDefinition2)
            $RoleDefinitionBindings.Add($RoleDefinition3)
            $List.RoleAssignments.Add($Group, $RoleDefinitionBindings) | Out-Null
            $Params = @{
                ClientObject = $List
                Member = $Group
                Roles = @(
                    [Microsoft.SharePoint.Client.RoleType]::Reader
                    [Microsoft.SharePoint.Client.RoleType]::Contributor
                )
            }
            $Result = Revoke-SPClientPermission @Params
            $Result | Should Not BeNullOrEmpty
        }

    }

    Context 'Failure' {

        It 'Throws an error when has not unique permission' {
            $Throw = {
                $Web = Get-SPClientWeb -Identity $TestConfig.WebId
                $List = Get-SPClientList -ParentObject $Web -Identity $TestConfig.ListId
                $Group = Get-SPClientGroup -Identity $TestConfig.GroupId
                $Params = @{
                    ClientObject = $List
                    Member = $Group
                    Roles = 'Full Control'
                }
                $Result = Revoke-SPClientPermission @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'This operation is not allowed on an object that inherits permissions.'
        }

    }

}

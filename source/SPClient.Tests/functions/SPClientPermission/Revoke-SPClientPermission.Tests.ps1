#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'Revoke-SPClientPermission' {

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

        It 'Revokes a permission by role name' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $List = $Web.Lists.GetByTitle('Test List 0')
            $Group = $Web.SiteGroups.GetById($SPClient.TestConfig.GroupId)
            $List.BreakRoleInheritance($false, $false)
            $RoleDefinitionBindings = New-Object Microsoft.SharePoint.Client.RoleDefinitionBindingCollection($SPClient.ClientContext)
            $RoleDefinition = $SPClient.ClientContext.Site.RootWeb.RoleDefinitions.GetByName('Full Control')
            $RoleDefinitionBindings.Add($RoleDefinition)
            $List.RoleAssignments.Add($Group, $RoleDefinitionBindings) | Out-Null
            $Params = @{
                ClientObject = $List
                Member = $Group
                Roles = 'Full Control'
                PassThru = $true
            }
            $Result = Revoke-SPClientPermission @Params
            $Result | Should Not BeNullOrEmpty
        }

        It 'Revokes a permission by role type' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $List = $Web.Lists.GetByTitle('Test List 0')
            $Group = $Web.SiteGroups.GetById($SPClient.TestConfig.GroupId)
            $List.BreakRoleInheritance($false, $false)
            $RoleDefinitionBindings = New-Object Microsoft.SharePoint.Client.RoleDefinitionBindingCollection($SPClient.ClientContext)
            $RoleDefinition = $SPClient.ClientContext.Site.RootWeb.RoleDefinitions.GetByName('Full Control')
            $RoleDefinitionBindings.Add($RoleDefinition)
            $List.RoleAssignments.Add($Group, $RoleDefinitionBindings) | Out-Null
            $Params = @{
                ClientObject = $List
                Member = $Group
                Roles = [Microsoft.SharePoint.Client.RoleType]::Administrator
                PassThru = $true
            }
            $Result = Revoke-SPClientPermission @Params
            $Result | Should Not BeNullOrEmpty
        }

        It 'Revokes permissions by role name' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $List = $Web.Lists.GetByTitle('Test List 0')
            $Group = $Web.SiteGroups.GetById($SPClient.TestConfig.GroupId)
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
                PassThru = $true
            }
            $Result = Revoke-SPClientPermission @Params
            $Result | Should Not BeNullOrEmpty
        }

        It 'Revokes permissions by role type' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $List = $Web.Lists.GetByTitle('Test List 0')
            $Group = $Web.SiteGroups.GetById($SPClient.TestConfig.GroupId)
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
                PassThru = $true
            }
            $Result = Revoke-SPClientPermission @Params
            $Result | Should Not BeNullOrEmpty
        }

    }

    Context 'Failure' {

        It 'Throws an error when has not unique permission' {
            $Throw = {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
                $Group = $Web.SiteGroups.GetById($SPClient.TestConfig.GroupId)
                $Params = @{
                    ClientObject = $List
                    Member = $Group
                    Roles = 'Full Control'
                    PassThru = $true
                }
                $Result = Revoke-SPClientPermission @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'This operation is not allowed on an object that inherits permissions.'
        }

    }

}

#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'New-SPClientFieldChoice' {

    Context 'Success' {

        Context 'Site Column' {

            AfterEach {
                try {
                    $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                    $Field = $Web.Fields.GetByInternalNameOrTitle('TestField0')
                    $SPClient.ClientContext.Load($Field)
                    $SPClient.ClientContext.ExecuteQuery()
                    $Xml = [xml]$Field.SchemaXml
                    $Xml.DocumentElement.SetAttribute('Hidden', 'FALSE')
                    $Field.SchemaXml = $Xml.InnerXml
                    $Field.DeleteObject()
                    $SPClient.ClientContext.ExecuteQuery()
                } catch {
                    Write-Host $_ -ForegroundColor Yellow 
                }
            }

            It 'Creates a new column with mandatory parameters' {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $Params = @{
                    ParentObject = $Web
                    Name = 'TestField0'
                }
                $Result = New-SPClientFieldChoice @Params
                $Result | Should Not BeNullOrEmpty
                $Result | Should BeOfType 'Microsoft.SharePoint.Client.FieldChoice'
                $Result.InternalName | Should Be 'TestField0'
                $Result.Id | Should Not BeNullOrEmpty
                $Result.Title | Should Be 'TestField0'
                $Result.Description | Should BeNullOrEmpty
                $Result.Required | Should Be $false
                $Result.EnforceUniqueValues | Should Be $false
                $Result.EditFormat | Should Be 'Dropdown'
                $Result.FillInChoice | Should Be $false
                $Result.DefaultValue | Should BeNullOrEmpty
            }

            It 'Creates a new column with all parameters' {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $Params = @{
                    ParentObject = $Web
                    Name = 'TestField0'
                    Identity = '2F992681-3273-4C8C-BACD-8B7A9BBA0EE4'
                    Title = 'Test Field 0'
                    Description = 'Test Field 0'
                    Required = $true
                    EnforceUniqueValues = $true
                    Choices = @(
                        'Test Value 1'
                        'Test Value 2'
                        'Test Value 3'
                    )
                    EditFormat = 'RadioButtons'
                    FillInChoice = $true
                    DefaultValue = 'Test Field 0'
                    AddToDefaultView = $true
                }
                $Result = New-SPClientFieldChoice @Params
                $Result | Should Not BeNullOrEmpty
                $Result | Should BeOfType 'Microsoft.SharePoint.Client.FieldChoice'
                $Result.InternalName | Should Be 'TestField0'
                $Result.Id | Should Be '2F992681-3273-4C8C-BACD-8B7A9BBA0EE4'
                $Result.Title | Should Be 'Test Field 0'
                $Result.Description | Should Be 'Test Field 0'
                $Result.Required | Should Be $true
                $Result.EnforceUniqueValues | Should Be $true
                $Result.EditFormat | Should Be 'RadioButtons'
                $Result.FillInChoice | Should Be $true
                $Result.DefaultValue | Should Be 'Test Field 0'
            }

            It 'Creates a new column which allows multiple value' {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $Params = @{
                    ParentObject = $Web
                    Name = 'TestField0'
                    Identity = '2F992681-3273-4C8C-BACD-8B7A9BBA0EE4'
                    Title = 'Test Field 0'
                    Description = 'Test Field 0'
                    Required = $true
                    EnforceUniqueValues = $false
                    Choices = @(
                        'Test Value 1'
                        'Test Value 2'
                        'Test Value 3'
                    )
                    EditFormat = 'Checkboxes'
                    FillInChoice = $true
                    DefaultValue = 'Test Field 0'
                    AddToDefaultView = $true
                }
                $Result = New-SPClientFieldChoice @Params
                $Result | Should Not BeNullOrEmpty
                $Result | Should BeOfType 'Microsoft.SharePoint.Client.FieldMultiChoice'
                $Result.InternalName | Should Be 'TestField0'
                $Result.Id | Should Be '2F992681-3273-4C8C-BACD-8B7A9BBA0EE4'
                $Result.Title | Should Be 'Test Field 0'
                $Result.Description | Should Be 'Test Field 0'
                $Result.Required | Should Be $true
                $Result.FillInChoice | Should Be $true
                $Result.DefaultValue | Should Be 'Test Field 0'
            }

        }

        Context 'List Column' {

            AfterEach {
                try {
                    $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                    $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
                    $Field = $List.Fields.GetByInternalNameOrTitle('TestField0')
                    $SPClient.ClientContext.Load($Field)
                    $SPClient.ClientContext.ExecuteQuery()
                    $Xml = [xml]$Field.SchemaXml
                    $Xml.DocumentElement.SetAttribute('Hidden', 'FALSE')
                    $Field.SchemaXml = $Xml.InnerXml
                    $Field.DeleteObject()
                    $SPClient.ClientContext.ExecuteQuery()
                } catch {
                    Write-Host $_ -ForegroundColor Yellow 
                }
            }

            It 'Creates a new column with mandatory parameters' {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
                $Params = @{
                    ParentObject = $List
                    Name = 'TestField0'
                }
                $Result = New-SPClientFieldChoice @Params
                $Result | Should Not BeNullOrEmpty
                $Result | Should BeOfType 'Microsoft.SharePoint.Client.FieldChoice'
                $Result.InternalName | Should Be 'TestField0'
                $Result.Id | Should Not BeNullOrEmpty
                $Result.Title | Should Be 'TestField0'
                $Result.Description | Should BeNullOrEmpty
                $Result.Required | Should Be $false
                $Result.EnforceUniqueValues | Should Be $false
                $Result.EditFormat | Should Be 'Dropdown'
                $Result.FillInChoice | Should Be $false
                $Result.DefaultValue | Should BeNullOrEmpty
            }

            It 'Creates a new column with all parameters' {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
                $Params = @{
                    ParentObject = $List
                    Name = 'TestField0'
                    Identity = '2F992681-3273-4C8C-BACD-8B7A9BBA0EE4'
                    Title = 'Test Field 0'
                    Description = 'Test Field 0'
                    Required = $true
                    EnforceUniqueValues = $true
                    Choices = @(
                        'Test Value 1'
                        'Test Value 2'
                        'Test Value 3'
                    )
                    EditFormat = 'RadioButtons'
                    FillInChoice = $true
                    DefaultValue = 'Test Field 0'
                    AddToDefaultView = $true
                }
                $Result = New-SPClientFieldChoice @Params
                $Result | Should Not BeNullOrEmpty
                $Result | Should BeOfType 'Microsoft.SharePoint.Client.FieldChoice'
                $Result.InternalName | Should Be 'TestField0'
                $Result.Id | Should Be '2F992681-3273-4C8C-BACD-8B7A9BBA0EE4'
                $Result.Title | Should Be 'Test Field 0'
                $Result.Description | Should Be 'Test Field 0'
                $Result.Required | Should Be $true
                $Result.EnforceUniqueValues | Should Be $true
                $Result.EditFormat | Should Be 'RadioButtons'
                $Result.FillInChoice | Should Be $true
                $Result.DefaultValue | Should Be 'Test Field 0'
            }

            It 'Creates a new column which allows multiple value' {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
                $Params = @{
                    ParentObject = $List
                    Name = 'TestField0'
                    Identity = '2F992681-3273-4C8C-BACD-8B7A9BBA0EE4'
                    Title = 'Test Field 0'
                    Description = 'Test Field 0'
                    Required = $true
                    EnforceUniqueValues = $false
                    Choices = @(
                        'Test Value 1'
                        'Test Value 2'
                        'Test Value 3'
                    )
                    EditFormat = 'Checkboxes'
                    FillInChoice = $true
                    DefaultValue = 'Test Field 0'
                    AddToDefaultView = $true
                }
                $Result = New-SPClientFieldChoice @Params
                $Result | Should Not BeNullOrEmpty
                $Result | Should BeOfType 'Microsoft.SharePoint.Client.FieldMultiChoice'
                $Result.InternalName | Should Be 'TestField0'
                $Result.Id | Should Be '2F992681-3273-4C8C-BACD-8B7A9BBA0EE4'
                $Result.Title | Should Be 'Test Field 0'
                $Result.Description | Should Be 'Test Field 0'
                $Result.Required | Should Be $true
                $Result.FillInChoice | Should Be $true
                $Result.DefaultValue | Should Be 'Test Field 0'
            }

        }

    }

}

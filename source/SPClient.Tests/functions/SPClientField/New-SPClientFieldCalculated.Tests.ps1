#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'New-SPClientFieldCalculated' {

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
                    Formula = '=[Test Field 1]&[Test Field 3]'
                    FieldRefs = @('TestField1','TestField3')
                    OutputType = 'Text'
                }
                $Result = New-SPClientFieldCalculated @Params
                $Result | Should Not BeNullOrEmpty
                $Result | Should BeOfType 'Microsoft.SharePoint.Client.FieldCalculated'
                $Result.InternalName | Should Be 'TestField0'
                $Result.Id | Should Not BeNullOrEmpty
                $Result.Title | Should Be 'TestField0'
                $Result.Description | Should BeNullOrEmpty
                $Result.OutputType | Should Be 'Text'
            }

            It 'Creates a new column of Number' {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $Params = @{
                    ParentObject = $Web
                    Name = 'TestField0'
                    Identity = '2F992681-3273-4C8C-BACD-8B7A9BBA0EE4'
                    Title = 'Test Field 0'
                    Description = 'Test Field 0'
                    Formula = '=[Test Field 5]'
                    FieldRefs = @('TestField5')
                    OutputType = 'Number'
                    Decimals = 2
                    Percentage = $true
                    AddToDefaultView = $true
                }
                $Result = New-SPClientFieldCalculated @Params
                $Result | Should Not BeNullOrEmpty
                $Result | Should BeOfType 'Microsoft.SharePoint.Client.FieldCalculated'
                $Result.InternalName | Should Be 'TestField0'
                $Result.Id | Should Be '2F992681-3273-4C8C-BACD-8B7A9BBA0EE4'
                $Result.Title | Should Be 'Test Field 0'
                $Result.Description | Should Be 'Test Field 0'
                $Result.OutputType | Should Be 'Number'
            }

            It 'Creates a new column of Currency' {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $Params = @{
                    ParentObject = $Web
                    Name = 'TestField0'
                    Identity = '2F992681-3273-4C8C-BACD-8B7A9BBA0EE4'
                    Title = 'Test Field 0'
                    Description = 'Test Field 0'
                    Formula = '=[Test Field 6]'
                    FieldRefs = @('TestField6')
                    OutputType = 'Currency'
                    Decimals = 2
                    LocaleId = 1041
                    AddToDefaultView = $true
                }
                $Result = New-SPClientFieldCalculated @Params
                $Result | Should Not BeNullOrEmpty
                $Result | Should BeOfType 'Microsoft.SharePoint.Client.FieldCalculated'
                $Result.InternalName | Should Be 'TestField0'
                $Result.Id | Should Be '2F992681-3273-4C8C-BACD-8B7A9BBA0EE4'
                $Result.Title | Should Be 'Test Field 0'
                $Result.Description | Should Be 'Test Field 0'
                $Result.OutputType | Should Be 'Currency'
            }

            It 'Creates a new column of DateTime' {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $Params = @{
                    ParentObject = $Web
                    Name = 'TestField0'
                    Identity = '2F992681-3273-4C8C-BACD-8B7A9BBA0EE4'
                    Title = 'Test Field 0'
                    Description = 'Test Field 0'
                    Formula = '=[Test Field 7]'
                    FieldRefs = @('TestField7')
                    OutputType = 'DateTime'
                    DateFormat = 'DateOnly'
                    AddToDefaultView = $true
                }
                $Result = New-SPClientFieldCalculated @Params
                $Result | Should Not BeNullOrEmpty
                $Result | Should BeOfType 'Microsoft.SharePoint.Client.FieldCalculated'
                $Result.InternalName | Should Be 'TestField0'
                $Result.Id | Should Be '2F992681-3273-4C8C-BACD-8B7A9BBA0EE4'
                $Result.Title | Should Be 'Test Field 0'
                $Result.Description | Should Be 'Test Field 0'
                $Result.OutputType | Should Be 'DateTime'
                $Result.DateFormat | Should Be 'DateOnly'
            }

            It 'Creates a new column of Boolean' {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $Params = @{
                    ParentObject = $Web
                    Name = 'TestField0'
                    Identity = '2F992681-3273-4C8C-BACD-8B7A9BBA0EE4'
                    Title = 'Test Field 0'
                    Description = 'Test Field 0'
                    Formula = '=[Test Field 10]'
                    FieldRefs = @('TestField10')
                    OutputType = 'Boolean'
                }
                $Result = New-SPClientFieldCalculated @Params
                $Result | Should Not BeNullOrEmpty
                $Result | Should BeOfType 'Microsoft.SharePoint.Client.FieldCalculated'
                $Result.InternalName | Should Be 'TestField0'
                $Result.Id | Should Be '2F992681-3273-4C8C-BACD-8B7A9BBA0EE4'
                $Result.Title | Should Be 'Test Field 0'
                $Result.Description | Should Be 'Test Field 0'
                $Result.OutputType | Should Be 'Boolean'
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
                    Formula = '=[Test Field 1]&[Test Field 3]'
                    FieldRefs = @('TestField1','TestField3')
                    OutputType = 'Text'
                }
                $Result = New-SPClientFieldCalculated @Params
                $Result | Should Not BeNullOrEmpty
                $Result | Should BeOfType 'Microsoft.SharePoint.Client.FieldCalculated'
                $Result.InternalName | Should Be 'TestField0'
                $Result.Id | Should Not BeNullOrEmpty
                $Result.Title | Should Be 'TestField0'
                $Result.Description | Should BeNullOrEmpty
                $Result.OutputType | Should Be 'Text'
            }

            It 'Creates a new column of Number' {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
                $Params = @{
                    ParentObject = $List
                    Name = 'TestField0'
                    Identity = '2F992681-3273-4C8C-BACD-8B7A9BBA0EE4'
                    Title = 'Test Field 0'
                    Description = 'Test Field 0'
                    Formula = '=[Test Field 5]'
                    FieldRefs = @('TestField5')
                    OutputType = 'Number'
                    Decimals = 2
                    Percentage = $true
                    AddToDefaultView = $true
                }
                $Result = New-SPClientFieldCalculated @Params
                $Result | Should Not BeNullOrEmpty
                $Result | Should BeOfType 'Microsoft.SharePoint.Client.FieldCalculated'
                $Result.InternalName | Should Be 'TestField0'
                $Result.Id | Should Be '2F992681-3273-4C8C-BACD-8B7A9BBA0EE4'
                $Result.Title | Should Be 'Test Field 0'
                $Result.Description | Should Be 'Test Field 0'
                $Result.OutputType | Should Be 'Number'
            }

            It 'Creates a new column of Currency' {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
                $Params = @{
                    ParentObject = $List
                    Name = 'TestField0'
                    Identity = '2F992681-3273-4C8C-BACD-8B7A9BBA0EE4'
                    Title = 'Test Field 0'
                    Description = 'Test Field 0'
                    Formula = '=[Test Field 6]'
                    FieldRefs = @('TestField6')
                    OutputType = 'Currency'
                    Decimals = 2
                    LocaleId = 1041
                    AddToDefaultView = $true
                }
                $Result = New-SPClientFieldCalculated @Params
                $Result | Should Not BeNullOrEmpty
                $Result | Should BeOfType 'Microsoft.SharePoint.Client.FieldCalculated'
                $Result.InternalName | Should Be 'TestField0'
                $Result.Id | Should Be '2F992681-3273-4C8C-BACD-8B7A9BBA0EE4'
                $Result.Title | Should Be 'Test Field 0'
                $Result.Description | Should Be 'Test Field 0'
                $Result.OutputType | Should Be 'Currency'
            }

            It 'Creates a new column of DateTime' {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
                $Params = @{
                    ParentObject = $List
                    Name = 'TestField0'
                    Identity = '2F992681-3273-4C8C-BACD-8B7A9BBA0EE4'
                    Title = 'Test Field 0'
                    Description = 'Test Field 0'
                    Formula = '=[Test Field 7]'
                    FieldRefs = @('TestField7')
                    OutputType = 'DateTime'
                    DateFormat = 'DateOnly'
                    AddToDefaultView = $true
                }
                $Result = New-SPClientFieldCalculated @Params
                $Result | Should Not BeNullOrEmpty
                $Result | Should BeOfType 'Microsoft.SharePoint.Client.FieldCalculated'
                $Result.InternalName | Should Be 'TestField0'
                $Result.Id | Should Be '2F992681-3273-4C8C-BACD-8B7A9BBA0EE4'
                $Result.Title | Should Be 'Test Field 0'
                $Result.Description | Should Be 'Test Field 0'
                $Result.OutputType | Should Be 'DateTime'
                $Result.DateFormat | Should Be 'DateOnly'
            }

            It 'Creates a new column of Boolean' {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
                $Params = @{
                    ParentObject = $List
                    Name = 'TestField0'
                    Identity = '2F992681-3273-4C8C-BACD-8B7A9BBA0EE4'
                    Title = 'Test Field 0'
                    Description = 'Test Field 0'
                    Formula = '=[Test Field 10]'
                    FieldRefs = @('TestField10')
                    OutputType = 'Boolean'
                }
                $Result = New-SPClientFieldCalculated @Params
                $Result | Should Not BeNullOrEmpty
                $Result | Should BeOfType 'Microsoft.SharePoint.Client.FieldCalculated'
                $Result.InternalName | Should Be 'TestField0'
                $Result.Id | Should Be '2F992681-3273-4C8C-BACD-8B7A9BBA0EE4'
                $Result.Title | Should Be 'Test Field 0'
                $Result.Description | Should Be 'Test Field 0'
                $Result.OutputType | Should Be 'Boolean'
            }

        }

    }

}

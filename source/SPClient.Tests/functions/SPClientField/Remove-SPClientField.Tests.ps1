#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'Remove-SPClientField' {

    Context 'Success' {

        BeforeEach {
            try {
                $Xml = '<Field Type="Text" ID="2F992681-3273-4C8C-BACD-8B7A9BBA0EE4" Name="TestField0" DisplayName="Test Field 0" />'
                $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
                $List = $Web.Lists.GetById($TestConfig.ListId)
                $Field = $List.Fields.AddFieldAsXml($Xml, $True, 8)
                $Field.Update()
                $SPClient.ClientContext.Load($Field)
                $SPClient.ClientContext.ExecuteQuery()
            } catch {
                Write-Host $_ -ForegroundColor Yellow 
            }
        }

        It 'Removes a field by loaded client object' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
            $List = $Web.Lists.GetById($TestConfig.ListId)
            $Field = $List.Fields.GetByInternalNameOrTitle('Test Field 0')
            $SPClient.ClientContext.Load($Field)
            $SPClient.ClientContext.ExecuteQuery()
            $Params = @{
                ClientObject = $Field
            }
            $Result = Remove-SPClientField @Params
            $Result | Should BeNullOrEmpty
        }

        It 'Removes a field by unloaded client object' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
            $List = $Web.Lists.GetById($TestConfig.ListId)
            $Field = $List.Fields.GetByInternalNameOrTitle('Test Field 0')
            $Params = @{
                ClientObject = $Field
            }
            $Result = Remove-SPClientField @Params
            $Result | Should BeNullOrEmpty
        }

        It 'Removes a field by id' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
            $List = $Web.Lists.GetById($TestConfig.ListId)
            $Params = @{
                ParentList = $List
                Identity = '2F992681-3273-4C8C-BACD-8B7A9BBA0EE4'
            }
            $Result = Remove-SPClientField @Params
            $Result | Should BeNullOrEmpty
        }

        It 'Removes a field by title' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
            $List = $Web.Lists.GetById($TestConfig.ListId)
            $Params = @{
                ParentList = $List
                Name = 'Test Field 0'
            }
            $Result = Remove-SPClientField @Params
            $Result | Should BeNullOrEmpty
        }

        It 'Removes a field by internal name' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
            $List = $Web.Lists.GetById($TestConfig.ListId)
            $Params = @{
                ParentList = $List
                Name = 'TestField0'
            }
            $Result = Remove-SPClientField @Params
            $Result | Should BeNullOrEmpty
        }

    }

    Context 'Failure' {

        It 'Throws an error when the field could not be found by id' {
            $Throw = {
                $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
                $List = $Web.Lists.GetById($TestConfig.ListId)
                $Params = @{
                    ParentList = $List
                    Identity = 'CB656852-E59C-4596-9161-47A91BB25A38'
                }
                $Result = Remove-SPClientField @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'The specified field could not be found.'
        }

        It 'Throws an error when the field could not be found by name' {
            $Throw = {
                $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
                $List = $Web.Lists.GetById($TestConfig.ListId)
                $Params = @{
                    ParentList = $List
                    Name = 'Test Field 0'
                }
                $Result = Remove-SPClientField @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'The specified field could not be found.'
        }

    }

}

#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'Convert-SPClientField' {

    Context 'Success' {

        It 'Converts "Text" field to "FieldText"' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
            $List = $Web.Lists.GetById($TestConfig.ListId)
            $Field = $List.Fields.GetByInternalNameOrTitle('TestField1')
            $Params = @{
                ClientObject = $Field
            }
            $Result = Convert-SPClientField @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.FieldText'
        }

        It 'Converts "Note" field to "FieldMultilineText"' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
            $List = $Web.Lists.GetById($TestConfig.ListId)
            $Field = $List.Fields.GetByInternalNameOrTitle('TestField2')
            $Params = @{
                ClientObject = $Field
            }
            $Result = Convert-SPClientField @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.FieldMultilineText'
        }

        It 'Converts "Choice" field to "FieldChoice"' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
            $List = $Web.Lists.GetById($TestConfig.ListId)
            $Field = $List.Fields.GetByInternalNameOrTitle('TestField3')
            $Params = @{
                ClientObject = $Field
            }
            $Result = Convert-SPClientField @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.FieldChoice'
        }

        It 'Converts "MultiChoice" field to "FieldMultiChoice"' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
            $List = $Web.Lists.GetById($TestConfig.ListId)
            $Field = $List.Fields.GetByInternalNameOrTitle('TestField4')
            $Params = @{
                ClientObject = $Field
            }
            $Result = Convert-SPClientField @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.FieldMultiChoice'
        }

        It 'Converts "Number" field to "FieldNumber"' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
            $List = $Web.Lists.GetById($TestConfig.ListId)
            $Field = $List.Fields.GetByInternalNameOrTitle('TestField5')
            $Params = @{
                ClientObject = $Field
            }
            $Result = Convert-SPClientField @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.FieldNumber'
        }

        It 'Converts "Currency" field to "FieldCurrency"' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
            $List = $Web.Lists.GetById($TestConfig.ListId)
            $Field = $List.Fields.GetByInternalNameOrTitle('TestField6')
            $Params = @{
                ClientObject = $Field
            }
            $Result = Convert-SPClientField @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.FieldCurrency'
        }

        It 'Converts "DateTime" field to "FieldDateTime"' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
            $List = $Web.Lists.GetById($TestConfig.ListId)
            $Field = $List.Fields.GetByInternalNameOrTitle('TestField7')
            $Params = @{
                ClientObject = $Field
            }
            $Result = Convert-SPClientField @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.FieldDateTime'
        }

        It 'Converts "Boolean" field to "FieldNumber"' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
            $List = $Web.Lists.GetById($TestConfig.ListId)
            $Field = $List.Fields.GetByInternalNameOrTitle('TestField10')
            $Params = @{
                ClientObject = $Field
            }
            $Result = Convert-SPClientField @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.FieldNumber'
        }

        It 'Converts "URL" field to "FieldUrl"' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
            $List = $Web.Lists.GetById($TestConfig.ListId)
            $Field = $List.Fields.GetByInternalNameOrTitle('TestField13')
            $Params = @{
                ClientObject = $Field
            }
            $Result = Convert-SPClientField @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.FieldUrl'
        }

        It 'Converts "Calculated" field to "FieldCalculated"' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
            $List = $Web.Lists.GetById($TestConfig.ListId)
            $Field = $List.Fields.GetByInternalNameOrTitle('TestField14')
            $Params = @{
                ClientObject = $Field
            }
            $Result = Convert-SPClientField @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.FieldCalculated'
        }

    }

}

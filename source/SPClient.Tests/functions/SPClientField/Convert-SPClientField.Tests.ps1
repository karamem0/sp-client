#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'Convert-SPClientField' {

    Context 'Success' {

        It 'Converts "Text" column to "FieldText"' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
            $Field = $List.Fields.GetByInternalNameOrTitle('TestField1')
            $Params = @{
                Field = $Field
            }
            $Result = Convert-SPClientField @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.FieldText'
        }

        It 'Converts "Note" column to "FieldMultilineText"' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
            $Field = $List.Fields.GetByInternalNameOrTitle('TestField2')
            $Params = @{
                Field = $Field
            }
            $Result = Convert-SPClientField @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.FieldMultilineText'
        }

        It 'Converts "Choice" column to "FieldChoice"' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
            $Field = $List.Fields.GetByInternalNameOrTitle('TestField3')
            $Params = @{
                Field = $Field
            }
            $Result = Convert-SPClientField @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.FieldChoice'
        }

        It 'Converts "MultiChoice" column to "FieldMultiChoice"' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
            $Field = $List.Fields.GetByInternalNameOrTitle('TestField4')
            $Params = @{
                Field = $Field
            }
            $Result = Convert-SPClientField @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.FieldMultiChoice'
        }

        It 'Converts "Number" column to "FieldNumber"' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
            $Field = $List.Fields.GetByInternalNameOrTitle('TestField5')
            $Params = @{
                Field = $Field
            }
            $Result = Convert-SPClientField @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.FieldNumber'
        }

        It 'Converts "Currency" column to "FieldCurrency"' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
            $Field = $List.Fields.GetByInternalNameOrTitle('TestField6')
            $Params = @{
                Field = $Field
            }
            $Result = Convert-SPClientField @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.FieldCurrency'
        }

        It 'Converts "DateTime" column to "FieldDateTime"' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
            $Field = $List.Fields.GetByInternalNameOrTitle('TestField7')
            $Params = @{
                Field = $Field
            }
            $Result = Convert-SPClientField @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.FieldDateTime'
        }

        It 'Converts "Boolean" column to "FieldNumber"' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
            $Field = $List.Fields.GetByInternalNameOrTitle('TestField10')
            $Params = @{
                Field = $Field
            }
            $Result = Convert-SPClientField @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.FieldNumber'
        }

        It 'Converts "URL" column to "FieldUrl"' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
            $Field = $List.Fields.GetByInternalNameOrTitle('TestField13')
            $Params = @{
                Field = $Field
            }
            $Result = Convert-SPClientField @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.FieldUrl'
        }

        It 'Converts "Calculated" column to "FieldCalculated"' {
            $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
            $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
            $Field = $List.Fields.GetByInternalNameOrTitle('TestField14')
            $Params = @{
                Field = $Field
            }
            $Result = Convert-SPClientField @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.FieldCalculated'
        }

    }

}

#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'Convert-SPClientField' {

    Context 'Success' {

        It 'Converts "Text" field to "FieldText"' {
            $Web = Get-SPClientWeb -Identity $TestConfig.WebId
            $List = Get-SPClientList -ParentObject $Web -Identity $TestConfig.ListId
            $Field = Get-SPClientField -ParentObject $List -Name 'TestField1'
            $Params = @{
                ClientObject = $Field
            }
            $Result = Convert-SPClientField @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.FieldText'
        }

        It 'Converts "Note" field to "FieldMultilineText"' {
            $Web = Get-SPClientWeb -Identity $TestConfig.WebId
            $List = Get-SPClientList -ParentObject $Web -Identity $TestConfig.ListId
            $Field = Get-SPClientField -ParentObject $List -Name 'TestField2'
            $Params = @{
                ClientObject = $Field
            }
            $Result = Convert-SPClientField @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.FieldMultilineText'
        }

        It 'Converts "Choice" field to "FieldChoice"' {
            $Web = Get-SPClientWeb -Identity $TestConfig.WebId
            $List = Get-SPClientList -ParentObject $Web -Identity $TestConfig.ListId
            $Field = Get-SPClientField -ParentObject $List -Name 'TestField3'
            $Params = @{
                ClientObject = $Field
            }
            $Result = Convert-SPClientField @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.FieldChoice'
        }

        It 'Converts "Number" field to "FieldNumber"' {
            $Web = Get-SPClientWeb -Identity $TestConfig.WebId
            $List = Get-SPClientList -ParentObject $Web -Identity $TestConfig.ListId
            $Field = Get-SPClientField -ParentObject $List -Name 'TestField4'
            $Params = @{
                ClientObject = $Field
            }
            $Result = Convert-SPClientField @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.FieldNumber'
        }

        It 'Converts "Currency" field to "FieldCurrency"' {
            $Web = Get-SPClientWeb -Identity $TestConfig.WebId
            $List = Get-SPClientList -ParentObject $Web -Identity $TestConfig.ListId
            $Field = Get-SPClientField -ParentObject $List -Name 'TestField5'
            $Params = @{
                ClientObject = $Field
            }
            $Result = Convert-SPClientField @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.FieldCurrency'
        }

        It 'Converts "DateTime" field to "FieldDateTime"' {
            $Web = Get-SPClientWeb -Identity $TestConfig.WebId
            $List = Get-SPClientList -ParentObject $Web -Identity $TestConfig.ListId
            $Field = Get-SPClientField -ParentObject $List -Name 'TestField6'
            $Params = @{
                ClientObject = $Field
            }
            $Result = Convert-SPClientField @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.FieldDateTime'
        }

        It 'Converts "Boolean" field to "FieldNumber"' {
            $Web = Get-SPClientWeb -Identity $TestConfig.WebId
            $List = Get-SPClientList -ParentObject $Web -Identity $TestConfig.ListId
            $Field = Get-SPClientField -ParentObject $List -Name 'TestField7'
            $Params = @{
                ClientObject = $Field
            }
            $Result = Convert-SPClientField @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.FieldNumber'
        }

    }

}

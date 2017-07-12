#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'Remove-SPClientContentTypeField' {

    Context 'Success' {

        Context 'Site Content Type' {

            BeforeEach {
                try {
                    $Xml = '<Field Type="Text" ID="2F992681-3273-4C8C-BACD-8B7A9BBA0EE4" Name="TestField0" DisplayName="Test Field 0" />'
                    $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                    $Field = $Web.Fields.AddFieldAsXml($Xml, $True, 8)
                    $Field.Update()
                    $SPClient.ClientContext.Load($Field)
                    $SPClient.ClientContext.ExecuteQuery()
                    $ContentType = $Web.ContentTypes.GetById($SPClient.TestConfig.WebContentTypeId)
                    $FieldLink = New-Object Microsoft.SharePoint.Client.FieldLinkCreationInformation
                    $FieldLink.Field = $Field
                    $FieldLink = $ContentType.FieldLinks.Add($FieldLink)
                    $ContentType.Update($true)
                    $SPClient.ClientContext.ExecuteQuery()
                } catch {
                    Write-Host $_ -ForegroundColor Yellow 
                }
            }

            AfterEach {
                try {
                    $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                    $Field = $Web.Fields.GetByInternalNameOrTitle('TestField0')
                    $Field.DeleteObject()
                    $SPClient.ClientContext.ExecuteQuery()
                    $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
                    $Field = $List.Fields.GetByInternalNameOrTitle('TestField0')
                    $Field.DeleteObject()
                    $SPClient.ClientContext.ExecuteQuery()
                } catch {
                    Write-Host $_ -ForegroundColor Yellow 
                }
            }

            It 'Removes a field from the content type' {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $ContentType = $Web.ContentTypes.GetById($SPClient.TestConfig.WebContentTypeId)
                $Field = $Web.Fields.GetByInternalNameOrTitle('TestField0')
                $Params = @{
                    ContentType = $ContentType
                    Field = $Field
                    PassThru = $true
                }
                $Result = Remove-SPClientContentTypeField @Params
                $Result | Should Not BeNullOrEmpty
                $Result | Should BeOfType 'Microsoft.SharePoint.Client.ContentType'
            }

        }

        Context 'List Content Type' {

            BeforeEach {
                try {
                    $Xml = '<Field Type="Text" ID="2F992681-3273-4C8C-BACD-8B7A9BBA0EE4" Name="TestField0" DisplayName="Test Field 0" />'
                    $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                    $Field = $Web.Fields.AddFieldAsXml($Xml, $True, 8)
                    $Field.Update()
                    $SPClient.ClientContext.Load($Field)
                    $SPClient.ClientContext.ExecuteQuery()
                    $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
                    $ContentType = $List.ContentTypes.GetById($SPClient.TestConfig.ListContentTypeId)
                    $FieldLink = New-Object Microsoft.SharePoint.Client.FieldLinkCreationInformation
                    $FieldLink.Field = $Field
                    $FieldLink = $ContentType.FieldLinks.Add($FieldLink)
                    $ContentType.Update($false)
                    $SPClient.ClientContext.ExecuteQuery()
                } catch {
                    Write-Host $_ -ForegroundColor Yellow 
                }
            }

            AfterEach {
                try {
                    $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                    $Field = $Web.Fields.GetByInternalNameOrTitle('TestField0')
                    $Field.DeleteObject()
                    $SPClient.ClientContext.ExecuteQuery()
                    $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
                    $Field = $List.Fields.GetByInternalNameOrTitle('TestField0')
                    $Field.DeleteObject()
                    $SPClient.ClientContext.ExecuteQuery()
                } catch {
                    Write-Host $_ -ForegroundColor Yellow 
                }
            }

            It 'Removes a field from the content type' {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
                $ContentType = $List.ContentTypes.GetById($SPClient.TestConfig.ListContentTypeId)
                $Field = $Web.Fields.GetByInternalNameOrTitle('TestField0')
                $Params = @{
                    ContentType = $ContentType
                    Field = $Field
                    PassThru = $true
                }
                $Result = Remove-SPClientContentTypeField @Params
                $Result | Should Not BeNullOrEmpty
                $Result | Should BeOfType 'Microsoft.SharePoint.Client.ContentType'
            }

        }

    }

}

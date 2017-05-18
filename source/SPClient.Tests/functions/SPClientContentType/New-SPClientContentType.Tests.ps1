#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'New-SPClientContentType' {

    Context 'Success' {

        AfterEach {
            try {
                $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
                $SPClient.ClientContext.Load($Web.ContentTypes)
                $SPClient.ClientContext.ExecuteQuery()
                for ($index = $Web.ContentTypes.Count - 1; $index -ge 0; $index--) {
                    $ContentType = $Web.ContentTypes[$index]
                    $SPClient.ClientContext.Load($ContentType)
                    $SPClient.ClientContext.ExecuteQuery()
                    if ($ContentType.Name -eq 'Test Content Type 0') {
                        $ContentType.DeleteObject()
                        $SPClient.ClientContext.ExecuteQuery()
                    }
                }
            } catch {
                Write-Host $_ -ForegroundColor Yellow 
            }
        }

        It 'Creates a new content type with mandatory parameters' {
            $Web = Get-SPClientWeb -Url $TestConfig.WebUrl
            $Params = @{
                ParentObject = $Web
                Name = 'Test Content Type 0'
            }
            $Result = New-SPClientContentType @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.ContentType'
            $Result.Name | Should Be 'Test Content Type 0'
            $Result.Description | Should BeNullOrEmpty
            $Result.Group | Should Be 'Custom Content Types'
            $Result.StringId | Should BeLike '0x0100*'
        }

        It 'Creates a new content type by parent content type id' {
            $Web = Get-SPClientWeb -Url $TestConfig.WebUrl
            $Params = @{ 
                ParentObject = $Web
                Name = 'Test Content Type 0'
                Description = 'Test Content Type 0'
                Group = 'Test Content Type 0'
                ParentContentType = '0x0101'
            }
            $Result = New-SPClientContentType @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.ContentType'
            $Result.Name | Should Be 'Test Content Type 0'
            $Result.Description | Should Be 'Test Content Type 0'
            $Result.Group | Should Be 'Test Content Type 0'
            $Result.StringId | Should BeLike '0x010100*' 
        }

        It 'Creates a new content type by parent content type name' {
            $Web = Get-SPClientWeb -Url $TestConfig.WebUrl
            $Params = @{ 
                ParentObject = $Web
                Name = 'Test Content Type 0'
                Description = 'Test Content Type 0'
                Group = 'Test Content Type 0'
                ParentContentType = 'Document'
            }
            $Result = New-SPClientContentType @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.ContentType'
            $Result.Name | Should Be 'Test Content Type 0'
            $Result.Description | Should Be 'Test Content Type 0'
            $Result.Group | Should Be 'Test Content Type 0'
            $Result.StringId | Should BeLike '0x010100*' 
        }

    }

}

#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'New-SPClientContentType' {

    Context 'Success' {

        Context 'Site Content Type' {

            AfterEach {
                try {
                    $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
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
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
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

            It 'Creates a new content type with all parameters' {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $ContentType = $SPClient.ClientContext.Site.RootWeb.ContentTypes.GetById('0x0101')
                $Params = @{ 
                    ParentObject = $Web
                    Name = 'Test Content Type 0'
                    Description = 'Test Content Type 0'
                    Group = 'Test Content Type 0'
                    ParentContentType = $ContentType
                }
                $Result = New-SPClientContentType @Params
                $Result | Should Not BeNullOrEmpty
                $Result | Should BeOfType 'Microsoft.SharePoint.Client.ContentType'
                $Result.Name | Should Be 'Test Content Type 0'
                $Result.Description | Should Be 'Test Content Type 0'
                $Result.Group | Should Be 'Test Content Type 0'
                $Result.StringId | Should BeLike '0x010100*' 
            }

        }

        Context 'List Content Type' {

            AfterEach {
                try {
                    $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                    $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
                    $SPClient.ClientContext.Load($List.ContentTypes)
                    $SPClient.ClientContext.ExecuteQuery()
                    for ($index = $List.ContentTypes.Count - 1; $index -ge 0; $index--) {
                        $ContentType = $List.ContentTypes[$index]
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
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
                $Params = @{
                    ParentObject = $List
                    Name = 'Test Content Type 0'
                }
                $Result = New-SPClientContentType @Params
                $Result | Should Not BeNullOrEmpty
                $Result | Should BeOfType 'Microsoft.SharePoint.Client.ContentType'
                $Result.Name | Should Be 'Test Content Type 0'
                $Result.Description | Should BeNullOrEmpty
                $Result.Group | Should Be 'List Content Types'
                $Result.StringId | Should BeLike '0x0100*'
            }

            It 'Creates a new content type with all parameters' {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
                $ContentType = $SPClient.ClientContext.Site.RootWeb.ContentTypes.GetById('0x0101')
                $Params = @{ 
                    ParentObject = $List
                    Name = 'Test Content Type 0'
                    Description = 'Test Content Type 0'
                    Group = 'Test Content Type 0'
                    ParentContentType = $ContentType
                }
                $Result = New-SPClientContentType @Params
                $Result | Should Not BeNullOrEmpty
                $Result | Should BeOfType 'Microsoft.SharePoint.Client.ContentType'
                $Result.Name | Should Be 'Test Content Type 0'
                $Result.Description | Should Be 'Test Content Type 0'
                $Result.Group | Should Be 'Test Content Type 0'
                $Result.StringId | Should BeLike '0x010100*' 
            }

        }

    }

}

#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'Remove-SPClientContentType' {

    Context 'Success' {

        Context 'Site Content Type' {

            BeforeEach {
                try {
                    $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                    $ContentType = New-Object Microsoft.SharePoint.Client.ContentTypeCreationInformation
                    $ContentType.Id = '0x0100E29372CEECF346BD82ADB95FFF0C637D'
                    $ContentType.Name = 'Test Content Type 0'
                    $ContentType = $Web.ContentTypes.Add($ContentType)
                    $SPClient.ClientContext.Load($ContentType)
                    $SPClient.ClientContext.ExecuteQuery()
                } catch {
                    Write-Host $_ -ForegroundColor Yellow 
                }
            }

            It 'Removes a content type by loaded client object' {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $ContentType = $Web.ContentTypes.GetById('0x0100E29372CEECF346BD82ADB95FFF0C637D')
                $SPClient.ClientContext.Load($ContentType)
                $SPClient.ClientContext.ExecuteQuery()
                $Params = @{
                    ClientObject = $ContentType
                }
                $Result = Remove-SPClientContentType @Params
                $Result | Should BeNullOrEmpty
            }

            It 'Removes a content type by unloaded client object' {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $ContentType = $Web.ContentTypes.GetById('0x0100E29372CEECF346BD82ADB95FFF0C637D')
                $Params = @{
                    ClientObject = $ContentType
                }
                $Result = Remove-SPClientContentType @Params
                $Result | Should BeNullOrEmpty
            }

            It 'Removes a content type by id' {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $Params = @{
                    ParentObject = $Web
                    Identity = '0x0100E29372CEECF346BD82ADB95FFF0C637D'
                }
                $Result = Remove-SPClientContentType @Params
                $Result | Should BeNullOrEmpty
            }

            It 'Removes a content type by name' {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $Params = @{
                    ParentObject = $Web
                    Name = 'Test Content Type 0'
                }
                $Result = Remove-SPClientContentType @Params
                $Result | Should BeNullOrEmpty
            }

        }

        Context 'List Content Type' {

            BeforeEach {
                try {
                    $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                    $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
                    $ContentType = New-Object Microsoft.SharePoint.Client.ContentTypeCreationInformation
                    $ContentType.Id = '0x0100E29372CEECF346BD82ADB95FFF0C637D'
                    $ContentType.Name = 'Test Content Type 0'
                    $ContentType = $List.ContentTypes.Add($ContentType)
                    $SPClient.ClientContext.Load($ContentType)
                    $SPClient.ClientContext.ExecuteQuery()
                } catch {
                    Write-Host $_ -ForegroundColor Yellow 
                }
            }

            It 'Removes a content type by loaded client object' {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
                $ContentType = $List.ContentTypes.GetById('0x0100E29372CEECF346BD82ADB95FFF0C637D')
                $SPClient.ClientContext.Load($ContentType)
                $SPClient.ClientContext.ExecuteQuery()
                $Params = @{
                    ClientObject = $ContentType
                }
                $Result = Remove-SPClientContentType @Params
                $Result | Should BeNullOrEmpty
            }

            It 'Removes a content type by unloaded client object' {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
                $ContentType = $List.ContentTypes.GetById('0x0100E29372CEECF346BD82ADB95FFF0C637D')
                $Params = @{
                    ClientObject = $ContentType
                }
                $Result = Remove-SPClientContentType @Params
                $Result | Should BeNullOrEmpty
            }

            It 'Removes a content type by id' {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
                $Params = @{
                    ParentObject = $List
                    Identity = '0x0100E29372CEECF346BD82ADB95FFF0C637D'
                }
                $Result = Remove-SPClientContentType @Params
                $Result | Should BeNullOrEmpty
            }

            It 'Removes a content type by name' {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $List = $Web.Lists.GetById($SPClient.TestConfig.ListId)
                $Params = @{
                    ParentObject = $List
                    Name = 'Test Content Type 0'
                }
                $Result = Remove-SPClientContentType @Params
                $Result | Should BeNullOrEmpty
            }

        }

    }

    Context 'Failure' {

        It 'Throws an error when the content type could not be found by id' {
            $Throw = {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $Params = @{
                    ParentObject = $Web
                    Identity = '0x0100E29372CEECF346BD82ADB95FFF0C637D'
                }
                $Result = Remove-SPClientContentType @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'The specified content type could not be found.'
        }

        It 'Throws an error when the content type could not be found by name' {
            $Throw = {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $Params = @{
                    ParentObject = $Web
                    Name = 'Test Content Type 0'
                }
                $Result = Remove-SPClientContentType @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'The specified content type could not be found.'
        }

    }

}

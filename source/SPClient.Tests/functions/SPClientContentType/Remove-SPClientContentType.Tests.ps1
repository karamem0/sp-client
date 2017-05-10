#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'Remove-SPClientContentType' {

    Context 'Success' {

        BeforeEach {
            try {
                $Web = $SPClient.ClientContext.Site.OpenWebById($TestConfig.WebId)
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
            $Web = Get-SPClientWeb -Identity $TestConfig.WebId
            $ContentType = Get-SPClientContentType -ParentObject $Web -Identity '0x0100E29372CEECF346BD82ADB95FFF0C637D'
            $Params = @{
                ClientObject = $ContentType
            }
            $Result = Remove-SPClientContentType @Params
            $Result | Should BeNullOrEmpty
        }

        It 'Removes a content type by unloaded client object' {
            $Web = Get-SPClientWeb -Identity $TestConfig.WebId
            $ContentType = $Web.ContentTypes.GetById('0x0100E29372CEECF346BD82ADB95FFF0C637D')
            $Params = @{
                ClientObject = $ContentType
            }
            $Result = Remove-SPClientContentType @Params
            $Result | Should BeNullOrEmpty
        }

        It 'Removes a content type by id' {
            $Web = Get-SPClientWeb -Identity $TestConfig.WebId
            $Params = @{
                ParentObject = $Web
                Identity = '0x0100E29372CEECF346BD82ADB95FFF0C637D'
            }
            $Result = Remove-SPClientContentType @Params
            $Result | Should BeNullOrEmpty
        }

        It 'Removes a content type by name' {
            $Web = Get-SPClientWeb -Identity $TestConfig.WebId
            $Params = @{
                ParentObject = $Web
                Name = 'Test Content Type 0'
            }
            $Result = Remove-SPClientContentType @Params
            $Result | Should BeNullOrEmpty
        }

    }

    Context 'Failure' {

        It 'Throws an error when the content type could not be found by id' {
            $Throw = {
                $Web = Get-SPClientWeb -Identity $TestConfig.WebId
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
                $Web = Get-SPClientWeb -Identity $TestConfig.WebId
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

#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'Get-SPClientContentType' {

    Context 'Success' {

        It 'Returns all content types' {
            $Web = Get-SPClientWeb -Identity $TestConfig.WebId
            $Params = @{
                ParentObject = $Web
            }
            $Result = Get-SPClientContentType @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.ContentType'
        }

        It 'Returns a content type by id' {
            $Web = Get-SPClientWeb -Identity $TestConfig.WebId
            $Params = @{
                ParentObject = $Web
                Identity = $TestConfig.ContentTypeId
            }
            $Result = Get-SPClientContentType @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.ContentType'
            $Result.StringId | Should Be $Params.Identity
        }

        It 'Returns a content type by name' {
            $Web = Get-SPClientWeb -Identity $TestConfig.WebId
            $Params = @{
                ParentObject = $Web
                Name = $TestConfig.ContentTypeName
            }
            $Result = Get-SPClientContentType @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should BeOfType 'Microsoft.SharePoint.Client.ContentType'
            $Result.Name | Should Be $Params.Name
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
                $Result = Get-SPClientContentType @Params
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
                $Result = Get-SPClientContentType @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'The specified content type could not be found.'
        }

    }

}

#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'Get-SPClientFeature' {

    Context 'Success' {

        Context 'Site Collection Features' {

            It 'Returns all features' {
                $Params = @{ }
                $Result = Get-SPClientFeature @Params
                $Result | Should Not BeNullOrEmpty
                $Result | Should BeOfType 'Microsoft.SharePoint.Client.Feature'
            }

            It 'Returns a feature by id' {
                $Params = @{
                    Identity = $SPClient.TestConfig.SiteFeatureId
                }
                $Result = Get-SPClientFeature @Params
                $Result | Should Not BeNullOrEmpty
                $Result | Should BeOfType 'Microsoft.SharePoint.Client.Feature'
            }

        }

        Context 'Site Features' {

            It 'Returns all features' {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $Params = @{
                    ParentObject = $Web
                }
                $Result = Get-SPClientFeature @Params
                $Result | Should Not BeNullOrEmpty
                $Result | Should BeOfType 'Microsoft.SharePoint.Client.Feature'
            }

            It 'Returns a feature by id' {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $Params = @{
                    ParentObject = $Web
                    Identity = $SPClient.TestConfig.WebFeatureId
                }
                $Result = Get-SPClientFeature @Params
                $Result | Should Not BeNullOrEmpty
                $Result | Should BeOfType 'Microsoft.SharePoint.Client.Feature'
            }

        }

    }

    Context 'Failure' {

        It 'Throws an error when the feature could not be found by id' {
            $Throw = {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $Params = @{
                    Identity = '84370E78-AD1B-469E-8068-8B7303C8A55B'
                }
                $Result = Get-SPClientFeature @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'The specified feature could not be found.'
        }

    }

}

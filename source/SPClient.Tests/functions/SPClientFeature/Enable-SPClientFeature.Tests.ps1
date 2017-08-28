#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'Enable-SPClientFeature' {

    Context 'Success' {

        Context 'Site Collection Features' {

            BeforeEach {
                try {
                    $Site = $SPClient.ClientContext.Site
                    $Site.Features.Remove($SPClient.TestConfig.SiteFeatureId, $true)
                    $SPClient.ClientContext.ExecuteQuery()
                } catch {
                    Write-Host $_ -ForegroundColor Yellow 
                }
            }

            It 'Enables a feature' {
                $Params = @{
                    Identity = $SPClient.TestConfig.SiteFeatureId
                    PassThru = $true
                }
                $Result = Enable-SPClientFeature @Params
                $Result | Should Not BeNullOrEmpty
                $Result | Should BeOfType 'Microsoft.SharePoint.Client.Site'
                $Result.Features | Where-Object { $_.DefinitionId -eq  $SPClient.TestConfig.SiteFeatureId } | Should Not BeNullOrEmpty
            }

        }

        Context 'Site Features' {

            BeforeEach {
                try {
                    $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                    $Web.Features.Remove($SPClient.TestConfig.WebFeatureId, $true)
                    $SPClient.ClientContext.ExecuteQuery()
                } catch {
                    Write-Host $_ -ForegroundColor Yellow 
                }
            }

            It 'Enables a feature' {
                $Web = $SPClient.ClientContext.Site.OpenWebById($SPClient.TestConfig.WebId)
                $Params = @{
                    ParentObject = $Web
                    Identity = $SPClient.TestConfig.WebFeatureId
                    PassThru = $true
                }
                $Result = Enable-SPClientFeature @Params
                $Result | Should Not BeNullOrEmpty
                $Result | Should BeOfType 'Microsoft.SharePoint.Client.Web'
                $Result.Features | Where-Object { $_.DefinitionId -eq  $SPClient.TestConfig.WebFeatureId } | Should Not BeNullOrEmpty
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
                $Result = Enable-SPClientFeature @Params
                $Result | Should Not BeNullOrEmpty
            }
            $Throw | Should Throw 'The specified feature could not be found.'
        }

    }

}

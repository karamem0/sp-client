#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'ConvertTo-SPClientRelativeUrl' {

    Context 'Success' {

        It 'Converts a absolute url to a relative url' {
            $AbsoluteUrl = $SPClient.TestConfig.RootUrl + $SPClient.TestConfig.ListUrl
            $RelativeUrl = $SPClient.TestConfig.ListUrl
            $Params = @{
                Url = $AbsoluteUrl
            }
            $Result = ConvertTo-SPClientRelativeUrl @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should Be $RelativeUrl
        }

        It 'Converts a relative url to a relative url' {
            $AbsoluteUrl = $SPClient.TestConfig.RootUrl + $SPClient.TestConfig.ListUrl
            $RelativeUrl = $SPClient.TestConfig.ListUrl
            $Params = @{
                Url = $RelativeUrl
            }
            $Result = ConvertTo-SPClientRelativeUrl @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should Be $RelativeUrl
        }

    }

}

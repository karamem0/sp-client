#Requires -Version 3.0

. "$($PSScriptRoot)\..\..\TestInitialize.ps1"

Describe 'ConvertTo-SPClientAbsoluteUrl' {

    Context 'Success' {

        It 'Converts a relative url to a absolute url' {
            $AbsoluteUrl = $SPClient.TestConfig.RootUrl + $SPClient.TestConfig.ListUrl
            $RelativeUrl = $SPClient.TestConfig.ListUrl
            $Params = @{
                Url = $RelativeUrl
            }
            $Result = ConvertTo-SPClientAbsoluteUrl @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should Be $AbsoluteUrl
        }

        It 'Converts a absolute url to a absolute url' {
            $AbsoluteUrl = $SPClient.TestConfig.RootUrl + $SPClient.TestConfig.ListUrl
            $RelativeUrl = $SPClient.TestConfig.ListUrl
            $Params = @{
                Url = $AbsoluteUrl
            }
            $Result = ConvertTo-SPClientAbsoluteUrl @Params
            $Result | Should Not BeNullOrEmpty
            $Result | Should Be $AbsoluteUrl
        }

    }

}

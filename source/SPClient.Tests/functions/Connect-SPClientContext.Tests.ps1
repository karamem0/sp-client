#Requires -Version 3.0

. "${PSScriptRoot}\..\TestInitialize.ps1"

Describe 'Connect-SPClientContext' {

    BeforeEach {
        Add-SPClientType
    }

    It 'Returns a context which connects to SharePoint Server' {
        try {
            $param = @{
                Network = $true
                Url = $TestConfig.LoginUrl
                UserName = $TestConfig.LoginUserName
                Password = (ConvertTo-SecureString -String $TestConfig.LoginPassword -AsPlainText -Force)
                Domain = $TestConfig.LoginDomain
                PassThru = $true
            }
            $result = Connect-SPClientContext @param
            $result | Should Not Be $null
            $result.Credentials.GetType() | Should Be 'System.Net.NetworkCredential' 
            $result.Credentials.UserName | Should Be $TestConfig.LoginUserName
            $result.Credentials.Domain | Should Be $TestConfig.LoginDomain
        } finally { }
    }

    It 'Returns a context which connects to SharePoint Online' {
        try {
            $param = @{
                Online = $true
                Url = $TestConfig.LoginUrl
                UserName = $TestConfig.LoginUserName
                Password = (ConvertTo-SecureString -String $TestConfig.LoginPassword -AsPlainText -Force)
                PassThru = $true
            }
            $result = Connect-SPClientContext @param
            $result | Should Not Be $null
            $result.Credentials.GetType() | Should Be 'Microsoft.SharePoint.Client.SharePointOnlineCredentials' 
            $result.Credentials.UserName | Should Be $TestConfig.LoginUserName
        } finally { }
    }

}

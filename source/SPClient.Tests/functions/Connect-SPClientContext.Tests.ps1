#Requires -Version 3.0

. "${PSScriptRoot}\..\TestInitialize.ps1"

Describe 'Connect-SPClientContext' {

    BeforeEach {
        Add-SPClientType
    }

    It 'Returns a context which connects to SharePoint Server' {
        $param = @{
            Network = $true
            Url = $TestConfig.SharePointServerUrl
            UserName = $TestConfig.SharePointServerUserName
            Password = (ConvertTo-SecureString -String $TestConfig.SharePointServerPassword -AsPlainText -Force)
            Domain = $TestConfig.SharePointServerDomain
            PassThru = $true
        }
        $result = Connect-SPClientContext @param
        $result | Should Not Be $null
        $result.Credentials.GetType() | Should Be 'System.Net.NetworkCredential' 
        $result.Credentials.UserName | Should Be $TestConfig.SharePointServerUserName
        $result.Credentials.Domain | Should Be $TestConfig.SharePointServerDomain
    }

    It 'Returns a context which connects to SharePoint Online' {
        $param = @{
            Online = $true
            Url = $TestConfig.SharePointOnlineUrl
            UserName = $TestConfig.SharePointOnlineUserName
            Password = (ConvertTo-SecureString -String $TestConfig.SharePointOnlinePassword -AsPlainText -Force)
            PassThru = $true
        }
        $result = Connect-SPClientContext @param
        $result | Should Not Be $null
        $result.Credentials.GetType() | Should Be 'Microsoft.SharePoint.Client.SharePointOnlineCredentials' 
        $result.Credentials.UserName | Should Be $TestConfig.SharePointOnlineUserName
    }

}

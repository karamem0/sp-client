#Requires -Version 3.0

. "${PSScriptRoot}\..\..\TestInitialize.ps1"

Describe 'Connect-SPClientContext' {

    BeforeEach {
        Add-SPClientType
    }

    It 'Connects to the SharePoint Server using password' {
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

    It 'Connects to the SharePoint Server using credential' {
        try {
            $param = @{
                Network = $true
                Url = $TestConfig.LoginUrl
                Credential = New-Object System.Management.Automation.PSCredential( `
                    $TestConfig.LoginUserName, `
                    (ConvertTo-SecureString -String $TestConfig.LoginPassword -AsPlainText -Force)
                )
                PassThru = $true
            }
            $result = Connect-SPClientContext @param
            $result | Should Not Be $null
            $result.Credentials.GetType() | Should Be 'System.Net.NetworkCredential' 
            $result.Credentials.UserName | Should Be $TestConfig.LoginUserName
        } finally { }
    }

    It 'Connects to the SharePoint Online using password' {
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

    It 'Connects to the SharePoint Online using credential' {
        try {
            $param = @{
                Online = $true
                Url = $TestConfig.LoginUrl
                Credential = New-Object System.Management.Automation.PSCredential( `
                    $TestConfig.LoginUserName, `
                    (ConvertTo-SecureString -String $TestConfig.LoginPassword -AsPlainText -Force)
                )
                PassThru = $true
            }
            $result = Connect-SPClientContext @param
            $result | Should Not Be $null
            $result.Credentials.GetType() | Should Be 'Microsoft.SharePoint.Client.SharePointOnlineCredentials' 
            $result.Credentials.UserName | Should Be $TestConfig.LoginUserName
        } finally { }
    }

}

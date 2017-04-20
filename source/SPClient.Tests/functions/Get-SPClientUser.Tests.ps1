#Requires -Version 3.0

. "${PSScriptRoot}\..\TestInitialize.ps1"

Describe 'Get-SPClientUser' {
        
    BeforeEach {
        Add-SPClientType
        Connect-SPClientContext `
            -Url $TestConfig.SharePointOnlineUrl `
            -Online `
            -UserName $TestConfig.SharePointOnlineUserName `
            -Password (ConvertTo-SecureString -String $TestConfig.SharePointOnlinePassword -AsPlainText -Force)
    }

    It 'Returns all users' {
        $web = Get-SPClientWeb -Default
        $result = $web | Get-SPClientUser
        $result | Should Not Be $null
        $result.GetType() | Should Be 'Microsoft.SharePoint.Client.UserCollection'
        $result | ForEach-Object { Write-Host $_.Title }
    }

    It 'Returns a user by login name' {
        $web = Get-SPClientWeb -Default
        $param = @{
            Identity = $TestConfig.SharePointOnlineUserName
        }
        $result = $web | Get-SPClientUser @param
        $result | Should Not Be $null
        $result.GetType() | Should Be 'Microsoft.SharePoint.Client.User'
        $result.Email | Should Be $TestConfig.SharePointOnlineUserName
        $result | ForEach-Object { Write-Host $_.Title }
    }

    It 'Throws an error when the user could not be found by login name' {
        $throw = {
            $web = Get-SPClientWeb -Default
            $param = @{
                Identity = 'Not Found'
            }
            $result = $web | Get-SPClientUser @param
            $result | ForEach-Object { Write-Host $_.Title }
        }
        $throw | Should Throw
    }

}

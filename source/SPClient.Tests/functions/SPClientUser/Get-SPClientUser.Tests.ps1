#Requires -Version 3.0

. "${PSScriptRoot}\..\..\TestInitialize.ps1"

Describe 'Get-SPClientUser' {
        
    BeforeEach {
        Add-SPClientType
        Connect-SPClientContext `
            -Url $TestConfig.LoginUrl `
            -Online `
            -UserName $TestConfig.LoginUserName `
            -Password (ConvertTo-SecureString -String $TestConfig.LoginPassword -AsPlainText -Force)
    }

    It 'Returns all users' {
        $web = Get-SPClientWeb -Default
        $result = $web | Get-SPClientUser
        $result | Should Not Be $null
        $result.GetType() | Should Be 'Microsoft.SharePoint.Client.UserCollection'
        $result | ForEach-Object { Write-Host "$(' ' * 3)$($_.LoginName)" }
    }

    It 'Returns a user by id' {
        $web = Get-SPClientWeb -Default -Retrievals 'SiteUsers'
        $param = @{
            Identity = $web.SiteUsers[0].Id
        }
        $result = $web | Get-SPClientUser @param
        $result | Should Not Be $null
        $result.GetType() | Should Be 'Microsoft.SharePoint.Client.User'
        $result | ForEach-Object { Write-Host "$(' ' * 3)$($_.LoginName)" }
    }

    It 'Returns a domain user by login name' {
        $web = Get-SPClientWeb -Default
        $param = @{
            Name = $TestConfig.DomainUserName
        }
        $result = $web | Get-SPClientUser @param
        $result | Should Not Be $null
        $result.GetType() | Should Be 'Microsoft.SharePoint.Client.User'
        $result | ForEach-Object { Write-Host "$(' ' * 3)$($_.LoginName)" }
    }

    It 'Returns a domain group by login name' {
        $web = Get-SPClientWeb -Default
        $param = @{
            Name = $TestConfig.DomainGroupName
        }
        $result = $web | Get-SPClientUser @param
        $result | Should Not Be $null
        $result.GetType() | Should Be 'Microsoft.SharePoint.Client.User'
        $result | ForEach-Object { Write-Host "$(' ' * 3)$($_.LoginName)" }
    }

    It 'Throws an error when the user could not be found by login name' {
        $throw = {
            $web = Get-SPClientWeb -Default
            $param = @{
                Identity = 'Not Found'
            }
            $result = $web | Get-SPClientUser @param
            $result | ForEach-Object { Write-Host "$(' ' * 3)$($_.LoginName)" }
        }
        $throw | Should Throw
    }

}

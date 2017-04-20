#Requires -Version 3.0

. "${PSScriptRoot}\..\..\TestInitialize.ps1"

Describe 'Get-SPClientGroup' {
        
    BeforeEach {
        Add-SPClientType
        Connect-SPClientContext `
            -Url $TestConfig.LoginUrl `
            -Online `
            -UserName $TestConfig.LoginUserName `
            -Password (ConvertTo-SecureString -String $TestConfig.LoginPassword -AsPlainText -Force)
    }

    It 'Returns all groups' {
        $web = Get-SPClientWeb -Default
        $result = $web | Get-SPClientGroup
        $result | Should Not Be $null
        $result.GetType() | Should Be 'Microsoft.SharePoint.Client.GroupCollection'
        $result | ForEach-Object { Write-Host "$(' ' * 3)$($_.LoginName)" }
    }

    It 'Returns a SharePoint group by id' {
        $web = Get-SPClientWeb -Default -Retrievals 'SiteGroups'
        $param = @{
            Identity = $web.SiteGroups[0].Id
        }
        $result = $web | Get-SPClientGroup @param
        $result | Should Not Be $null
        $result.GetType() | Should Be 'Microsoft.SharePoint.Client.Group'
        $result | ForEach-Object { Write-Host "$(' ' * 3)$($_.LoginName)" }
    }

    It 'Returns a SharePoint group by login name' {
        $web = Get-SPClientWeb -Default
        $param = @{
            Name = $TestConfig.SharePointGroupName
        }
        $result = $web | Get-SPClientGroup @param
        $result | Should Not Be $null
        $result.GetType() | Should Be 'Microsoft.SharePoint.Client.Group'
        $result | ForEach-Object { Write-Host "$(' ' * 3)$($_.LoginName)" }
    }

    It 'Throws an error when the group could not be found by id' {
        $throw = {
            $web = Get-SPClientWeb -Default
            $param = @{
                Identity = 'Not Found'
            }
            $result = $web | Get-SPClientGroup @param
            $result | ForEach-Object { Write-Host "$(' ' * 3)$($_.LoginName)" }
        }
        $throw | Should Throw
    }

}

#Requires -Version 3.0

. "${PSScriptRoot}\..\TestInitialize.ps1"

Describe 'Get-SPClientWeb' {

    BeforeEach {
        Add-SPClientType
        Connect-SPClientContext `
            -Url $TestConfig.LoginUrl `
            -Online `
            -UserName $TestConfig.LoginUserName `
            -Password (ConvertTo-SecureString -String $TestConfig.LoginPassword -AsPlainText -Force)
    }

    It 'Gets all webs' {
        $result = Get-SPClientWeb
        $result | Should Not Be $null
        $result | ForEach-Object { Write-Host "$(' ' * 3)$($_.Title)" }
    }

    It 'Gets a web by id' {
        $param = @{
            Identity = $TestConfig.WebId
        }
        $result = Get-SPClientWeb @param
        $result | Should Not Be $null
        $result.GetType() | Should Be 'Microsoft.SharePoint.Client.Web'
        $result.Id | Should Be $param.Identity
        $result | ForEach-Object { Write-Host "$(' ' * 3)$($_.Title)" }
    }

    It 'Gets a web by url' {
        $param = @{
            Url = $TestConfig.WebUrl
        }
        $result = Get-SPClientWeb @param
        $result | Should Not Be $null
        $result.GetType() | Should Be 'Microsoft.SharePoint.Client.Web'
        $result.ServerRelativeUrl | Should Be $param.Url
        $result | ForEach-Object { Write-Host "$(' ' * 3)$($_.Title)" }
    }

    It 'Gets the default web' {
        $param = @{
            Default = $true
        }
        $result = Get-SPClientWeb @param
        $result | Should Not Be $null
        $result.GetType() | Should Be 'Microsoft.SharePoint.Client.Web'
        $result | ForEach-Object { Write-Host "$(' ' * 3)$($_.Title)" }
    }

    It 'Gets the root web' {
        $param = @{
            Root = $true
        }
        $result = Get-SPClientWeb @param
        $result | Should Not Be $null
        $result.GetType() | Should Be 'Microsoft.SharePoint.Client.Web'
        $result.ServerRelativeUrl | Should Be '/'
        $result | ForEach-Object { Write-Host "$(' ' * 3)$($_.Title)" }
    }

    It 'Throws an error when the web could not be found by id' {
        $throw = {
            $param = @{
                Identity = [guid]::Empty
            }
            $result = Get-SPClientWeb @param
            $result | ForEach-Object { Write-Host "$(' ' * 3)$($_.Title)" }
        }
        $throw | Should Throw
    }

    It 'Throws an error when the web could not be found by url' {
        $throw = {
            $param = @{
                Url = '/NotFound'
            }
            $result = Get-SPClientWeb @param
            $result | ForEach-Object { Write-Host "$(' ' * 3)$($_.Title)" }
        }
        $throw | Should Throw
    }

}

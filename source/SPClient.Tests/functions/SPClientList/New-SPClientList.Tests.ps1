#Requires -Version 3.0

. "${PSScriptRoot}\..\..\TestInitialize.ps1"

Describe 'New-SPClientList' {

    BeforeEach {
        Add-SPClientType
        Connect-SPClientContext `
            -Url $TestConfig.LoginUrl `
            -Online `
            -UserName $TestConfig.LoginUserName `
            -Password (ConvertTo-SecureString -String $TestConfig.LoginPassword -AsPlainText -Force)
    }

    It 'Creates a new list with mandatory parameters' {
        try {
            $web = Get-SPClientWeb -Url $TestConfig.WebUrl
            $param = @{
                Title = 'Title of NewList1'
            }
            $result = $web | New-SPClientList @param
            $result | Should Not Be $null
            $result.GetType() | Should Be 'Microsoft.SharePoint.Client.List'
            $result.Title | Should Be 'Title of NewList1'
            $result.BaseTemplate | Should Be 100
            $result | ForEach-Object { Write-Host "$(' ' * 3)$($_.Title)" }
        } finally {
            $web = Get-SPClientWeb -Url $TestConfig.WebUrl
            $list = $web | Get-SPClientList -Title 'Title of NewList1'
            $list | Remove-SPClientList
        }
    }

    It 'Creates a new list with all parameters' {
        try {
            $web = Get-SPClientWeb -Url $TestConfig.WebUrl
            $param = @{
                Title = 'Title of NewList1'
                Description = 'Description of NewList1'
                Url = 'NewList1'
                Template = 107
                QuickLaunch = $true
            }
            $result = $web | New-SPClientList @param
            $result | Should Not Be $null
            $result.GetType() | Should Be 'Microsoft.SharePoint.Client.List'
            $result.Title | Should Be 'Title of NewList1'
            $result.BaseTemplate | Should Be 107
            $result.OnQuickLaunch | Should Be $true
            $result | ForEach-Object { Write-Host "$(' ' * 3)$($_.Title)" }
        } finally {
            $web = Get-SPClientWeb -Url $TestConfig.WebUrl
            $list = $web | Get-SPClientList -Title 'Title of NewList1'
            $list | Remove-SPClientList
        }
    }

}

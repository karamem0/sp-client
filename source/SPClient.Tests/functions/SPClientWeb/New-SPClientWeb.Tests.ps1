#Requires -Version 3.0

. "${PSScriptRoot}\..\..\TestInitialize.ps1"

Describe 'New-SPClientWeb' {

    BeforeEach {
        Add-SPClientType
        Connect-SPClientContext `
            -Url $TestConfig.LoginUrl `
            -Online `
            -UserName $TestConfig.LoginUserName `
            -Password (ConvertTo-SecureString -String $TestConfig.LoginPassword -AsPlainText -Force)
    }

    It 'Creates a new web with mandatory parameters' {
        try {
            $web = Get-SPClientWeb -Url $TestConfig.WebUrl
            $param = @{
                Url = 'NewSite1'
            }
            $result = $web | New-SPClientWeb @param
            $result | Should Not Be $null
            $result.GetType() | Should Be 'Microsoft.SharePoint.Client.Web'
            $result | ForEach-Object { Write-Host "$(' ' * 3)$($_.Title)" }
        } finally {
            $web = Get-SPClientWeb -Url "$($TestConfig.WebUrl)/NewSite1"
            $web | Remove-SPClientWeb
        }
    }

    It 'Creates a new web with all parameters' {
        try {
            $web = Get-SPClientWeb -Url $TestConfig.WebUrl
            $param = @{
                Url = 'NewSite1'
                Title = 'Title of NewSite1'
                Description = 'Description of NewSite1'
                Language = 1041
                Template = 'STS#1'
                UniquePermissions = $true
            }
            $result = $web | New-SPClientWeb @param
            $result | Should Not Be $null
            $result.GetType() | Should Be 'Microsoft.SharePoint.Client.Web'
            $result.Title | Should Be 'Title of NewSite1'
            $result.Description | Should Be 'Description of NewSite1'
            $result.Language | Should Be 1041
            $result.WebTemplate | Should Be 'STS'
            $result.Configuration | Should Be 1
            $result | ForEach-Object { Write-Host "$(' ' * 3)$($_.Title)" }
        } finally {
            $web = Get-SPClientWeb -Url "$($TestConfig.WebUrl)/NewSite1"
            $web | Remove-SPClientWeb
        }
    }

}

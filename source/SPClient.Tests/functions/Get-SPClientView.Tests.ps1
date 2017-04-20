#Requires -Version 3.0

$testProjectDir = [String](Resolve-Path -Path ($MyInvocation.MyCommand.Path + '\..\..\'))
$targetProjectDir = $testProjectDir.Replace('.Tests\', '\')

Get-ChildItem -Path $targetProjectDir -Recurse `
    | Where-Object { -not $_.FullName.Contains('.Tests.') } `
    | Where-Object Extension -eq '.ps1' `
    | ForEach-Object { . $_.FullName }

$testConfig = [Xml](Get-Content "${testProjectDir}\TestConfiguration.xml")

$Script:SPClient = @{}

Describe 'Get-SPClientView' {
	Context 'Gets views without parameter' {
        Add-SPClientType
        Connect-SPClientContext `
            -Url $testConfig.configuration.sharePointOnlineUrl `
            -Online `
            -UserName $testConfig.configuration.sharePointOnlineUserName `
            -Password (ConvertTo-SecureString -AsPlainText $testConfig.configuration.sharePointOnlinePassword -Force)
        $list = Get-SPClientList -Url '/SitePages'
        $result = Get-SPClientView -List $list
        It 'Return value is not null' {
            $result | Should Not Be $null
            $result.Count | Should Not Be 0
        }
        $result | ForEach-Object { Write-Host $_.Title } 
	}
	Context 'Gets a view by title' {
        Add-SPClientType
        Connect-SPClientContext `
            -Url $testConfig.configuration.sharePointOnlineUrl `
            -Online `
            -UserName $testConfig.configuration.sharePointOnlineUserName `
            -Password (ConvertTo-SecureString -AsPlainText $testConfig.configuration.sharePointOnlinePassword -Force)
        $list = Get-SPClientList -Url '/SitePages'
        $result = Get-SPClientView -List $list -Title 'All Pages'
        It 'Return value is not null' {
            $result | Should Not Be $null
            $result.Count | Should Be 1
        }
        It 'View title is valid' {
            $result.Title | Should Be 'All Pages'
        }
        $result | ForEach-Object { Write-Host $_.Title } 
	}
	Context 'Gets the default view' {
        Add-SPClientType
        Connect-SPClientContext `
            -Url $testConfig.configuration.sharePointOnlineUrl `
            -Online `
            -UserName $testConfig.configuration.sharePointOnlineUserName `
            -Password (ConvertTo-SecureString -AsPlainText $testConfig.configuration.sharePointOnlinePassword -Force)
        $list = Get-SPClientList -Url '/SitePages'
        $result = Get-SPClientView -List $list -Default
        It 'Return value is not null' {
            $result | Should Not Be $null
            $result.Count | Should Be 1
        }
        It 'View title is valid' {
            $result.DefaultView  | Should Be $true
        }
        $result | ForEach-Object { Write-Host $_.Title } 
    }
}

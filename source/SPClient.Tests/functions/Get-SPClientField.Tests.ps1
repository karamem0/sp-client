#Requires -Version 3.0

$testProjectDir = [String](Resolve-Path -Path ($MyInvocation.MyCommand.Path + '\..\..\'))
$targetProjectDir = $testProjectDir.Replace('.Tests\', '\')

Get-ChildItem -Path $targetProjectDir -Recurse `
    | Where-Object { -not $_.FullName.Contains('.Tests.') } `
    | Where-Object Extension -eq '.ps1' `
    | ForEach-Object { . $_.FullName }

$testConfig = [Xml](Get-Content "${testProjectDir}\TestConfiguration.xml")

$Script:SPClient = @{}

Describe 'Get-SPClientField' {
	Context 'Gets fields without parameter' {
        Add-SPClientType
        Connect-SPClientContext `
            -Url $testConfig.configuration.sharePointOnlineUrl `
            -Online `
            -UserName $testConfig.configuration.sharePointOnlineUserName `
            -Password (ConvertTo-SecureString -AsPlainText $testConfig.configuration.sharePointOnlinePassword -Force)
        $list = Get-SPClientList -Url '/SitePages'
        $result = Get-SPClientField -List $list
        It 'Return value is not null' {
            $result | Should Not Be $null
            $result.Count | Should Not Be 0
        }
        $result | ForEach-Object { Write-Host $_.Title } 
	}
	Context 'Gets a field by title' {
        Add-SPClientType
        Connect-SPClientContext `
            -Url $testConfig.configuration.sharePointOnlineUrl `
            -Online `
            -UserName $testConfig.configuration.sharePointOnlineUserName `
            -Password (ConvertTo-SecureString -AsPlainText $testConfig.configuration.sharePointOnlinePassword -Force)
        $list = Get-SPClientList -Url '/SitePages'
        $result = Get-SPClientField -List $list -Title 'Checked Out To'
        It 'Return value is not null' {
            $result | Should Not Be $null
            $result.Count | Should Be 1
        }
        It 'View title is valid' {
            $result.Title | Should Be 'Checked Out To'
        }
        $result | ForEach-Object { Write-Host $_.Title } 
	}
	Context 'Gets a field by internal name' {
        Add-SPClientType
        Connect-SPClientContext `
            -Url $testConfig.configuration.sharePointOnlineUrl `
            -Online `
            -UserName $testConfig.configuration.sharePointOnlineUserName `
            -Password (ConvertTo-SecureString -AsPlainText $testConfig.configuration.sharePointOnlinePassword -Force)
        $list = Get-SPClientList -Url '/SitePages'
        $result = Get-SPClientField -List $list -Title 'CheckoutUser'
        It 'Return value is not null' {
            $result | Should Not Be $null
            $result.Count | Should Be 1
        }
        It 'View title is valid' {
            $result.Title | Should Be 'Checked Out To'
        }
        $result | ForEach-Object { Write-Host $_.Title } 
	}
}

#Requires -Version 3.0

$testProjectDir = [String](Resolve-Path -Path ($MyInvocation.MyCommand.Path + '\..\..\'))
$targetProjectDir = $testProjectDir.Replace('.Tests\', '\')

Get-ChildItem -Path $targetProjectDir -Recurse `
    | Where-Object { -not $_.FullName.Contains('.Tests.') } `
    | Where-Object Extension -eq '.ps1' `
    | ForEach-Object { . $_.FullName }

$testConfig = [Xml](Get-Content "${testProjectDir}\TestConfiguration.xml")

$Script:SPClient = @{}

Describe 'Get-SPClientList' {
	Context 'Gets lists without parameter' {
        Add-SPClientType
        Connect-SPClientContext `
            -Url $testConfig.configuration.sharePointOnlineUrl `
            -Online `
            -UserName $testConfig.configuration.sharePointOnlineUserName `
            -Password (ConvertTo-SecureString -AsPlainText $testConfig.configuration.sharePointOnlinePassword -Force)
        $result = Get-SPClientList
        It 'Return value is not null' {
            $result | Should Not Be $null
            $result.Count | Should Not Be 0
        }
	}
	Context 'Gets a list by url' {
        Add-SPClientType
        Connect-SPClientContext `
            -Url $testConfig.configuration.sharePointOnlineUrl `
            -Online `
            -UserName $testConfig.configuration.sharePointOnlineUserName `
            -Password (ConvertTo-SecureString -AsPlainText $testConfig.configuration.sharePointOnlinePassword -Force)
        $result = Get-SPClientList -Url "/SitePages"
        It 'Return value is not null' {
            $result | Should Not Be $null
            $result.Count | Should Be 1
        }
        It 'List title is valid' {
            $result.Title | Should Be "サイトのページ"
        }
	}
	Context 'Gets a list by title' {
        Add-SPClientType
        Connect-SPClientContext `
            -Url $testConfig.configuration.sharePointOnlineUrl `
            -Online `
            -UserName $testConfig.configuration.sharePointOnlineUserName `
            -Password (ConvertTo-SecureString -AsPlainText $testConfig.configuration.sharePointOnlinePassword -Force)
        $result = Get-SPClientList -Title "サイトのページ"
        It 'Return value is not null' {
            $result | Should Not Be $null
            $result.Count | Should Be 1
        }
        It 'List title is valid' {
            $result.Title | Should Be "サイトのページ"
        }
	}
}

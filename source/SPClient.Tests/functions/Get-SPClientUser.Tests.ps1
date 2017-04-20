#Requires -Version 3.0

$testProjectDir = [String](Resolve-Path -Path ($MyInvocation.MyCommand.Path + '\..\..\'))
$targetProjectDir = $testProjectDir.Replace('.Tests\', '\')

Get-ChildItem -Path $targetProjectDir -Recurse `
    | Where-Object { -not $_.FullName.Contains('.Tests.') } `
    | Where-Object Extension -eq '.ps1' `
    | ForEach-Object { . $_.FullName }

$testConfig = [Xml](Get-Content "${testProjectDir}\TestConfiguration.xml")

$Script:SPClient = @{}

Describe 'Get-SPClientUser' {
	Context 'Gets users without parameter' {
        Add-SPClientType
        Connect-SPClientContext `
            -Url $testConfig.configuration.sharePointOnlineUrl `
            -Online `
            -UserName $testConfig.configuration.sharePointOnlineUserName `
            -Password (ConvertTo-SecureString -AsPlainText $testConfig.configuration.sharePointOnlinePassword -Force)
        $result = Get-SPClientUser
        It 'Return value is not null' {
            $result | Should Not Be $null
            $result.Count | Should Not Be 0
        }
        $result | ForEach-Object { Write-Host $_.LoginName } 
	}
	Context 'Gets a user by login name' {
        Add-SPClientType
        Connect-SPClientContext `
            -Url $testConfig.configuration.sharePointOnlineUrl `
            -Online `
            -UserName $testConfig.configuration.sharePointOnlineUserName `
            -Password (ConvertTo-SecureString -AsPlainText $testConfig.configuration.sharePointOnlinePassword -Force)
        $result = Get-SPClientUser -Identity $testConfig.configuration.sharePointOnlineUserName
        It 'Return value is not null' {
            $result | Should Not Be $null
            $result.Count | Should Be 1
        }
        $result | ForEach-Object { Write-Host $_.LoginName } 
	}
	Context 'Fails when the specified user could not be found' {
        Add-SPClientType
        Connect-SPClientContext `
            -Url $testConfig.configuration.sharePointOnlineUrl `
            -Online `
            -UserName $testConfig.configuration.sharePointOnlineUserName `
            -Password (ConvertTo-SecureString -AsPlainText $testConfig.configuration.sharePointOnlinePassword -Force)
            $result = { Get-SPClientUser -Identity 'notfound@example.onmicrosoft.com' }
        It 'Error thrown' {
            $result | Should Throw
        }
    }
}

#Requires -Version 3.0

$testProjectDir = [String](Resolve-Path -Path ($MyInvocation.MyCommand.Path + '\..\..\'))
$targetProjectDir = $testProjectDir.Replace('.Tests\', '\')

Get-ChildItem -Path $targetProjectDir -Recurse `
    | Where-Object { -not $_.FullName.Contains('.Tests.') } `
    | Where-Object Extension -eq '.ps1' `
    | ForEach-Object { . $_.FullName }

$testConfig = [Xml](Get-Content "${testProjectDir}\TestConfiguration.xml")

$Script:SPClient = @{}

Describe 'Connect-SPClientContext' {
	Context 'Loads Network context' {
        Add-SPClientType
        $result = Connect-SPClientContext `
            -Url $testConfig.configuration.sharePointServerUrl `
            -Network `
            -UserName $testConfig.configuration.sharePointServerUserName `
            -Password (ConvertTo-SecureString -AsPlainText $testConfig.configuration.sharePointServerPassword -Force) `
            -Domain $testConfig.configuration.sharePointServerDomain
        It 'Return value is not null' {
            $result | Should Not Be $null
        }
        It 'Credential is valid' {
            $result.Credentials.GetType().Name | Should Be 'NetworkCredential' 
            $result.Credentials.UserName | Should Be $testConfig.configuration.sharePointServerUserName
            $result.Credentials.Domain | Should Be $testConfig.configuration.sharePointServerDomain
        }
	}
	Context 'Loads SharePoint Online context' {
        Add-SPClientType
        $result = Connect-SPClientContext `
            -Url $testConfig.configuration.sharePointOnlineUrl `
            -Online `
            -UserName $testConfig.configuration.sharePointOnlineUserName `
            -Password (ConvertTo-SecureString -AsPlainText $testConfig.configuration.sharePointOnlinePassword -Force)
        It 'Return value is not null' {
            $result | Should Not Be $null
        }
        It 'Credential is valid' {
            $result.Credentials.GetType().Name | Should Be 'SharePointOnlineCredentials' 
            $result.Credentials.UserName | Should Be $testConfig.configuration.sharePointOnlineUserName
        }
	}
}

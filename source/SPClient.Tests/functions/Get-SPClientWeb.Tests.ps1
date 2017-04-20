#Requires -Version 3.0

$testProjectDir = [String](Resolve-Path -Path ($MyInvocation.MyCommand.Path + '\..\..\'))
$targetProjectDir = $testProjectDir.Replace('.Tests\', '\')

Get-ChildItem -Path $targetProjectDir -Recurse `
    | Where-Object { -not $_.FullName.Contains('.Tests.') } `
    | Where-Object Extension -eq '.ps1' `
    | ForEach-Object { . $_.FullName }

$testConfig = [Xml](Get-Content "${testProjectDir}\TestConfiguration.xml")

$Script:SPClient = @{}

Describe 'Get-SPClientWeb' {
	Context 'Gets a web without parameter' {
        Add-SPClientType
        Connect-SPClientContext `
            -Url $testConfig.configuration.sharePointOnlineUrl `
            -Online `
            -UserName $testConfig.configuration.sharePointOnlineUserName `
            -Password (ConvertTo-SecureString -AsPlainText $testConfig.configuration.sharePointOnlinePassword -Force)
        $result = Get-SPClientWeb
        It 'Return value is not null' {
            $result | Should Not Be $null
        }
        It 'Web url is valid' {
            $result.ServerRelativeUrl | Should Be '/'
        }
        $result | ForEach-Object { Write-Host $_.Title } 
	}
	Context 'Gets a web by url' {
        Add-SPClientType
        Connect-SPClientContext `
            -Url $testConfig.configuration.sharePointOnlineUrl `
            -Online `
            -UserName $testConfig.configuration.sharePointOnlineUserName `
            -Password (ConvertTo-SecureString -AsPlainText $testConfig.configuration.sharePointOnlinePassword -Force)
        $result = Get-SPClientWeb -Url '/'
        It 'Return value is not null' {
            $result | Should Not Be $null
        }
        It 'Web url is valid' {
            $result.ServerRelativeUrl | Should Be '/'
        }
        $result | ForEach-Object { Write-Host $_.Title } 
	}
	Context 'Fails when the specified web could not be found' {
        Add-SPClientType
        Connect-SPClientContext `
            -Url $testConfig.configuration.sharePointOnlineUrl `
            -Online `
            -UserName $testConfig.configuration.sharePointOnlineUserName `
            -Password (ConvertTo-SecureString -AsPlainText $testConfig.configuration.sharePointOnlinePassword -Force)
            $result = { Get-SPClientWeb -Url '/NotFound' }
        It 'Error thrown' {
            $result | Should Throw
        }
    }
}

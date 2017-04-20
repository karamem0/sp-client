#Requires -Version 3.0

$testProjectDir = [String](Resolve-Path -Path ($MyInvocation.MyCommand.Path + '\..\..\'))
$targetProjectDir = $testProjectDir.Replace('.Tests\', '\')

Get-ChildItem -Path $targetProjectDir -Recurse `
    | Where-Object { -not $_.FullName.Contains('.Tests.') } `
    | Where-Object Extension -eq '.ps1' `
    | ForEach-Object { . $_.FullName }

$testConfig = [Xml](Get-Content "${testProjectDir}\TestConfiguration.xml")

$Script:SPClient = @{}

Describe 'Add-SPClientType' {
	Context 'Loads latest version' {
        $result = Add-SPClientType
        It 'Return value is null' {
            $result | Should Be $null
        }
        It 'Microsoft.SharePoint.Client.dll is loaded' {
            [System.AppDomain]::CurrentDomain.GetAssemblies() `
                | Where-Object { $_.GetName().Name -eq 'Microsoft.SharePoint.Client' } `
                | Should Not Be $null
        }
        It 'Microsoft.SharePoint.Client.Runtime.dll is loaded' {
            [System.AppDomain]::CurrentDomain.GetAssemblies() `
                | Where-Object { $_.GetName().Name -eq 'Microsoft.SharePoint.Client.Runtime' } `
                | Should Not Be $null
        }
	}
    Context 'Loads specified version' {
        $result = Add-SPClientType -Version '15'
        It 'Return value is null' {
            $result | Should Be $null
        }
        It 'Microsoft.SharePoint.Client.dll is loaded' {
            [System.AppDomain]::CurrentDomain.GetAssemblies() `
                | Where-Object { $_.GetName().Name -eq 'Microsoft.SharePoint.Client' } `
                | Should Not Be $null
        }
        It 'Microsoft.SharePoint.Client.Runtime.dll is loaded' {
            [System.AppDomain]::CurrentDomain.GetAssemblies() `
                | Where-Object { $_.GetName().Name -eq 'Microsoft.SharePoint.Client.Runtime' } `
                | Should Not Be $null
        }
	}
    Context 'Fails when SharePoint Client Components is not installed' {
        It 'Error thrown when root directory is not exists' {
            Mock Test-Path { return $false }
            { Add-SPClientType } | Should Throw
        }
        It 'Error thrown when version directory is not exists' {
            Mock Get-ChildItem { return $false }
            { Add-SPClientType } | Should Throw
        }
	}
}

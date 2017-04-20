#Requires -Version 3.0

. "${PSScriptRoot}\..\TestInitialize.ps1"

Describe 'Add-SPClientType' {

    It 'Loads assemblies of the latest version' {
        $result = Add-SPClientType
        $result | Should Be $null
        [System.AppDomain]::CurrentDomain.GetAssemblies() `
            | Where-Object { $_.GetName().Name -eq 'Microsoft.SharePoint.Client' } `
            | Should Not Be $null
        [System.AppDomain]::CurrentDomain.GetAssemblies() `
            | Where-Object { $_.GetName().Name -eq 'Microsoft.SharePoint.Client.Runtime' } `
            | Should Not Be $null
    }

    It 'Loads assemblies of the specified version' {
        $param = @{
            Version = '15'
        }
        $result = Add-SPClientType @param
        $result | Should Be $null
        [System.AppDomain]::CurrentDomain.GetAssemblies() `
            | Where-Object { $_.GetName().Name -eq 'Microsoft.SharePoint.Client' } `
            | Should Not Be $null
        [System.AppDomain]::CurrentDomain.GetAssemblies() `
            | Where-Object { $_.GetName().Name -eq 'Microsoft.SharePoint.Client.Runtime' } `
            | Should Not Be $null
    }

    It 'Throws an error when root directory is not exists' {
        Mock Test-Path { return $false }
        $throw = { Add-SPClientType }
        $throw | Should Throw 'SharePoint Client Component is not installed.'
    }

    It 'Throws an error when version directory is not exists' {
        Mock Get-ChildItem { return $false }
        $throw = { Add-SPClientType }
        $throw | Should Throw 'SharePoint Client Component is not installed.'
    }

}

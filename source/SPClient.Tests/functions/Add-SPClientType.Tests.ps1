#Requires -Version 3.0

. "${PSScriptRoot}\..\TestInitialize.ps1"

Describe 'Add-SPClientType' {

    It 'Loads assemblies of the latest version' {
        try {
            $result = Add-SPClientType
            $result | Should Be $null
            [System.AppDomain]::CurrentDomain.GetAssemblies() `
                | Where-Object { $_.GetName().Name -eq 'Microsoft.SharePoint.Client' } `
                | Should Not Be $null
            [System.AppDomain]::CurrentDomain.GetAssemblies() `
                | Where-Object { $_.GetName().Name -eq 'Microsoft.SharePoint.Client.Runtime' } `
                | Should Not Be $null
        } finally { }
    }

    It 'Loads assemblies of the specified version' {
        try {
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
        } finally { }
    }

    It 'Throws an error when root directory is not exists' {
        try {
            Mock Test-Path { return $false }
            $throw = { Add-SPClientType }
            $throw | Should Throw 'SharePoint Client Component is not installed.'
        } finally { }
    }

    It 'Throws an error when version directory is not exists' {
        try {
            Mock Get-ChildItem { return $false }
            $throw = { Add-SPClientType }
            $throw | Should Throw 'SharePoint Client Component is not installed.'
        } finally { }
    }

}

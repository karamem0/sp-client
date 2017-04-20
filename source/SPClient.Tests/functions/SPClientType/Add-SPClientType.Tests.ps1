#Requires -Version 3.0

. "${PSScriptRoot}\..\..\TestInitialize.ps1"

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

    It 'Loads assemblies from literal path' {
        try {
            $param = @{
                LiteralPath = 'C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\15\ISAPI'
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
            $throw = {
                $param = @{}
                $result = Add-SPClientType @param
            }
            $throw | Should Throw 'Cannot find SharePoint Client Component assemblies.'
        } finally { }
    }

    It 'Throws an error when version directory is not exists' {
        try {
            Mock Get-ChildItem { return $false }
            $throw = {
                $param = @{}
                $result = Add-SPClientType @param
            }
            $throw | Should Throw 'Cannot find SharePoint Client Component assemblies.'
        } finally { }
    }

    It 'Throws an error when literal path is not exists' {
        try {
            $throw = {
                $param = @{
                    LiteralPath = 'Z:\'
                }
                $result = Add-SPClientType @param
            }
            $throw | Should Throw 'Cannot find SharePoint Client Component assemblies.'
        } finally { }
    }

}

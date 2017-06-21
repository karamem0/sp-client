#Requires -Version 3.0

$Assemblies = @(
    [System.Reflection.Assembly]::LoadFrom("$($PSScriptRoot)\..\..\lib\Microsoft.SharePoint.Client.dll")
    [System.Reflection.Assembly]::LoadFrom("$($PSScriptRoot)\..\..\lib\Microsoft.SharePoint.Client.Runtime.dll")
)

$UserName = $Env:LoginUserName
$Password = ConvertTo-SecureString -String $Env:LoginPassword -AsPlainText -Force
$Credentials = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($UserName, $Password)
$ClientContext = New-Object Microsoft.SharePoint.Client.ClientContext($Env:LoginUrl)
$ClientContext.Credentials = $credentials
$ClientContext.DisableReturnValueCache = $true

$Script:SPClient = @{
    ClientContext = $ClientContext
    ModulePath = $PSScriptRoot.Replace('.Tests', '')
    LibPath = Convert-Path -Path "$($PSScriptRoot)\..\..\lib"
    TestConfig = Get-Content "$($PSScriptRoot)\TestConfiguration.json" | ConvertFrom-Json
}

Get-ChildItem -Path $SPClient.ModulePath -Recurse |
    Where-Object { -not $_.FullName.Contains('.Tests.') } |
    Where-Object { $_.Extension -eq '.ps1' } |
    ForEach-Object { . $_.FullName }

Get-ChildItem -Path $SPClient.ModulePath -Recurse |
    Where-Object { -not $_.FullName.Contains('.Tests.') } |
    Where-Object { $_.Extension -eq '.cs' } |
    ForEach-Object { Add-Type -Path $_.FullName -ReferencedAssemblies $Assemblies }

#Requires -Version 3.0

$PSScriptRoot.Replace('.Tests', '') |
    Get-ChildItem -Recurse |
    Where-Object { -not $_.FullName.Contains('.Tests.') } |
    Where-Object { $_.Extension -eq '.ps1' } |
    ForEach-Object { . $_.FullName }

Add-Type -Path "$($PSScriptRoot)\..\..\lib\Microsoft.SharePoint.Client.dll"
Add-Type -Path "$($PSScriptRoot)\..\..\lib\Microsoft.SharePoint.Client.Runtime.dll"

$UserName = $Env:LoginUserName
$Password = ConvertTo-SecureString -String $Env:LoginPassword -AsPlainText -Force
$Credentials = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($UserName, $Password)
$ClientContext = New-Object Microsoft.SharePoint.Client.ClientContext($Env:LoginUrl)
$ClientContext.Credentials = $credentials
$ClientContext.DisableReturnValueCache = $true

$Script:SPClient = @{ ClientContext = $ClientContext }
$Script:TestConfig = Get-Content "$($PSScriptRoot)\TestConfiguration.json" | ConvertFrom-Json

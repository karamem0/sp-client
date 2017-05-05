#Requires -Version 3.0

$PSScriptRoot.Replace('.Tests', '') `
    | Get-ChildItem -Recurse `
    | Where-Object { -not $_.FullName.Contains('.Tests.') } `
    | Where-Object Extension -eq '.ps1' `
    | ForEach-Object { . $_.FullName }

if ([System.Environment]::Is64BitProcess) {
    Add-Type -Path "$($Env:CommonProgramFiles)\Microsoft Shared\Web Server Extensions\16\ISAPI\Microsoft.SharePoint.Client.dll"
    Add-Type -Path "$($Env:CommonProgramFiles)\Microsoft Shared\Web Server Extensions\16\ISAPI\Microsoft.SharePoint.Client.Runtime.dll"
} else {
    Add-Type -Path "$($Env:CommonProgramW6432)\Microsoft Shared\Web Server Extensions\16\ISAPI\Microsoft.SharePoint.Client.dll"
    Add-Type -Path "$($Env:CommonProgramW6432)\Microsoft Shared\Web Server Extensions\16\ISAPI\Microsoft.SharePoint.Client.Runtime.dll"
}

$UserName = $Env:LoginUserName
$Password = ConvertTo-SecureString -String $Env:LoginPassword -AsPlainText -Force
$Credentials = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($UserName, $Password)
$ClientContext = New-Object Microsoft.SharePoint.Client.ClientContext($Env:LoginUrl)
$ClientContext.Credentials = $credentials

$Script:SPClient = @{ ClientContext = $ClientContext }
$Script:TestConfig = Get-Content "$($PSScriptRoot)\TestConfiguration.json" | ConvertFrom-Json

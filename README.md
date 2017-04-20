# SPClient

PowerShell module for SharePoint client-side object model (CSOM).

[![Build status](https://img.shields.io/appveyor/ci/karamem0/SPClient.svg?style=flat-square)](https://ci.appveyor.com/project/karamem0/SPClient)
[![License](https://img.shields.io/github/license/karamem0/SPClient.svg?style=flat-square)](https://github.com/karamem0/SPClient/blob/master/LICENSE)

## Prerequisites
Install [SharePoint Server 2016 Client Components SDK](https://www.microsoft.com/en-us/download/details.aspx?id=51679) or [SharePoint Server 2013 Client Components SDK](https://www.microsoft.com/en-us/download/details.aspx?id=35585) in order to use this module.

## Cmdlets
- Common
  - `Add-SPClientType`
  - `Connect-SPClientContext`
  - `Disconnect-SPClientContext`
- Contents
  - `Get-SPClientWeb`
  - `New-SPClientWeb`
  - `Remove-SPClientWeb`
  - `Get-SPClientList`
  - `New-SPClientList`
  - `Remove-SPClientList`
  - `Get-SPClientField`
  - `Get-SPClientView`
  - `Get-SPClientListItem`
  - `New-SPClientListItem`
  - `Remove-SPClientListItem`
- Users and Groups
  - `Get-SPClientGroup`
  - `Get-SPClientUser`
- Role Assignments
  - `Add-SPClientRoleAssignments`
  - `Clear-SPClientRoleAssignments`
  - `Disable-SPClientUniqueRoleAssignments`
  - `Enable-SPClientUniqueRoleAssignments`
  - `Remove-SPClientRoleAssignments`

## Getting started

If you write PowerShell script using the CSOM, it will be like below. 

```
# Load assemblies
Add-Type -Path 'C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\15\ISAPI\Microsoft.SharePoint.Client.dll'
Add-Type -Path 'C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\15\ISAPI\Microsoft.SharePoint.Client.Runtime.dll'

# Create credentials
$userName = 'administrator'
$password = 'password'
$domain = 'domain.local'
$password = ConvertTo-SecureString -String $password -AsPlainText -Force
$credentials = New-Object System.Net.NetworkCredential($userName, $password, $domain)

# Create context
$url = 'http://localhost'
$clientContext = New-Object Microsoft.SharePoint.Client.ClientContext($url)
$clientContext.Credentials = $credentials

# Get web title
$web = $clientContext.Web
$clientContext.Load($web)
$clientContext.ExecuteQuery()
Write-Host $web.Title

# Get all lists 'ServerRelativeUrl'
# You can not use Load method with retrievals!
$lists = $web.Lists
$clientContext.Load($lists)
$clientContext.ExecuteQuery()
$lists | %{ 
    $clientContext.Load($_.RootFolder)
    $clientContext.ExecuteQuery()
    Write-Host $_.RootFolder.ServerRelativeUrl
}
```

If using SPClient module, it will be like below. 

```
# Load assemblies
Add-SPClientType

# Connect to SharePoint
Connect-SPClientContext -Network `
    -Url 'http://localhost' `
    -UserName 'administrator' `
    -Password (ConvertTo-SecureString -String 'password' -AsPlainText -Force) `
    -Domain 'domain.local'

# Get web title
Get-SPClientWeb -Default `
    | %{ Write-Host $_.Title }

# Get all lists 'ServerRelativeUrl'
# You can use JSOM like retrieval expression
Get-SPClientList -Retrievals 'Include(RootFolder.ServerRelativeUrl)' `
    | %{ Write-Host $_.RootFolder.ServerRelativeUrl }
```

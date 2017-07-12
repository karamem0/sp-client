# SPClient

PowerShell module for SharePoint client-side object model (CSOM).

[![Build status](https://img.shields.io/appveyor/ci/karamem0/SPClient.svg?style=flat-square)](https://ci.appveyor.com/project/karamem0/SPClient)
[![License](https://img.shields.io/github/license/karamem0/SPClient.svg?style=flat-square)](https://github.com/karamem0/SPClient/blob/master/LICENSE)

## Features

- Automatically called `ClientContext.Load()` method. You do not have to consider call timing, you  will be released from "`ClientContext.Load()` Hell".
- String-based (in other words, JSOM-liked) data retrieval expression.

## Prerequisites

Install [SharePoint Server 2016 Client Components SDK](https://www.microsoft.com/en-us/download/details.aspx?id=51679) or [SharePoint Server 2013 Client Components SDK](https://www.microsoft.com/en-us/download/details.aspx?id=35585) in order to use this module.

## Installation
SPClient is published to [PowerShell Gallery](https://www.powershellgallery.com/packages/SPClient). To install SPClient to your computer run the cmdlet below.

```
PS> Install-Module -Name SPClient
```

## Functions

See [Command Reference](doc/Index.md).

## Getting Started

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
Use-SPClientType

# Connect to SharePoint
Connect-SPClientContext -Network `
    -Url 'http://localhost' `
    -UserName 'administrator' `
    -Password (ConvertTo-SecureString -String 'password' -AsPlainText -Force) `
    -Domain 'domain.local'

# Get web title
Get-SPClientWeb -Default |
    %{ Write-Host $_.Title }

# Get all lists 'ServerRelativeUrl'
Get-SPClientWeb -Default | Get-SPClientList -Retrieval 'Include(RootFolder.ServerRelativeUrl)' |
    %{ Write-Host $_.RootFolder.ServerRelativeUrl }
```

# SPClient

PowerShell module for SharePoint client-side object model (CSOM).

## Requirement
Install [SharePoint Server 2013 Client Components SDK](https://www.microsoft.com/en-us/download/details.aspx?id=35585) in order to use this module.

## Cmdlets
- Add-SPClientType
- Connect-SPClientContext
- Get-SPClientList
- Get-SPClientWeb

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
$password = ConvertTo-SecureString -AsPlainText $password -Force
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

# Get All lists ServerRelativeUrl
# You can't use Load method with retrievals!
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
    -Password (ConvertTo-SecureString -AsPlainText 'password' -Force) `
    -Domain 'domain.local' `
    | Out-Null

# Get web title
Get-SPClientWeb `
    | %{ Write-Host $_.Title }

# Get All lists ServerRelativeUrl
# You can use JSOM like retrieval expression
Get-SPClientList -Retrievals 'Include(RootFolder.ServerRelativeUrl)' `
    | %{ Write-Host $_.RootFolder.ServerRelativeUrl }
```

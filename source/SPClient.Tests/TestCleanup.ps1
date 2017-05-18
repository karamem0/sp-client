#Requires -Version 3.0

$CommonProgramFiles = $Env:CommonProgramFiles
if (-not [System.Environment]::Is64BitProcess -and
    -not [string]::IsNullOrEmpty($Env:CommonProgramW6432)) {
    $CommonProgramFiles = $Env:CommonProgramW6432
}
Add-Type -Path "$($CommonProgramFiles)\Microsoft Shared\Web Server Extensions\16\ISAPI\Microsoft.SharePoint.Client.dll"
Add-Type -Path "$($CommonProgramFiles)\Microsoft Shared\Web Server Extensions\16\ISAPI\Microsoft.SharePoint.Client.Runtime.dll"

$UserName = $Env:LoginUserName
$Password = ConvertTo-SecureString -String $Env:LoginPassword -AsPlainText -Force
$Credentials = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($UserName, $Password)
$ClientContext = New-Object Microsoft.SharePoint.Client.ClientContext($Env:LoginUrl)
$ClientContext.Credentials = $Credentials
$ClientContext.Load($ClientContext.Site)
$ClientContext.ExecuteQuery()

$WebUrls = @(
    '/TestWeb1/TestWeb3/TestWeb4'
    '/TestWeb1/TestWeb3'
    '/TestWeb1/TestWeb2'
    '/TestWeb1'
)
$WebUrls | ForEach-Object {
    try {
        $Web = $ClientContext.Site.OpenWeb($ClientContext.Site.ServerRelativeUrl + $_)
        $Web.DeleteObject()
        $ClientContext.ExecuteQuery()
    } catch {
        Write-Host $_
    }
}

try {
    $Groups = $ClientContext.Web.SiteGroups
    $ClientContext.Load($Groups)
    $ClientContext.ExecuteQuery()
    for ($Index = $Groups.Count - 1; $Index -ge 0; $Index--) { 
        $Groups.Remove($Groups[$Index])
        $ClientContext.ExecuteQuery()
    }
} catch {
    Write-Host $_
}

try {
    $Users = $ClientContext.Web.SiteUsers
    $ClientContext.Load($Users)
    $ClientContext.ExecuteQuery()
    for ($Index = $Users.Count - 1; $Index -ge 0; $Index--) { 
        $User = $Users[$Index]
        if (-not $User.IsSiteAdmin) {
            $Users.Remove($User)
            $ClientContext.ExecuteQuery()
        }
    }
} catch {
    Write-Host $_
}

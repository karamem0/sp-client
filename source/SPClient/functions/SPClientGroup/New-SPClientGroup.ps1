#Requires -Version 3.0

<#
  New-SPClientGroup.ps1

  Copyright (c) 2017 karamem0

  This software is released under the MIT License.
  https://github.com/karamem0/SPClient/blob/master/LICENSE
#>

function New-SPClientGroup {

<#
.SYNOPSIS
  Creates a new group.
.DESCRIPTION
  The New-SPClientGroup function adds a new group to the site.
.PARAMETER ClientContext
  Indicates the client context. If not specified, uses a default context.
.PARAMETER Name
  Indicates the group name.
.PARAMETER Description
  Indicates the description.
.PARAMETER Owner
  Indicates the owner.
.PARAMETER Users
  Indicates the collection of users to add to group.
.PARAMETER Retrieval
  Indicates the data retrieval expression.
.EXAMPLE
  New-SPClientGroup -Name "Custom Group"
.INPUTS
  None
.OUTPUTS
  Microsoft.SharePoint.Client.Group
.LINK
  https://github.com/karamem0/SPClient/blob/master/doc/New-SPClientGroup.md
#>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Mandatory = $true)]
        [Alias('Title')]
        [string]
        $Name,
        [Parameter(Mandatory = $false)]
        [string]
        $Description,
        [Parameter(Mandatory = $false)]
        [Microsoft.SharePoint.Client.Principal]
        $Owner,
        [Parameter(Mandatory = $false)]
        [Microsoft.SharePoint.Client.User[]]
        $Users,
        [Parameter(Mandatory = $false)]
        [string]
        $Retrieval
    )

    process {
        if ($ClientContext -eq $null) {
            throw "Cannot bind argument to parameter 'ClientContext' because it is null."
        }
        $Creation = New-Object Microsoft.SharePoint.Client.GroupCreationInformation
        $Creation.Title = $Name
        $Creation.Description = $Description
        $ClientObject = $ClientContext.Site.RootWeb.SiteGroups.Add($Creation)
        if ($PSBoundParameters.ContainsKey('Owner')) {
            $ClientObject.Owner = $Owner
        }
        if ($PSBoundParameters.ContainsKey('Users')) {
            foreach ($User in $Users) {
                $ClientObject.Users.AddUser($User) | Out-Null
            }
        }
        $ClientObject.Update()
        Invoke-ClientContextLoad `
            -ClientContext $ClientContext `
            -ClientObject $ClientObject `
            -Retrieval $Retrieval
        Write-Output $ClientObject
    }

}

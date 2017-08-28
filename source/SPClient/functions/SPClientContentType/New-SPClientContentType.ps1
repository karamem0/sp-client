#Requires -Version 3.0

<#
  New-SPClientContentType.ps1

  Copyright (c) 2017 karamem0

  This software is released under the MIT License.
  https://github.com/karamem0/SPClient/blob/master/LICENSE
#>

function New-SPClientContentType {

<#
.SYNOPSIS
  Creates a new content type.
.DESCRIPTION
  The New-SPClientContentType function adds a new content type to the site.
.PARAMETER ClientContext
  Indicates the client context. If not specified, uses a default context.
.PARAMETER ParentObject
  Indicates the site or list which a content type to be created.
.PARAMETER Name
  Indicates the internal name.
.PARAMETER Description
  Indicates the description.
.PARAMETER Group
  Indicates the group name.
.PARAMETER ParentContentType
  Indicates the parent content type.
.PARAMETER Retrieval
  Indicates the data retrieval expression.
.EXAMPLE
  New-SPClientContentType $web -Name "Custom Content Type"
.INPUTS
  None or SPClient.SPClientContentTypeParentPipeBind
.OUTPUTS
  Microsoft.SharePoint.Client.ContentType
.LINK
  https://github.com/karamem0/SPClient/blob/master/doc/New-SPClientContentType.md
#>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true)]
        [SPClient.SPClientContentTypeParentPipeBind]
        $ParentObject,
        [Parameter(Mandatory = $true)]
        [string]
        $Name,
        [Parameter(Mandatory = $false)]
        [string]
        $Description,
        [Parameter(Mandatory = $false)]
        [string]
        $Group,
        [Parameter(Mandatory = $false)]
        [Microsoft.SharePoint.Client.ContentType]
        $ParentContentType,
        [Parameter(Mandatory = $false)]
        [string]
        $Retrieval
    )

    process {
        if ($ClientContext -eq $null) {
            throw "Cannot bind argument to parameter 'ClientContext' because it is null."
        }
        $Creation = New-Object Microsoft.SharePoint.Client.ContentTypeCreationInformation
        $Creation.Name = $Name
        if ($PSBoundParameters.ContainsKey('Group')) {
            $Creation.Group = $Group
        }
        if ($PSBoundParameters.ContainsKey('ParentContentType')) {
            if (-not $ParentContentType.IsPropertyAvailable('Id')) {
                Invoke-ClientContextLoad `
                    -ClientContext $ClientContext `
                    -ClientObject $ParentContentType `
                    -Retrieval 'Id'
            }
            $Creation.ParentContentType = $ParentContentType
        }
        $ClientObject = $ParentObject.ClientObject.ContentTypes.Add($Creation)
        $ClientObject.Description = $Description
        $ClientObject.Update($false)
        Invoke-ClientContextLoad `
            -ClientContext $ClientContext `
            -ClientObject $ClientObject `
            -Retrieval $Retrieval
        Write-Output $ClientObject
    }

}

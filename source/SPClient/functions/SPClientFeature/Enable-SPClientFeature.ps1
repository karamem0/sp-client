#Requires -Version 3.0

<#
  Enable-SPClientFeature.ps1

  Copyright (c) 2017 karamem0

  This software is released under the MIT License.
  https://github.com/karamem0/SPClient/blob/master/LICENSE
#>

function Enable-SPClientFeature {

<#
.SYNOPSIS
  Enables a feature.
.DESCRIPTION
  The Enable-SPClientFeature function enables a site collection feature or a site feature.
.PARAMETER ClientContext
  Indicates the client context. If not specified, uses a default context.
.PARAMETER ParentObject
  Indicates the site collection or site to which the feature to be enabled.
.PARAMETER Identity
  Indicates the feature GUID.
.PARAMETER PassThru
  If specified, returns input object.
.PARAMETER Force
  If specified, forces the operation to continue even if there are errors.
.EXAMPLE
  Enable-SPClientFeature $web -Identity "99FE402E-89A0-45AA-9163-85342E865DC8"
.INPUTS
  None or SPClient.SPClientFeatureParentPipeBind
.OUTPUTS
  None or Microsoft.SharePoint.Client.Site or Microsoft.SharePoint.Client.Web
.LINK
  https://github.com/karamem0/SPClient/blob/master/doc/Enable-SPClientFeature.md
#>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Mandatory = $false, Position = 0, ValueFromPipeline = $true)]
        [SPClient.SPClientFeatureParentPipeBind]
        $ParentObject = $ClientContext.Site,
        [Parameter(Mandatory = $true)]
        [Alias('Id')]
        [string]
        $Identity,
        [Parameter(Mandatory = $false)]
        [switch]
        $PassThru,
        [Parameter(Mandatory = $false)]
        [switch]
        $Force
    )

    process {
        if ($ClientContext -eq $null) {
            throw "Cannot bind argument to parameter 'ClientContext' because it is null."
        }
        if ($ParentObject -eq $null) {
            throw "Cannot bind argument to parameter 'ParentObject' because it is null."
        }
        try {
            $ClientObject = $ParentObject.ClientObject
            $ClientObject.Features.Add($Identity, $Force, 0) | Out-Null
            Invoke-ClientContextLoad `
                -ClientContext $ClientContext `
                -ClientObject $ClientObject `
                -Retrieval 'Features'
            if ($PassThru) {
                Write-Output $ClientObject
            }
        } catch {
            throw 'The specified feature could not be found.'
        }
    }

}

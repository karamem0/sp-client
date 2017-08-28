#Requires -Version 3.0

<#
  Get-SPClientFeature.ps1

  Copyright (c) 2017 karamem0

  This software is released under the MIT License.
  https://github.com/karamem0/SPClient/blob/master/LICENSE
#>

function Get-SPClientFeature {

<#
.SYNOPSIS
  Gets one or more activated features.
.DESCRIPTION
  The Get-SPClientFeature function lists all features or retrieves the specified feature.
  If not specified filterable parameter, returns all features of the site collection or site.
  Otherwise, returns a feature which matches the parameter.
.PARAMETER ClientContext
  Indicates the client context. If not specified, uses a default context.
.PARAMETER ParentObject
  Indicates the site collection or site to which the features are contained.
.PARAMETER NoEnumerate
  If specified, suppresses enumeration in output.
.PARAMETER Identity
  Indicates the feature GUID.
.PARAMETER Retrieval
  Indicates the data retrieval expression.
.EXAMPLE
  Get-SPClientFeature
.INPUTS
  None or SPClient.SPClientFeatureParentPipeBind
.OUTPUTS
  Microsoft.SharePoint.Client.Feature[]
.LINK
  https://github.com/karamem0/SPClient/blob/master/doc/Get-SPClientFeature.md
#>

    [CmdletBinding(DefaultParameterSetName = 'All')]
    param (
        [Parameter(Mandatory = $false)]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Mandatory = $false, Position = 0, ValueFromPipeline = $true)]
        [SPClient.SPClientFeatureParentPipeBind]
        $ParentObject = $ClientContext.Site,
        [Parameter(Mandatory = $false, ParameterSetName = 'All')]
        [switch]
        $NoEnumerate,
        [Parameter(Mandatory = $false, ParameterSetName = 'Identity')]
        [Alias('Id')]
        [string]
        $Identity,
        [Parameter(Mandatory = $false)]
        [string]
        $Retrieval
    )

    process {
        if ($ClientContext -eq $null) {
            throw "Cannot bind argument to parameter 'ClientContext' because it is null."
        }
        if ($ParentObject -eq $null) {
            throw "Cannot bind argument to parameter 'ParentObject' because it is null."
        }
        $ClientObjectCollection = $ParentObject.ClientObject.Features
        if ($PSCmdlet.ParameterSetName -eq 'All') {
            Invoke-ClientContextLoad `
                -ClientContext $ClientContext `
                -ClientObject $ClientObjectCollection `
                -Retrieval $Retrieval
            Write-Output $ClientObjectCollection -NoEnumerate:$NoEnumerate
        }
        if ($PSCmdlet.ParameterSetName -eq 'Identity') {
            $PathMethod = New-Object Microsoft.SharePoint.Client.ObjectPathMethod( `
                $ClientContext, `
                $ClientObjectCollection.Path, `
                'GetById', `
                [object[]]$Identity)
            $ClientObject = New-Object Microsoft.SharePoint.Client.Feature($ClientContext, $PathMethod)
            Invoke-ClientContextLoad `
                -ClientContext $ClientContext `
                -ClientObject $ClientObject `
                -Retrieval $Retrieval
            if ($ClientObject.ServerObjectIsNull) {
                throw 'The specified feature could not be found.'
            }
            Write-Output $ClientObject
        }
    }

}

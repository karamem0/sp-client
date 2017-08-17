#Requires -Version 3.0

<#
  Get-SPClientContentType.ps1

  Copyright (c) 2017 karamem0

  This software is released under the MIT License.
  https://github.com/karamem0/SPClient/blob/master/LICENSE
#>

function Get-SPClientContentType {

<#
.SYNOPSIS
  Gets one or more content types.
.DESCRIPTION
  The Get-SPClientContentType function lists all content types or retrieves the specified content type.
  If not specified filterable parameter, returns all content types of the site or list.
  Otherwise, returns a content type which matches the parameter.
.PARAMETER ClientContext
  Indicates the client context. If not specified, uses a default context.
.PARAMETER ParentObject
  Indicates the site or list which the content types are contained.
.PARAMETER NoEnumerate
  If specified, suppresses enumeration in output.
.PARAMETER Identity
  Indicates the content type ID.
.PARAMETER Name
  Indicates the content type name.
.PARAMETER Retrieval
  Indicates the data retrieval expression.
.EXAMPLE
  Get-SPClientContentType $web
.EXAMPLE
  Get-SPClientContentType $web -Identity "0X01009BD26CA6BE114008A9D56E68022DD1A7"
.EXAMPLE
  Get-SPClientContentType $web -Name "Custom Content Type"
.EXAMPLE
  Get-SPClientContentType $web -Retrieval "Title"
.INPUTS
  None or SPClient.SPClientContentTypeParentPipeBind
.OUTPUTS
  Microsoft.SharePoint.Client.ContentType[]
.LINK
  https://github.com/karamem0/SPClient/blob/master/doc/Get-SPClientContentType.md
#>

    [CmdletBinding(DefaultParameterSetName = 'All')]
    param (
        [Parameter(Mandatory = $false)]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true)]
        [SPClient.SPClientContentTypeParentPipeBind]
        $ParentObject,
        [Parameter(Mandatory = $false, ParameterSetName = 'All')]
        [switch]
        $NoEnumerate,
        [Parameter(Mandatory = $true, ParameterSetName = 'Identity')]
        [Alias('Id')]
        [string]
        $Identity,
        [Parameter(Mandatory = $true, ParameterSetName = 'Name')]
        [string]
        $Name,
        [Parameter(Mandatory = $false)]
        [string]
        $Retrieval
    )

    process {
        if ($ClientContext -eq $null) {
            throw "Cannot bind argument to parameter 'ClientContext' because it is null."
        }
        $ClientObjectCollection = $ParentObject.ClientObject.ContentTypes
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
            $ClientObject = New-Object Microsoft.SharePoint.Client.ContentType($ClientContext, $PathMethod)
            Invoke-ClientContextLoad `
                -ClientContext $ClientContext `
                -ClientObject $ClientObject `
                -Retrieval $Retrieval
            if ($ClientObject.Id -eq $null) {
                throw 'The specified content type could not be found.'
            }
            Write-Output $ClientObject
        }
        if ($PSCmdlet.ParameterSetName -eq 'Name') {
            Invoke-ClientContextLoad `
                -ClientContext $ClientContext `
                -ClientObject $ClientObjectCollection `
                -Retrieval 'Include(Name)'
            $ClientObject = $ClientObjectCollection | Where-Object { $_.Name -eq $Name }
            if ($ClientObject -eq $null) {
                throw 'The specified content type could not be found.'
            }
            Invoke-ClientContextLoad `
                -ClientContext $ClientContext `
                -ClientObject $ClientObject `
                -Retrieval $Retrieval
            Write-Output $ClientObject
        }
    }

}

#Requires -Version 3.0

<#
  Remove-SPClientContentType.ps1

  Copyright (c) 2017 karamem0

  This software is released under the MIT License.
  https://github.com/karamem0/SPClient/blob/master/LICENSE
#>

function Remove-SPClientContentType {

<#
.SYNOPSIS
  Deletes the content type.
.DESCRIPTION
  The Remove-SPClientContentType function removes the content type from the site.
.PARAMETER ClientContext
  Indicates the client context. If not specified, uses default context.
.PARAMETER ClientObject
  Indicates the content type to delete.
.PARAMETER ParentObject
  Indicates the site or list which the content type is contained.
.PARAMETER Identity
  Indicates the content type ID.
.PARAMETER Name
  Indicates the content type name.
.EXAMPLE
  Remove-SPClientContentType $contentType
.EXAMPLE
  Remove-SPClientContentType $web -Identity "0X01009BD26CA6BE114008A9D56E68022DD1A7"
.EXAMPLE
  Remove-SPClientContentType $web -Name "Custom Content Type"
.INPUTS
  None or Microsoft.SharePoint.Client.ContentType or SPClient.SPClientContentTypeParentParameter
.OUTPUTS
  None
.LINK
  https://github.com/karamem0/SPClient/blob/master/doc/Remove-SPClientContentType.md
#>

    [CmdletBinding(DefaultParameterSetName = 'ClientObject')]
    param (
        [Parameter(Mandatory = $false)]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ParameterSetName = 'ClientObject')]
        [Microsoft.SharePoint.Client.ContentType]
        $ClientObject,
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ParameterSetName = 'Identity')]
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ParameterSetName = 'Name')]
        [SPClient.SPClientContentTypeParentParameter]
        $ParentObject,
        [Parameter(Mandatory = $true, ParameterSetName = 'Identity')]
        [Alias('Id')]
        [string]
        $Identity,
        [Parameter(Mandatory = $true, ParameterSetName = 'Name')]
        [string]
        $Name
    )

    process {
        if ($ClientContext -eq $null) {
            throw "Cannot bind argument to parameter 'ClientContext' because it is null."
        }
        if ($PSCmdlet.ParameterSetName -eq 'ClientObject') {
            if (-not $ClientObject.IsPropertyAvailable('Id')) {
                Invoke-ClientContextLoad `
                    -ClientContext $ClientContext `
                    -ClientObject $ClientObject `
                    -Retrieval 'Id'
            }
        } else {
            $ClientObjectCollection = $ParentObject.ClientObject.ContentTypes
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
                    -Retrieval 'Id'
                if ($ClientObject.Id -eq $null) {
                    throw 'The specified content type could not be found.'
                }
            }
            if ($PSCmdlet.ParameterSetName -eq 'Name') {
                Invoke-ClientContextLoad `
                    -ClientContext $ClientContext `
                    -ClientObject $ClientObjectCollection `
                    -Retrieval 'Include(Id,Name)'
                $ClientObject = $ClientObjectCollection | Where-Object { $_.Name -eq $Name }
                if ($ClientObject -eq $null) {
                    throw 'The specified content type could not be found.'
                }
            }
        }
        $ClientObject.DeleteObject()
        $ClientContext.ExecuteQuery()
    }

}

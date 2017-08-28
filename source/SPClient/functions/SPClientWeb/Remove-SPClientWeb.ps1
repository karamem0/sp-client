#Requires -Version 3.0

<#
  Remove-SPClientWeb.ps1

  Copyright (c) 2017 karamem0

  This software is released under the MIT License.
  https://github.com/karamem0/SPClient/blob/master/LICENSE
#>

function Remove-SPClientWeb {

<#
.SYNOPSIS
  Deletes the site.
.DESCRIPTION
  The Remove-SPClientWeb function removes the subsite from the site.
.PARAMETER ClientContext
  Indicates the client context. If not specified, uses a default context.
.PARAMETER ClientObject
  Indicates the site to delete.
.PARAMETER Identity
  Indicates the site GUID.
.PARAMETER Url
  Indicates the site URL.
.EXAMPLE
  Remove-SPClientWeb $web
.EXAMPLE
  Remove-SPClientWeb -Identity "B7FB9B8D-A815-496F-B16B-CC1B26CCAC33"
.EXAMPLE
  Remove-SPClientWeb -Url "/CustomWeb"
.INPUTS
  None or Microsoft.SharePoint.Client.Web
.OUTPUTS
  None
.LINK
  https://github.com/karamem0/SPClient/blob/master/doc/Remove-SPClientWeb.md
#>

    [CmdletBinding(DefaultParameterSetName = 'ClientObject')]
    param (
        [Parameter(Mandatory = $false)]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ParameterSetName = 'ClientObject')]
        [Microsoft.SharePoint.Client.Web]
        $ClientObject,
        [Parameter(Mandatory = $true, ParameterSetName = 'Identity')]
        [Alias('Id')]
        [guid]
        $Identity,
        [Parameter(Mandatory = $true, ParameterSetName = 'Url')]
        [string]
        $Url
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
            $ClientContext.ExecuteQuery()
        } else {
            if ($PSCmdlet.ParameterSetName -eq 'Identity') {
                $PathMethod = New-Object Microsoft.SharePoint.Client.ObjectPathMethod( `
                    $ClientContext, `
                    $ClientContext.Site.Path, `
                    'OpenWebById', `
                    [object[]]$Identity)
                $ClientObject = New-Object Microsoft.SharePoint.Client.Web($ClientContext, $PathMethod)
                Invoke-ClientContextLoad `
                    -ClientContext $ClientContext `
                    -ClientObject $ClientObject `
                    -Retrieval 'Id'
            }
            if ($PSCmdlet.ParameterSetName -eq 'Url') {
                $Url = ConvertTo-SPClientRelativeUrl -ClientContext $ClientContext -Url $Url
                $PathMethod = New-Object Microsoft.SharePoint.Client.ObjectPathMethod( `
                    $ClientContext, `
                    $ClientContext.Site.Path, `
                    'OpenWeb', `
                    [object[]]$Url)
                $ClientObject = New-Object Microsoft.SharePoint.Client.Web($ClientContext, $PathMethod)
                Invoke-ClientContextLoad `
                    -ClientContext $ClientContext `
                    -ClientObject $ClientObject `
                    -Retrieval 'Id'
            }
            trap {
                throw 'The specified site could not be found.'
            }
        }
        $ClientObject.DeleteObject()
        $ClientContext.ExecuteQuery()
    }

}

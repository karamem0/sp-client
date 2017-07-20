#Requires -Version 3.0

<#
  Get-SPClientWeb.ps1

  Copyright (c) 2017 karamem0

  This software is released under the MIT License.
  https://github.com/karamem0/SPClient/blob/master/LICENSE
#>

function Get-SPClientWeb {

<#
.SYNOPSIS
  Gets one or more sites.
.DESCRIPTION
  The Get-SPClientWeb function lists all sites or retrieve the specified site.
  If not specified filterable parameter, returns all subsites of the site.
  Otherwise, returns a site which matches the parameter.
.PARAMETER ClientContext
  Indicates the client context. If not specified, uses default context.
.PARAMETER ParentObject
  Indicates the site which the subsites are contained.
.PARAMETER NoEnumerate
  If specified, suppresses enumeration in output.
.PARAMETER Identity
  Indicates the site GUID.
.PARAMETER Url
  Indicates the site URL.
.PARAMETER Default
  If specified, returns the default site of the client context.
.PARAMETER Root
  If specified, returns the root site.
.PARAMETER RecursiveAll
  If specified, returns the default site and its descendants.
.PARAMETER Retrieval
  Indicates the data retrieval expression.
.EXAMPLE
  Get-SPClientWeb
.EXAMPLE
  Get-SPClientWeb -Identity "B7FB9B8D-A815-496F-B16B-CC1B26CCAC33"
.EXAMPLE
  Get-SPClientWeb -Url "/CustomWeb"
.EXAMPLE
  Get-SPClientWeb -Default
.EXAMPLE
  Get-SPClientWeb -Root
.EXAMPLE
  Get-SPClientWeb -Retrieval "Title"
.INPUTS
  None or SPClient.SPClientWebParentPipeBind
.OUTPUTS
  Microsoft.SharePoint.Client.Web[]
.LINK
  https://github.com/karamem0/SPClient/blob/master/doc/Get-SPClientWeb.md
#>

    [CmdletBinding(DefaultParameterSetName = 'All')]
    param (
        [Parameter(Mandatory = $false)]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ParameterSetName = 'All')]
        [SPClient.SPClientWebParentPipeBind]
        $ParentObject,
        [Parameter(Mandatory = $false, ParameterSetName = 'All')]
        [switch]
        $NoEnumerate,
        [Parameter(Mandatory = $true, ParameterSetName = 'Identity')]
        [Alias('Id')]
        [guid]
        $Identity,
        [Parameter(Mandatory = $true, ParameterSetName = 'Url')]
        [string]
        $Url,
        [Parameter(Mandatory = $true, ParameterSetName = 'Default')]
        [switch]
        $Default,
        [Parameter(Mandatory = $true, ParameterSetName = 'Root')]
        [switch]
        $Root,
        [Parameter(Mandatory = $true, ParameterSetName = 'RecursiveAll')]
        [switch]
        $RecursiveAll,
        [Parameter(Mandatory = $false)]
        [string]
        $Retrieval
    )

    process {
        if ($ClientContext -eq $null) {
            throw "Cannot bind argument to parameter 'ClientContext' because it is null."
        }
        if ($PSCmdlet.ParameterSetName -eq 'All') {
            $ClientObjectCollection = $ParentObject.ClientObject.Webs
            Invoke-ClientContextLoad `
                -ClientContext $ClientContext `
                -ClientObject $ClientObjectCollection `
                -Retrieval $Retrieval
            Write-Output $ClientObjectCollection -NoEnumerate:$NoEnumerate
        }
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
                -Retrieval $Retrieval
            Write-Output $ClientObject
            trap {
                throw 'The specified site could not be found.'
            }
        }
        if ($PSCmdlet.ParameterSetName -eq 'Url') {
            $PathMethod = New-Object Microsoft.SharePoint.Client.ObjectPathMethod( `
                $ClientContext, `
                $ClientContext.Site.Path, `
                'OpenWeb', `
                [object[]]$Url)
            $ClientObject = New-Object Microsoft.SharePoint.Client.Web($ClientContext, $PathMethod)
            Invoke-ClientContextLoad `
                -ClientContext $ClientContext `
                -ClientObject $ClientObject `
                -Retrieval $Retrieval
            Write-Output $ClientObject
            trap {
                throw 'The specified site could not be found.'
            }
        }
        if ($PSCmdlet.ParameterSetName -eq 'Default') {
            $ClientObject = $ClientContext.Web
            Invoke-ClientContextLoad `
                -ClientContext $ClientContext `
                -ClientObject $ClientObject `
                -Retrieval $Retrieval
            Write-Output $ClientObject
        }
        if ($PSCmdlet.ParameterSetName -eq 'Root') {
            $ClientObject = $ClientContext.Site.RootWeb
            Invoke-ClientContextLoad `
                -ClientContext $ClientContext `
                -ClientObject $ClientObject `
                -Retrieval $Retrieval
            Write-Output $ClientObject
        }
        if ($PSCmdlet.ParameterSetName -eq 'RecursiveAll') {
            $ClientObjectCollection = @()
            $ClientObject = $ClientContext.Web
            Invoke-ClientContextLoad `
                -ClientContext $ClientContext `
                -ClientObject $ClientObject `
                -Retrieval $Retrieval
            $ClientObjectCollection += $ClientObject
            $Stack = New-Object System.Collections.Stack
            do {
                Invoke-ClientContextLoad `
                    -ClientContext $ClientContext `
                    -ClientObject $ClientObject.Webs `
                    -Retrieval $Retrieval
                while ($ClientObject.Webs.Count -gt 0) {
                    $Item = @{
                        Collection = $ClientObject.Webs
                        Index = 0
                    }
                    $Stack.Push($Item)
                    $ClientObject = $Item.Collection[$Item.Index]
                    $ClientObjectCollection += $ClientObject
                    Invoke-ClientContextLoad `
                        -ClientContext $ClientContext `
                        -ClientObject $ClientObject.Webs `
                        -Retrieval $Retrieval
                }
                while ($Stack.Count -gt 0) {
                    $Item = $Stack.Pop()
                    $Item.Index += 1
                    if ($Item.Index -lt $Item.Collection.Count) {
                        $Stack.Push($Item)
                        $ClientObject = $Item.Collection[$Item.Index]
                        $ClientObjectCollection += $ClientObject
                        break
                    }
                }
            } while ($Stack.Count -gt 0)
            Write-Output $ClientObjectCollection -NoEnumerate:$NoEnumerate
        }
    }

}

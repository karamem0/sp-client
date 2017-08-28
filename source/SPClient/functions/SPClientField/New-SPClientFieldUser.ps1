#Requires -Version 3.0

<#
  New-SPClientFieldUser.ps1

  Copyright (c) 2017 karamem0

  This software is released under the MIT License.
  https://github.com/karamem0/SPClient/blob/master/LICENSE
#>

function New-SPClientFieldUser {

<#
.SYNOPSIS
  Creates a new user column.
.DESCRIPTION
  The New-SPClientFieldUser function adds a new column to the site or list.
  The column allows the user to one or more user lookup values.
.PARAMETER ClientContext
  Indicates the client context. If not specified, uses a default context.
.PARAMETER ParentObject
  Indicates the site or list which a column to be created.
.PARAMETER Name
  Indicates the internal name.
.PARAMETER Title
  Indicates the title.
.PARAMETER Identity
  Indicates the column GUID.
.PARAMETER Description
  Indicates the description.
.PARAMETER Required
  Indicates a value whether the column is required.
.PARAMETER EnforceUniqueValues
  Indicates a value whether the column must to have unique value.
.PARAMETER AllowMultipleValues
  Indicates a value whether the column allows multiple values.
.PARAMETER SelectionMode
  Indicates user selection mode.
    - PeopleOnly: users and groups
    - PeopleAndGroups: users only
.PARAMETER SelectionGroup
  Indicates the identifier of the SharePoint group whose members can be selected.
.PARAMETER LookupField
  Indicates the column internal name of the user lookup value.
.PARAMETER AddToDefaultView
  If true, the column is add to default view.
.PARAMETER Retrieval
  Indicates the data retrieval expression.
.EXAMPLE
  New-SPClientFieldUser $list -Name "CustomField" -Title "Custom Field"
.INPUTS
  None or SPClient.SPClientFieldParentPipeBind
.OUTPUTS
  Microsoft.SharePoint.Client.FieldUser
.LINK
  https://github.com/karamem0/SPClient/blob/master/doc/New-SPClientFieldUser.md
#>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Mandatory = $false, Position = 0, ValueFromPipeline = $true)]
        [SPClient.SPClientFieldParentPipeBind]
        $ParentObject,
        [Parameter(Mandatory = $true)]
        [string]
        $Name,
        [Parameter(Mandatory = $false)]
        [string]
        $Title = $Name,
        [Parameter(Mandatory = $false)]
        [guid]
        $Identity,
        [Parameter(Mandatory = $false)]
        [string]
        $Description,
        [Parameter(Mandatory = $false)]
        [bool]
        $Required,
        [Parameter(Mandatory = $false)]
        [bool]
        $EnforceUniqueValues,
        [Parameter(Mandatory = $false)]
        [bool]
        $AllowMultipleValues,
        [Parameter(Mandatory = $false)]
        [ValidateSet('PeopleOnly', 'PeopleAndGroups')]
        [string]
        $SelectionMode,
        [Parameter(Mandatory = $false)]
        [int]
        $SelectionGroup,
        [Parameter(Mandatory = $false)]
        [string]
        $LookupField,
        [Parameter(Mandatory = $false)]
        [bool]
        $AddToDefaultView,
        [Parameter(Mandatory = $false)]
        [string]
        $Retrieval
    )

    process {
        if ($ClientContext -eq $null) {
            throw "Cannot bind argument to parameter 'ClientContext' because it is null."
        }
        $XmlDocument = New-Object System.Xml.XmlDocument
        $FieldElement = $XmlDocument.AppendChild($XmlDocument.CreateElement('Field'))
        $FieldElement.SetAttribute('Type', 'User')
        $FieldElement.SetAttribute('Name', $Name)
        $FieldElement.SetAttribute('DisplayName', $Title)
        if ($PSBoundParameters.ContainsKey('Identity')) {
            $FieldElement.SetAttribute('ID', $Identity)
        }
        if ($PSBoundParameters.ContainsKey('Description')) {
            $FieldElement.SetAttribute('Description', $Description)
        }
        if ($PSBoundParameters.ContainsKey('Required')) {
            $FieldElement.SetAttribute('Required', $Required.ToString().ToUpper())
        }
        if ($PSBoundParameters.ContainsKey('EnforceUniqueValues')) {
            $FieldElement.SetAttribute('EnforceUniqueValues', $EnforceUniqueValues.ToString().ToUpper())
            $FieldElement.SetAttribute('Indexed', $EnforceUniqueValues.ToString().ToUpper())
        }
        if ($PSBoundParameters.ContainsKey('AllowMultipleValues')) {
            if ($AllowMultipleValues -eq $true) {
                if ($EnforceUniqueValues -eq $true) {
                    throw "Cannot be EnforceUniqueValues to true when AllowMultipleValues is true."
                }
                $FieldElement.SetAttribute('Type', 'UserMulti')
                $FieldElement.SetAttribute('Mult', $AllowMultipleValues.ToString().ToUpper())
            }
        }
        if ($PSBoundParameters.ContainsKey('SelectionMode')) {
            $FieldElement.SetAttribute('UserSelectionMode', $SelectionMode)
        }
        if ($PSBoundParameters.ContainsKey('SelectionGroup')) {
            $FieldElement.SetAttribute('UserSelectionScope', $SelectionGroup)
        }
        if ($PSBoundParameters.ContainsKey('LookupField')) {
            $FieldElement.SetAttribute('ShowField', $LookupField)
        }
        $AddFieldOptions = [Microsoft.SharePoint.Client.AddFieldOptions]::AddFieldInternalNameHint
        $ClientObject = $ParentObject.ClientObject.Fields.AddFieldAsXml($XmlDocument.InnerXml, $AddToDefaultView, $AddFieldOptions)
        $ClientObject = Convert-SPClientField `
            -ClientContext $ClientContext `
            -Field $ClientObject
        Invoke-ClientContextLoad `
            -ClientContext $ClientContext `
            -ClientObject $ClientObject `
            -Retrieval $Retrieval
        Write-Output $ClientObject
    }

}

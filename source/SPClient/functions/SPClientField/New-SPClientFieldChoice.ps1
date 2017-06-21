#Requires -Version 3.0

<#
  New-SPClientFieldChoice.ps1

  Copyright (c) 2017 karamem0

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in all
  copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  SOFTWARE.
#>

function New-SPClientFieldChoice {

<#
.SYNOPSIS
  Creates a new choice field.
.DESCRIPTION
  The New-SPClientFieldChoice function adds a new field to the web or list. The
  field allows the user to select one or mode values.
.PARAMETER ClientContext
  Indicates the client context. If not specified, uses default context.
.PARAMETER ParentObject
  Indicates the web or list which a field to be created.
.PARAMETER Name
  Indicates the internal name.
.PARAMETER Title
  Indicates the title.
.PARAMETER Identity
  Indicates the field GUID.
.PARAMETER Description
  Indicates the description.
.PARAMETER Required
  Indicates a value whether the field is required.
.PARAMETER EnforceUniqueValues
  Indicates a value whether the field must to have unique value.
.PARAMETER Choices
  Indicates values that are available for selection in the field. 
.PARAMETER EditFormat
  Indicates the display format.
    - Dropdown
    - RadioButtons
    - Checkboxes
.PARAMETER FillInChoice
  Indicates a value whether the field can accept values other than those specified in Choices.
.PARAMETER DefaultValue
  Indicates the default value.
.PARAMETER AddToDefaultView
  If true, the field is add to default view.
.PARAMETER Retrievals
  Indicates the data retrieval expression.
.EXAMPLE
  New-SPClientFieldChoice $list -Name "CustomField" -Title "Custom Field"
.INPUTS
  None or SPClient.SPClientFieldParentParameter
.OUTPUTS
  Microsoft.SharePoint.Client.FieldChoice
.LINK
  https://github.com/karamem0/SPClient/blob/master/doc/New-SPClientFieldChoice.md
#>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Mandatory = $false, Position = 0, ValueFromPipeline = $true)]
        [SPClient.SPClientFieldParentParameter]
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
        [string[]]
        $Choices,
        [Parameter(Mandatory = $false)]
        [ValidateSet('Dropdown', 'RadioButtons', 'Checkboxes')]
        [string]
        $EditFormat,
        [Parameter(Mandatory = $false)]
        [bool]
        $FillInChoice,
        [Parameter(Mandatory = $false)]
        [string]
        $DefaultValue,
        [Parameter(Mandatory = $false)]
        [bool]
        $AddToDefaultView,
        [Parameter(Mandatory = $false)]
        [string]
        $Retrievals
    )

    process {
        if ($ClientContext -eq $null) {
            throw "Cannot bind argument to parameter 'ClientContext' because it is null."
        }
        $XmlDocument = New-Object System.Xml.XmlDocument
        $FieldElement = $XmlDocument.AppendChild($XmlDocument.CreateElement('Field'))
        $FieldElement.SetAttribute('Type', 'Choice')
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
        if ($PSBoundParameters.ContainsKey('Choices')) {
            $ChoicesElement = $FieldElement.AppendChild($XmlDocument.CreateElement('CHOICES'))
            foreach ($Choice in $Choices) {
                $ChoiceElement = $ChoicesElement.AppendChild($XmlDocument.CreateElement('CHOICE'))
                $ChoiceElement.InnerText = $Choice
            }
        }
        if ($PSBoundParameters.ContainsKey('EditFormat')) {
            if ($EditFormat -eq 'Checkboxes') {
                if ($EnforceUniqueValues -eq $true) {
                    throw "Cannot be EnforceUniqueValues to true when EditFormat is 'Checkboxes'."
                }
                $FieldElement.SetAttribute('Type', 'MultiChoice')
            }
            $FieldElement.SetAttribute('Format', $EditFormat)
        }
        if ($PSBoundParameters.ContainsKey('FillInChoice')) {
            $FieldElement.SetAttribute('FillInChoice', $FillInChoice.ToString().ToUpper())
        }
        if ($PSBoundParameters.ContainsKey('DefaultValue')) {
            $DefaultElement = $FieldElement.AppendChild($XmlDocument.CreateElement('Default'))
            $DefaultElement.InnerText = $DefaultValue
        }
        $AddFieldOptions = [Microsoft.SharePoint.Client.AddFieldOptions]::AddFieldInternalNameHint
        $ClientObject = $ParentObject.ClientObject.Fields.AddFieldAsXml($XmlDocument.InnerXml, $AddToDefaultView, $AddFieldOptions)
        $ClientObject = Convert-SPClientField `
            -ClientContext $ClientContext `
            -Field $ClientObject
        Invoke-SPClientLoadQuery `
            -ClientContext $ClientContext `
            -ClientObject $ClientObject `
            -Retrievals $Retrievals
        Write-Output $ClientObject
    }

}

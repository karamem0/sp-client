#Requires -Version 3.0

# New-SPClientFieldCalculated.ps1
#
# Copyright (c) 2017 karamem0
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

function New-SPClientFieldCalculated {

<#
.SYNOPSIS
  Creates a new calclated field.
.DESCRIPTION
  The New-SPClientFieldCalculated function adds a new field to the list. The
  value of the field is calculated based on other columns.
.PARAMETER ClientContext
  Indicates the client context. If not specified, uses default context.
.PARAMETER ParentList
  Indicates the list which a field to be created.
.PARAMETER Name
  Indicates the internal name.
.PARAMETER Title
  Indicates the title.
.PARAMETER Identity
  Indicates the field GUID.
.PARAMETER Description
  Indicates the description.
.PARAMETER Fomula
  Indicates the formula.
.PARAMETER FieldRefs
  Indicates the collection of fields which used in formula.
.PARAMETER OutputType
  Indicates the data type of the return value.
    - Text
    - Number
    - Currency
    - DateTime
    - Boolean
.PARAMETER Decimals
  Indicates the number of decimals. This parameter is used when OutputType is
  'Number' or 'Currency'.
.PARAMETER Percentage
  Indicates a value whether the field shows as percentage. This parameter is
  used when OutputType is 'Number'.
.PARAMETER LocaleId 
  Indicates the language code identifier (LCID). This parameter is used when
  OutputType is 'Currency'.
.PARAMETER DateFormat
  Indicates the datetime display format. This parameter is used when OutputType
  is 'DateTime'.
.PARAMETER AddToDefaultView
  If true, the field is add to default view.
.PARAMETER Retrievals
  Indicates the data retrieval expression.
.EXAMPLE
  New-SPClientFieldCalculated $list -Name "CustomField" -Title "Custom Field" -Formula "=[Title]" -FieldRefs "Title" -OutputType "Text"
#>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Mandatory = $false, Position = 0, ValueFromPipeline = $true)]
        [Microsoft.SharePoint.Client.List]
        $ParentList,
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
        [Parameter(Mandatory = $true)]
        [string]
        $Formula,
        [Parameter(Mandatory = $true)]
        [string[]]
        $FieldRefs,
        [Parameter(Mandatory = $true)]
        [ValidateSet('Text', 'Number', 'Currency', 'DateTime', 'Boolean')]
        [string]
        $OutputType,
        [Parameter(Mandatory = $false)]
        [int]
        $Decimals,
        [Parameter(Mandatory = $false)]
        [bool]
        $Percentage,
        [Parameter(Mandatory = $false)]
        [int]
        $LocaleId,
        [Parameter(Mandatory = $false)]
        [ValidateSet('DateOnly', 'DateTime')]
        [string]
        $DateFormat,
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
        $FieldElement.SetAttribute('Type', 'Calculated')
        $FieldElement.SetAttribute('ReadOnly', 'TRUE')
        $FieldElement.SetAttribute('Name', $Name)
        $FieldElement.SetAttribute('DisplayName', $Title)
        if ($PSBoundParameters.ContainsKey('Identity')) {
            $FieldElement.SetAttribute('ID', $Identity)
        }
        if ($PSBoundParameters.ContainsKey('Description')) {
            $FieldElement.SetAttribute('Description', $Description)
        }
        if ($PSBoundParameters.ContainsKey('Formula')) {
            $FormulaElement = $FieldElement.AppendChild($XmlDocument.CreateElement('Formula'))
            $FormulaElement.InnerText = $Formula
        }
        if ($PSBoundParameters.ContainsKey('FieldRefs')) {
            $FieldRefsElement = $FieldElement.AppendChild($XmlDocument.CreateElement('FieldRefs'))
            foreach ($FieldRef in $FieldRefs) {
                $FieldRefElement = $FieldRefsElement.AppendChild($XmlDocument.CreateElement('FieldRef'))
                $FieldRefElement.SetAttribute('Name', $FieldRef)
            }
        }
        if ($PSBoundParameters.ContainsKey('OutputType')) {
            $FieldElement.SetAttribute('ResultType', $OutputType)
        }
        if ($PSBoundParameters.ContainsKey('Decimals')) {
            $FieldElement.SetAttribute('Decimals', $Decimals)
        }
        if ($PSBoundParameters.ContainsKey('Percentage')) {
            $FieldElement.SetAttribute('Percentage', $Percentage.ToString().ToUpper())
        }
        if ($PSBoundParameters.ContainsKey('LocaleId')) {
            $FieldElement.SetAttribute('LCID', $LocaleId)
        }
        if ($PSBoundParameters.ContainsKey('DateFormat')) {
            $FieldElement.SetAttribute('Format', $DateFormat)
        }
        $AddFieldOptions = [Microsoft.SharePoint.Client.AddFieldOptions]::AddFieldInternalNameHint
        $ClientObject = $ParentList.Fields.AddFieldAsXml($XmlDocument.InnerXml, $AddToDefaultView, $AddFieldOptions)
        Invoke-SPClientLoadQuery `
            -ClientContext $ClientContext `
            -ClientObject $ClientObject `
            -Retrievals $Retrievals
        $ClientObject = Convert-SPClientField `
            -ClientContext $ClientContext `
            -Field $ClientObject
        Write-Output $ClientObject
    }

}

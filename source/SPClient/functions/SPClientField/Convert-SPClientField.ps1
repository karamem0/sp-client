#Requires -Version 3.0

<#
  Convert-SPClientField.ps1

  Copyright (c) 2017 karamem0

  This software is released under the MIT License.
  https://github.com/karamem0/SPClient/blob/master/LICENSE
#>

function Convert-SPClientField {

<#
.SYNOPSIS
  Converts the column to its derived type.
.DESCRIPTION
  The Convert-SPClientField function converts the column to its derived type.
.PARAMETER ClientContext
  Indicates the client context. If not specified, uses a default context.
.PARAMETER Field
  Indicates the column.
.EXAMPLE
  Convert-SPClientField $field
.INPUTS
  None or Microsoft.SharePoint.Client.Field
.OUTPUTS
  Derived type of Microsoft.SharePoint.Client.Field
.LINK
  https://github.com/karamem0/SPClient/blob/master/doc/Convert-SPClientField.md
#>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [Microsoft.SharePoint.Client.ClientContext]
        $ClientContext = $SPClient.ClientContext,
        [Parameter(Mandatory = $false, Position = 0, ValueFromPipeline = $true)]
        [Microsoft.SharePoint.Client.Field]
        $Field
    )

    process {
        if ($ClientContext -eq $null) {
            throw "Cannot bind argument to parameter 'ClientContext' because it is null."
        }
        $Table = @{
            Text = 'Microsoft.SharePoint.Client.FieldText'
            Note = 'Microsoft.SharePoint.Client.FieldMultilineText'
            Choice = 'Microsoft.SharePoint.Client.FieldChoice'
            MultiChoice = 'Microsoft.SharePoint.Client.FieldMultiChoice'
            Number = 'Microsoft.SharePoint.Client.FieldNumber'
            Currency = 'Microsoft.SharePoint.Client.FieldCurrency'
            DateTime = 'Microsoft.SharePoint.Client.FieldDateTime'
            Lookup = 'Microsoft.SharePoint.Client.FieldLookup'
            LookupMulti = 'Microsoft.SharePoint.Client.FieldLookup'
            Boolean = 'Microsoft.SharePoint.Client.FieldNumber'
            User = 'Microsoft.SharePoint.Client.FieldUser'
            UserMulti = 'Microsoft.SharePoint.Client.FieldUser'
            Url = 'Microsoft.SharePoint.Client.FieldUrl'
            Calculated = 'Microsoft.SharePoint.Client.FieldCalculated'
        }
        if (-not $Field.IsPropertyAvailable('TypeAsString')) {
            Invoke-ClientContextLoad `
                -ClientContext $ClientContext `
                -ClientObject $Field `
                -Retrieval 'TypeAsString'
        }
        $Method = $ClientContext.GetType().GetMethod('CastTo')
        $Method = $Method.MakeGenericMethod([type[]]$Table[$Field.TypeAsString])
        Write-Output $Method.Invoke($ClientContext, @($Field))
    }

}

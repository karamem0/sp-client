#Requires -Version 3.0

<#
  Debug-SPClientObject.ps1

  Copyright (c) 2017 karamem0

  This software is released under the MIT License.
  https://github.com/karamem0/SPClient/blob/master/LICENSE
#>

function Debug-SPClientObject {

<#
.SYNOPSIS
  Dumps a client object.
.DESCRIPTION
  The Debug-SPClientObject function converts a client object to hashtable that contains loaded properties.
.PARAMETER InputObject
  Indicates the client object.
.EXAMPLE
  Debug-SPClientObject $object
.INPUTS
  None or Microsoft.SharePoint.Client.ClientObject
.OUTPUTS
  System.Collections.Generic.Dictionary`2[System.String,System.Object]
.LINK
  https://github.com/karamem0/SPClient/blob/master/doc/Debug-SPClientObject.md
#>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true)]
        [Microsoft.SharePoint.Client.ClientObject]
        $InputObject
    )

    process {
        if ($InputObject -is [System.Collections.IEnumerable]) {
            $List = New-Object 'System.Collections.Generic.List`1[object]'
            $InputObjectCollection = $InputObject.GetEnumerator()
            foreach ($InputObject in $InputObjectCollection) {
                $Value = Debug-SPClientObject -InputObject $InputObject
                $List.Add($Value)
            }
            Write-Output $List
        } else {
            $Dict = New-Object 'System.Collections.Generic.Dictionary`2[string,object]'
            foreach ($Property in $InputObject.GetType().GetProperties()) {
                $Type = $Property.PropertyType
                $Name = $Property.Name
                if ($Type.IsSubclassOf([Microsoft.SharePoint.Client.ClientObject])) {
                    if ($InputObject.IsObjectPropertyInstantiated($Name)) {
                        $Value = $Property.GetValue($InputObject)
                        $Value = Debug-SPClientObject -InputObject $Value
                        $Dict.Add($Name, $Value)
                    }
                } else {
                    if ($InputObject.IsPropertyAvailable($Name)) {
                        $Value = $Property.GetValue($InputObject)
                        $Dict.Add($Name, $Value)
                    }
                }
            }
            if ($InputObject -is [Microsoft.SharePoint.Client.ListItem]) {
                $Dict.Add('FieldValues', $InputObject.FieldValues)
            }
            Write-Output $Dict
        }
    }

}

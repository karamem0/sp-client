# Get-SPClientField

## SYNOPSIS
Gets one or more fields.

## SYNTAX

### All (Default)
```
Get-SPClientField [-ClientContext <ClientContext>] [-ParentObject] <SPClientFieldParentParameter>
 [-Retrievals <String>]
```

### Name
```
Get-SPClientField [-ClientContext <ClientContext>] [-ParentObject] <SPClientFieldParentParameter>
 -Name <String> [-Retrievals <String>]
```

### Identity
```
Get-SPClientField [-ClientContext <ClientContext>] [-ParentObject] <SPClientFieldParentParameter>
 -Identity <Guid> [-Retrievals <String>]
```

## DESCRIPTION
The Get-SPClientField function lists all fields or retrieves the specified
field.
If not specified filterable parameter, returns all fields of the web or
list.
Otherwise, returns a field which matches the parameter.

## EXAMPLES

### -------------------------- Example 1 --------------------------
```
Get-SPClientField $list
```

### -------------------------- Example 2 --------------------------
```
Get-SPClientField $list -Identity "39ED73EB-FDD8-4870-91A5-EEE0ACB966B2"
```

### -------------------------- Example 3 --------------------------
```
Get-SPClientField $list -Name "Custom Field"
```

### -------------------------- Example 4 --------------------------
```
Get-SPClientField $list -Retrievals "Title"
```

## PARAMETERS

### -ClientContext
Indicates the client context.
If not specified, uses default context.

```yaml
Type: ClientContext
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: $SPClient.ClientContext
Accept pipeline input: False
Accept wildcard characters: False
```

### -ParentObject
Indicates the web or list which the fields are contained.

```yaml
Type: SPClientFieldParentParameter
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Identity
Indicates the field GUID.

```yaml
Type: Guid
Parameter Sets: Identity
Aliases: Id

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Indicates the field title or internal name.

```yaml
Type: String
Parameter Sets: Name
Aliases: Title

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Retrievals
Indicates the data retrieval expression.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### None or SPClient.SPClientFieldParentParameter

## OUTPUTS

### Microsoft.SharePoint.Client.FieldCollection or Microsoft.SharePoint.Client.Field

## NOTES

## RELATED LINKS

[https://github.com/karamem0/SPClient/blob/master/doc/Get-SPClientField.md](https://github.com/karamem0/SPClient/blob/master/doc/Get-SPClientField.md)


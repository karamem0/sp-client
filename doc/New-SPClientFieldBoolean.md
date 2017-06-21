# New-SPClientFieldBoolean

## SYNOPSIS
Creates a new boolean field.

## SYNTAX

```
New-SPClientFieldBoolean [-ClientContext <ClientContext>] [[-ParentObject] <SPClientFieldParentParameter>]
 -Name <String> [-Title <String>] [-Identity <Guid>] [-Description <String>] [-Required <Boolean>]
 [-DefaultValue <Boolean>] [-AddToDefaultView <Boolean>] [-Retrievals <String>]
```

## DESCRIPTION
The New-SPClientFieldBoolean function adds a new field to the web or list.
The
field allows the user to enter a true/false value.

## EXAMPLES

### -------------------------- Example 1 --------------------------
```
New-SPClientFieldBoolean $list -Name "CustomField" -Title "Custom Field"
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
Indicates the web or list which a field to be created.

```yaml
Type: SPClientFieldParentParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Name
Indicates the internal name.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Title
Indicates the title.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: $Name
Accept pipeline input: False
Accept wildcard characters: False
```

### -Identity
Indicates the field GUID.

```yaml
Type: Guid
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Description
Indicates the description.

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

### -Required
Indicates a value whether the field is required.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -DefaultValue
Indicates the default value.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -AddToDefaultView
If true, the field is add to default view.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: False
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

### Microsoft.SharePoint.Client.FieldBoolean

## NOTES

## RELATED LINKS

[https://github.com/karamem0/SPClient/blob/master/doc/New-SPClientFieldBoolean.md](https://github.com/karamem0/SPClient/blob/master/doc/New-SPClientFieldBoolean.md)


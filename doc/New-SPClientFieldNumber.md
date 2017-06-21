# New-SPClientFieldNumber

## SYNOPSIS
Creates a new number field.

## SYNTAX

```
New-SPClientFieldNumber [-ClientContext <ClientContext>] [[-ParentObject] <SPClientFieldParentParameter>]
 -Name <String> [-Title <String>] [-Identity <Guid>] [-Description <String>] [-Required <Boolean>]
 [-EnforceUniqueValues <Boolean>] [-MinimumValue <Double>] [-MaximumValue <Double>] [-Decimals <Int32>]
 [-Percentage <Boolean>] [-DefaultValue <Double>] [-AddToDefaultView <Boolean>] [-Retrievals <String>]
```

## DESCRIPTION
The New-SPClientFieldNumber function adds a new field to the web or list.
The
field allows the user to enter a floating point number.

## EXAMPLES

### -------------------------- Example 1 --------------------------
```
New-SPClientFieldNumber $list -Name "CustomField" -Title "Custom Field"
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

### -EnforceUniqueValues
Indicates a value whether the field must to have unique value.

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

### -MinimumValue
Indicates the minimum value.

```yaml
Type: Double
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaximumValue
Indicates the maximum value.

```yaml
Type: Double
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Decimals
Indicates the number of decimals.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Percentage
Indicates a value whether the field shows as percentage.

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
Type: Double
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 0
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

### Microsoft.SharePoint.Client.FieldNumber

## NOTES

## RELATED LINKS

[https://github.com/karamem0/SPClient/blob/master/doc/New-SPClientFieldNumber.md](https://github.com/karamem0/SPClient/blob/master/doc/New-SPClientFieldNumber.md)


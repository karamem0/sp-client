# New-SPClientFieldDateTime

## SYNOPSIS
Creates a new date/time column.

## SYNTAX

```
New-SPClientFieldDateTime [-ClientContext <ClientContext>] [[-ParentObject] <SPClientFieldParentPipeBind>]
 [-Name <String>] [-Title <String>] [-Identity <Guid>] [-Description <String>] [-Required <Boolean>]
 [-EnforceUniqueValues <Boolean>] [-DisplayFormat <String>] [-FriendlyDisplayFormat <String>]
 [-DefaultValue <String>] [-AddToDefaultView <Boolean>] [-Retrieval <String>]
```

## DESCRIPTION
The New-SPClientFieldDateTime function adds a new column to the site or list.
The column allows the user to enter a date and time.

## EXAMPLES

### -------------------------- Example 1 --------------------------
```
New-SPClientFieldDateTime $list -Name "CustomField" -Title "Custom Field"
```

## PARAMETERS

### -ClientContext
Indicates the client context.
If not specified, uses a default context.

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
Indicates the site or list which a column to be created.

```yaml
Type: SPClientFieldParentPipeBind
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

Required: False
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
Indicates the column GUID.

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
Indicates a value whether the column is required.

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
Indicates a value whether the column must to have unique value.

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

### -DisplayFormat
Indicates the display format.
  - DateOnly
  - DateTime

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

### -FriendlyDisplayFormat
Indicates the friendly display format.
  - Unspecified
  - Disabled
  - Relative

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

### -DefaultValue
Indicates the default value.

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

### -AddToDefaultView
If true, the column is add to default view.

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

### -Retrieval
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

### None or SPClient.SPClientFieldParentPipeBind

## OUTPUTS

### Microsoft.SharePoint.Client.FieldDateTime

## NOTES

## RELATED LINKS

[https://github.com/karamem0/SPClient/blob/master/doc/New-SPClientFieldDateTime.md](https://github.com/karamem0/SPClient/blob/master/doc/New-SPClientFieldDateTime.md)


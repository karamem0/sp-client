# New-SPClientFieldCalculated

## SYNOPSIS
Creates a new calclated column.

## SYNTAX

```
New-SPClientFieldCalculated [-ClientContext <ClientContext>] [[-ParentObject] <SPClientFieldParentParameter>]
 -Name <String> [-Title <String>] [-Identity <Guid>] [-Description <String>] -Formula <String>
 -FieldRefs <String[]> -OutputType <String> [-Decimals <Int32>] [-Percentage <Boolean>] [-LocaleId <Int32>]
 [-DateFormat <String>] [-AddToDefaultView <Boolean>] [-Retrieval <String>]
```

## DESCRIPTION
The New-SPClientFieldCalculated function adds a new column to the site or list.
The value of the column is calculated based on other columns.

## EXAMPLES

### -------------------------- Example 1 --------------------------
```
New-SPClientFieldCalculated $list -Name "CustomField" -Title "Custom Field" -Formula "=[Title]" -FieldRefs "Title" -OutputType "Text"
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
Indicates the site or list which a column to be created.

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

### -Formula
{{Fill Formula Description}}

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

### -FieldRefs
Indicates the collection of columns which used in formula.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OutputType
Indicates the data type of the return value.
  - Text
  - Number
  - Currency
  - DateTime
  - Boolean

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

### -Decimals
Indicates the number of decimals.
This parameter is used when OutputType is
'Number' or 'Currency'.

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
Indicates a value whether the column shows as percentage.
This parameter is
used when OutputType is 'Number'.

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

### -LocaleId
Indicates the language code identifier (LCID).
This parameter is used when
OutputType is 'Currency'.

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

### -DateFormat
Indicates the datetime display format.
This parameter is used when OutputType
is 'DateTime'.

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

### None or SPClient.SPClientFieldParentParameter

## OUTPUTS

### Microsoft.SharePoint.Client.FieldCalculated

## NOTES

## RELATED LINKS

[https://github.com/karamem0/SPClient/blob/master/doc/New-SPClientFieldCalculated.md](https://github.com/karamem0/SPClient/blob/master/doc/New-SPClientFieldCalculated.md)


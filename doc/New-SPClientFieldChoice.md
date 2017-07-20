# New-SPClientFieldChoice

## SYNOPSIS
Creates a new choice column.

## SYNTAX

```
New-SPClientFieldChoice [-ClientContext <ClientContext>] [[-ParentObject] <SPClientFieldParentPipeBind>]
 -Name <String> [-Title <String>] [-Identity <Guid>] [-Description <String>] [-Required <Boolean>]
 [-EnforceUniqueValues <Boolean>] [-Choices <String[]>] [-EditFormat <String>] [-FillInChoice <Boolean>]
 [-DefaultValue <String>] [-AddToDefaultView <Boolean>] [-Retrieval <String>]
```

## DESCRIPTION
The New-SPClientFieldChoice function adds a new column to the site or list.
The column allows the user to select one or mode values.

## EXAMPLES

### -------------------------- Example 1 --------------------------
```
New-SPClientFieldChoice $list -Name "CustomField" -Title "Custom Field"
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

### -Choices
Indicates values that are available for selection in the column.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -EditFormat
Indicates the display format.
  - Dropdown
  - RadioButtons
  - Checkboxes

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

### -FillInChoice
Indicates a value whether the column can accept values other than those specified in Choices.

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

### Microsoft.SharePoint.Client.FieldChoice

## NOTES

## RELATED LINKS

[https://github.com/karamem0/SPClient/blob/master/doc/New-SPClientFieldChoice.md](https://github.com/karamem0/SPClient/blob/master/doc/New-SPClientFieldChoice.md)


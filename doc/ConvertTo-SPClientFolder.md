# ConvertTo-SPClientFolder

## SYNOPSIS
Converts list item to folder.

## SYNTAX

```
ConvertTo-SPClientFolder [-ClientContext <ClientContext>] [-ListItem] <ListItem> [-Retrievals <String>]
```

## DESCRIPTION
The ConvertTo-SPClientFolder function converts the list item to folder.

## EXAMPLES

### -------------------------- Example 1 --------------------------
```
ConvertTo-SPClientFolder $item
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

### -ListItem
Indicates the list item.

```yaml
Type: ListItem
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
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

## OUTPUTS

## NOTES

## RELATED LINKS


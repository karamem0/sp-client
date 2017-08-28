# ConvertTo-SPClientListItem

## SYNOPSIS
Converts file or folder to list item.

## SYNTAX

```
ConvertTo-SPClientListItem [-ClientContext <ClientContext>] [-InputObject] <SPClientListItemConvertPipeBind>
 [-Retrieval <String>]
```

## DESCRIPTION
The ConvertTo-SPClientListItem function converts the file or folder to list item.

## EXAMPLES

### -------------------------- Example 1 --------------------------
```
ConvertTo-SPClientListItem $file
```

### -------------------------- Example 2 --------------------------
```
ConvertTo-SPClientListItem $folder
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

### -InputObject
Indicates the file or folder.

```yaml
Type: SPClientListItemConvertPipeBind
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
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

### None or SPClient.SPClientListItemConvertPipeBind

## OUTPUTS

### Microsoft.SharePoint.Client.ListItem

## NOTES

## RELATED LINKS

[https://github.com/karamem0/SPClient/blob/master/doc/ConvertTo-SPClientListItem.md](https://github.com/karamem0/SPClient/blob/master/doc/ConvertTo-SPClientListItem.md)


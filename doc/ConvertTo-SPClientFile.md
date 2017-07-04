# ConvertTo-SPClientFile

## SYNOPSIS
Converts list item to file.

## SYNTAX

```
ConvertTo-SPClientFile [-ClientContext <ClientContext>] [-InputObject] <SPClientFileConvertParameter>
 [-Retrieval <String>]
```

## DESCRIPTION
The ConvertTo-SPClientFile function converts the list item to file.

## EXAMPLES

### -------------------------- Example 1 --------------------------
```
ConvertTo-SPClientFile $item
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

### -InputObject
Indicates the list item.

```yaml
Type: SPClientFileConvertParameter
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

### None or SPClient.SPClientFileConvertParameter

## OUTPUTS

### Microsoft.SharePoint.Client.File

## NOTES

## RELATED LINKS

[https://github.com/karamem0/SPClient/blob/master/doc/ConvertTo-SPClientFile.md](https://github.com/karamem0/SPClient/blob/master/doc/ConvertTo-SPClientFile.md)


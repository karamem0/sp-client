# ConvertTo-SPClientListItem

## SYNOPSIS
Converts file or folder to list item.

## SYNTAX

### File
```
ConvertTo-SPClientListItem [-ClientContext <ClientContext>] [-File] <File> [-Retrievals <String>]
```

### Folder
```
ConvertTo-SPClientListItem [-ClientContext <ClientContext>] [-Folder] <Folder> [-Retrievals <String>]
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

### -File
Indicates the file.

```yaml
Type: File
Parameter Sets: File
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Folder
Indicates the folder.

```yaml
Type: Folder
Parameter Sets: Folder
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


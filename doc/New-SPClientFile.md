# New-SPClientFile

## SYNOPSIS
Creates a new file.

## SYNTAX

### ContentStream (Default)
```
New-SPClientFile [-ClientContext <ClientContext>] [-ParentObject] <SPClientFileParentPipeBind>
 -ContentStream <Stream> -Name <String> [-Retrieval <String>]
```

### ContentPath
```
New-SPClientFile [-ClientContext <ClientContext>] [-ParentObject] <SPClientFileParentPipeBind>
 -ContentPath <String> [-Name <String>] [-Retrieval <String>]
```

## DESCRIPTION
The New-SPClientFile function adds a new file to the folder.

## EXAMPLES

### -------------------------- Example 1 --------------------------
```
New-SPClientFile $folder -Name "CustomFile.xlsx" -ContentStream $stream
```

### -------------------------- Example 2 --------------------------
```
New-SPClientFile $folder -ContentPath "C:\Users\admin\Documents\CustomFile.xlsx"
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
Indicates the folder which a file to be created.

```yaml
Type: SPClientFileParentPipeBind
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -ContentStream
Indicates the content stream.

```yaml
Type: Stream
Parameter Sets: ContentStream
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ContentPath
Indicates the content file path.

```yaml
Type: String
Parameter Sets: ContentPath
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Indicates the file name.

```yaml
Type: String
Parameter Sets: ContentStream
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: String
Parameter Sets: ContentPath
Aliases: 

Required: False
Position: Named
Default value: None
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

### None or SPClient.SPClientFileParentPipeBind

## OUTPUTS

### Microsoft.SharePoint.Client.File

## NOTES

## RELATED LINKS

[https://github.com/karamem0/SPClient/blob/master/doc/New-SPClientFile.md](https://github.com/karamem0/SPClient/blob/master/doc/New-SPClientFile.md)


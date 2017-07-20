# Remove-SPClientFile

## SYNOPSIS
Deletes the file.

## SYNTAX

### ClientObject (Default)
```
Remove-SPClientFile [-ClientContext <ClientContext>] [-ClientObject] <File>
```

### Name
```
Remove-SPClientFile [-ClientContext <ClientContext>] [-ParentObject] <SPClientFileParentPipeBind>
 -Name <String>
```

### Url
```
Remove-SPClientFile [-ClientContext <ClientContext>] -Web <Web> -Url <String>
```

### Identity
```
Remove-SPClientFile [-ClientContext <ClientContext>] -Web <Web> -Identity <Guid>
```

## DESCRIPTION
The Remove-SPClientFile function removes the file from the folder.

## EXAMPLES

### -------------------------- Example 1 --------------------------
```
Remove-SPClientFile $file
```

### -------------------------- Example 2 --------------------------
```
Remove-SPClientFile $folder -Name "CustomFile.xlsx"
```

### -------------------------- Example 3 --------------------------
```
Remove-SPClientFile -Web $web -Identity "185C6C6E-7E79-4C80-88D8-7392B4CA47CB"
```

### -------------------------- Example 4 --------------------------
```
Remove-SPClientFile -Web $web -Url "http://example.com/DocLib1/CustomFile.xlsx"
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

### -ClientObject
Indicates the file to delete.

```yaml
Type: File
Parameter Sets: ClientObject
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -ParentObject
Indicates the folder which the files are contained.

```yaml
Type: SPClientFileParentPipeBind
Parameter Sets: Name
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Name
Indicates the file name including the extension.

```yaml
Type: String
Parameter Sets: Name
Aliases: Title

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Web
Indicates the site which the files are contained.

```yaml
Type: Web
Parameter Sets: Url, Identity
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Identity
Indicates the file GUID.

```yaml
Type: Guid
Parameter Sets: Identity
Aliases: Id

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Url
Indicates the file URL.

```yaml
Type: String
Parameter Sets: Url
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### None or SPClient.SPClientFileParentPipeBind

## OUTPUTS

### None

## NOTES

## RELATED LINKS

[https://github.com/karamem0/SPClient/blob/master/doc/Remove-SPClientFile.md](https://github.com/karamem0/SPClient/blob/master/doc/Remove-SPClientFile.md)


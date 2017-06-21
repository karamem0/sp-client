# Remove-SPClientFolder

## SYNOPSIS
Deletes the folder.

## SYNTAX

### ClientObject (Default)
```
Remove-SPClientFolder [-ClientContext <ClientContext>] [-ClientObject] <Folder>
```

### Name
```
Remove-SPClientFolder [-ClientContext <ClientContext>] [-ParentFolder] <Folder> -Name <String>
```

### Url
```
Remove-SPClientFolder [-ClientContext <ClientContext>] [-ParentWeb] <Web> -Url <String>
```

### Identity
```
Remove-SPClientFolder [-ClientContext <ClientContext>] [-ParentWeb] <Web> -Identity <Guid>
```

## DESCRIPTION
The Remove-SPClientFolder function deletes the folder from the folder.

## EXAMPLES

### -------------------------- Example 1 --------------------------
```
Remove-SPClientFolder $folder
```

### -------------------------- Example 2 --------------------------
```
Remove-SPClientFolder $folder -Name "Folder"
```

### -------------------------- Example 3 --------------------------
```
Remove-SPClientFolder $web -Url "http://example.com/DocLib1/Folder"
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
Indicates the folder to delete.

```yaml
Type: Folder
Parameter Sets: ClientObject
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -ParentFolder
Indicates the folder which the folders are contained.

```yaml
Type: Folder
Parameter Sets: Name
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -ParentWeb
Indicates the web which the folders are contained.

```yaml
Type: Web
Parameter Sets: Url, Identity
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Name
Indicates the folder name.

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

### -Identity
Indicates the folder GUID.

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
Indicates the folder URL.

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

### None or Microsoft.SharePoint.Client.Folder or Microsoft.SharePoint.Client.Web

## OUTPUTS

### None

## NOTES

## RELATED LINKS

[https://github.com/karamem0/SPClient/blob/master/doc/Remove-SPClientFolder.md](https://github.com/karamem0/SPClient/blob/master/doc/Remove-SPClientFolder.md)


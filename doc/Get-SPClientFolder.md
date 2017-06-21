# Get-SPClientFolder

## SYNOPSIS
Gets one or more folders.

## SYNTAX

### All (Default)
```
Get-SPClientFolder [-ClientContext <ClientContext>] [-ParentFolder] <Folder> [-Retrievals <String>]
```

### Name
```
Get-SPClientFolder [-ClientContext <ClientContext>] [-ParentFolder] <Folder> -Name <String>
 [-Retrievals <String>]
```

### Url
```
Get-SPClientFolder [-ClientContext <ClientContext>] [-ParentWeb] <Web> -Url <String> [-Retrievals <String>]
```

### Identity
```
Get-SPClientFolder [-ClientContext <ClientContext>] [-ParentWeb] <Web> -Identity <Guid> [-Retrievals <String>]
```

## DESCRIPTION
The Get-SPClientFolder function lists all folders or retrieves the specified
folder.
If not specified filterable parameter, returns all sub folders in the
folder.
Otherwise, returns a folder which matches the parameter.

## EXAMPLES

### -------------------------- Example 1 --------------------------
```
Get-SPClientFolder $folder
```

### -------------------------- Example 2 --------------------------
```
Get-SPClientFolder $folder -Name "CustomFolder"
```

### -------------------------- Example 3 --------------------------
```
Get-SPClientFolder $web -Identity "7F3120E3-0B31-46E9-9621-55ADAC4612E7"
```

### -------------------------- Example 4 --------------------------
```
Get-SPClientFolder $web -Url "http://example.com/DocLib1/CustomFolder"
```

### -------------------------- Example 5 --------------------------
```
Get-SPClientFolder $folder -Retrievals "ServerRelativeUrl"
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

### -ParentFolder
Indicates the folder which the folders are contained.

```yaml
Type: Folder
Parameter Sets: All, Name
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
Aliases: 

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

### None or Microsoft.SharePoint.Client.Folder or Microsoft.SharePoint.Client.Web

## OUTPUTS

### Microsoft.SharePoint.Client.FolderCollection or Microsoft.SharePoint.Client.Folder

## NOTES

## RELATED LINKS

[https://github.com/karamem0/SPClient/blob/master/doc/Get-SPClientFolder.md](https://github.com/karamem0/SPClient/blob/master/doc/Get-SPClientFolder.md)


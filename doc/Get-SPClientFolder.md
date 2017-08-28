# Get-SPClientFolder

## SYNOPSIS
Gets one or more folders.

## SYNTAX

### All (Default)
```
Get-SPClientFolder [-ClientContext <ClientContext>] [-ParentObject] <SPClientFolderParentPipeBind>
 [-NoEnumerate] [-Retrieval <String>]
```

### Name
```
Get-SPClientFolder [-ClientContext <ClientContext>] [-ParentObject] <SPClientFolderParentPipeBind>
 -Name <String> [-Retrieval <String>]
```

### Url
```
Get-SPClientFolder [-ClientContext <ClientContext>] -Web <Web> -Url <String> [-Retrieval <String>]
```

### Identity
```
Get-SPClientFolder [-ClientContext <ClientContext>] -Web <Web> -Identity <Guid> [-Retrieval <String>]
```

## DESCRIPTION
The Get-SPClientFolder function lists all folders or retrieves the specified folder.
If not specified filterable parameter, returns all subfolders in the folder.
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
Get-SPClientFolder -Web $web -Identity "7F3120E3-0B31-46E9-9621-55ADAC4612E7"
```

### -------------------------- Example 4 --------------------------
```
Get-SPClientFolder -Web $web -Url "http://example.com/DocLib1/CustomFolder"
```

### -------------------------- Example 5 --------------------------
```
Get-SPClientFolder $folder -Retrieval "ServerRelativeUrl"
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

### -ParentObject
Indicates the folder which the subfolders are contained.

```yaml
Type: SPClientFolderParentPipeBind
Parameter Sets: All, Name
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -NoEnumerate
If specified, suppresses enumeration in output.

```yaml
Type: SwitchParameter
Parameter Sets: All
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
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

### -Web
Indicates the site which the folders are contained.

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

### None or SPClient.SPClientFolderParentPipeBind

## OUTPUTS

### Microsoft.SharePoint.Client.Folder[]

## NOTES

## RELATED LINKS

[https://github.com/karamem0/SPClient/blob/master/doc/Get-SPClientFolder.md](https://github.com/karamem0/SPClient/blob/master/doc/Get-SPClientFolder.md)


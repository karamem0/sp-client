# Get-SPClientFile

## SYNOPSIS
Gets one or more files.

## SYNTAX

### All (Default)
```
Get-SPClientFile [-ClientContext <ClientContext>] [-ParentObject] <SPClientFileParentParameter> [-NoEnumerate]
 [-Retrieval <String>]
```

### Name
```
Get-SPClientFile [-ClientContext <ClientContext>] [-ParentObject] <SPClientFileParentParameter> -Name <String>
 [-Retrieval <String>]
```

### Url
```
Get-SPClientFile [-ClientContext <ClientContext>] -Web <Web> -Url <String> [-Retrieval <String>]
```

### Identity
```
Get-SPClientFile [-ClientContext <ClientContext>] -Web <Web> -Identity <Guid> [-Retrieval <String>]
```

## DESCRIPTION
The Get-SPClientFile function lists all files or retrieve the specified file.
If not specified filterable parameter, returns all files in the folder.
Otherwise, returns a file which matches the parameter.

## EXAMPLES

### -------------------------- Example 1 --------------------------
```
Get-SPClientFile $folder
```

### -------------------------- Example 2 --------------------------
```
Get-SPClientFile $folder -Name "CustomFile.xlsx"
```

### -------------------------- Example 3 --------------------------
```
Get-SPClientFile -Web $web -Identity "185C6C6E-7E79-4C80-88D8-7392B4CA47CB"
```

### -------------------------- Example 4 --------------------------
```
Get-SPClientFile -Web $web -Url "http://example.com/DocLib1/CustomFile.xlsx"
```

### -------------------------- Example 5 --------------------------
```
Get-SPClientFile $folder -Retrieval "ServerRelativeUrl"
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
Indicates the folder which the files are contained.

```yaml
Type: SPClientFileParentParameter
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
Indicates the file name including the extension.

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

### None or SPClient.SPClientFileParentParameter

## OUTPUTS

### Microsoft.SharePoint.Client.FileCollection or Microsoft.SharePoint.Client.File

## NOTES

## RELATED LINKS

[https://github.com/karamem0/SPClient/blob/master/doc/Get-SPClientFile.md](https://github.com/karamem0/SPClient/blob/master/doc/Get-SPClientFile.md)


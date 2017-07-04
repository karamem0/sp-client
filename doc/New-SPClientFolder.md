# New-SPClientFolder

## SYNOPSIS
Creates a new folder.

## SYNTAX

```
New-SPClientFolder [-ClientContext <ClientContext>] [-ParentObject] <SPClientFolderParentParameter>
 -Name <String> [-Retrieval <String>]
```

## DESCRIPTION
The New-SPClientFolder function adds a new subfolder to the folder.

## EXAMPLES

### -------------------------- Example 1 --------------------------
```
New-SPClientFolder $folder -Name "CustomFolder"
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
Indicates the folder which a subfolder to be created.

```yaml
Type: SPClientFolderParentParameter
Parameter Sets: (All)
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
Parameter Sets: (All)
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

### None or SPClient.SPClientFolderParentParameter

## OUTPUTS

### Microsoft.SharePoint.Client.Folder

## NOTES

## RELATED LINKS

[https://github.com/karamem0/SPClient/blob/master/doc/New-SPClientFolder.md](https://github.com/karamem0/SPClient/blob/master/doc/New-SPClientFolder.md)


# New-SPClientList

## SYNOPSIS
Creates a new list.

## SYNTAX

```
New-SPClientList [-ClientContext <ClientContext>] [-ParentObject] <SPClientListParentPipeBind> -Name <String>
 [-Title <String>] [-Description <String>] [-Template <Int32>] [-EnableAttachments <Boolean>]
 [-EnableFolderCreation <Boolean>] [-EnableVersioning <Boolean>] [-NoCrawl <Boolean>]
 [-OnQuickLaunch <Boolean>] [-Retrieval <String>]
```

## DESCRIPTION
The New-SPClientList function adds a new list to the site.

## EXAMPLES

### -------------------------- Example 1 --------------------------
```
New-SPClientList -Name "CustomList" -Title "Custom List"
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
Indicates the site which a list to be created.

```yaml
Type: SPClientListParentPipeBind
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Name
Indicates the internal name.

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

### -Title
Indicates the title.
If not specified, uses the internal name.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: $Name
Accept pipeline input: False
Accept wildcard characters: False
```

### -Description
Indicates the description.

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

### -Template
Indicates the template ID.
If not specified, uses 100 (Generic List).

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 100
Accept pipeline input: False
Accept wildcard characters: False
```

### -EnableAttachments
Indicates a value whether attachments are enabled.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -EnableFolderCreation
Indicates a value whether new folders can be added.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -EnableVersioning
Indicates a value whether historical versions can be created.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -NoCrawl
Indicates a value whether crawler must not crawl.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -OnQuickLaunch
Indicates a value whether the list is displayed on the quick launch.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: False
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

### None or SPClient.SPClientListParentPipeBind

## OUTPUTS

### Microsoft.SharePoint.Client.List

## NOTES

## RELATED LINKS

[https://github.com/karamem0/SPClient/blob/master/doc/New-SPClientList.md](https://github.com/karamem0/SPClient/blob/master/doc/New-SPClientList.md)


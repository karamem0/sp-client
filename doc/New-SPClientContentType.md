# New-SPClientContentType

## SYNOPSIS
Creates a new content type.

## SYNTAX

```
New-SPClientContentType [-ClientContext <ClientContext>] [-ParentObject] <SPClientContentTypeParentParameter>
 -Name <String> [-Description <String>] [-Group <String>] [-ParentContentType <ContentType>]
 [-Retrievals <String>]
```

## DESCRIPTION
The New-SPClientContentType function adds a new content type to the web.

## EXAMPLES

### -------------------------- Example 1 --------------------------
```
New-SPClientContentType $web -Name "Custom Content Type"
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
Indicates the web or list which a content type to be created.

```yaml
Type: SPClientContentTypeParentParameter
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

### -Group
Indicates the group name.

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

### -ParentContentType
Indicates the parent content type.

```yaml
Type: ContentType
Parameter Sets: (All)
Aliases: 

Required: False
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

### None or SPClient.SPClientContentTypeParentParameter

## OUTPUTS

### Microsoft.SharePoint.Client.ContentType

## NOTES

## RELATED LINKS

[https://github.com/karamem0/SPClient/blob/master/doc/New-SPClientContentType.md](https://github.com/karamem0/SPClient/blob/master/doc/New-SPClientContentType.md)


# Add-SPClientContentTypeField

## SYNOPSIS
Adds a column to the content type.

## SYNTAX

```
Add-SPClientContentTypeField [-ClientContext <ClientContext>] [-ContentType] <ContentType> -Field <Field>
 [-UpdateChildren] [-PassThru]
```

## DESCRIPTION
The Add-SPClientContentTypeField function adds a exsiting site column to the specified content type.

## EXAMPLES

### -------------------------- Example 1 --------------------------
```
Add-SPClientContentTypeField $contentType -Field $field -UpdateChildren
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

### -ContentType
Indicates the content type.

```yaml
Type: ContentType
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Field
Indicates the column to add.

```yaml
Type: Field
Parameter Sets: (All)
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UpdateChildren
If specified, updates all content types that inherit from the content type.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -PassThru
If specified, returns the content type.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### None or Microsoft.SharePoint.Client.ContentType

## OUTPUTS

### None or Microsoft.SharePoint.Client.ContentType

## NOTES

## RELATED LINKS

[https://github.com/karamem0/SPClient/blob/master/doc/Add-SPClientContentTypeField.md](https://github.com/karamem0/SPClient/blob/master/doc/Add-SPClientContentTypeField.md)


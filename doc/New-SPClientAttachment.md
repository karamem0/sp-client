# New-SPClientAttachment

## SYNOPSIS
Creates a new attachment.

## SYNTAX

### ContentStream (Default)
```
New-SPClientAttachment [-ClientContext <ClientContext>] [-ParentObject] <SPClientAttachmentParentPipeBind>
 -ContentStream <Stream> -Name <String> [-Retrieval <String>]
```

### ContentPath
```
New-SPClientAttachment [-ClientContext <ClientContext>] [-ParentObject] <SPClientAttachmentParentPipeBind>
 -ContentPath <String> [-Name <String>] [-Retrieval <String>]
```

## DESCRIPTION
The New-SPClientAttachment function adds a new attachment to the list item.

## EXAMPLES

### -------------------------- Example 1 --------------------------
```
New-SPClientAttachment $item -Name "CustomAttachment.xlsx" -ContentStream $stream
```

### -------------------------- Example 2 --------------------------
```
New-SPClientAttachment $item -ContentPath "C:\Users\admin\Documents\CustomAttachment.xlsx"
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
Indicates the list item which a attachment to be created.

```yaml
Type: SPClientAttachmentParentPipeBind
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
{{Fill Name Description}}

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

### None or SPClient.SPClientAttachmentParentPipeBind

## OUTPUTS

### Microsoft.SharePoint.Client.Attachment

## NOTES

## RELATED LINKS

[https://github.com/karamem0/SPClient/blob/master/doc/New-SPClientAttachment.md](https://github.com/karamem0/SPClient/blob/master/doc/New-SPClientAttachment.md)


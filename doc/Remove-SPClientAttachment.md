# Remove-SPClientAttachment

## SYNOPSIS
Deletes the attachment.

## SYNTAX

### ClientObject (Default)
```
Remove-SPClientAttachment [-ClientContext <ClientContext>] [-ClientObject] <Attachment>
```

### FileName
```
Remove-SPClientAttachment [-ClientContext <ClientContext>] [-ParentObject] <SPClientAttachmentParentPipeBind>
 -FileName <String>
```

## DESCRIPTION
The Remove-SPClientAttachment function removes the attachment from the list item.

## EXAMPLES

### -------------------------- Example 1 --------------------------
```
Remove-SPClientAttachment $attachment
```

### -------------------------- Example 2 --------------------------
```
Remove-SPClientAttachment $item -FileName "CustomAttachment.xlsx"
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
Indicates the attachment to delete.

```yaml
Type: Attachment
Parameter Sets: ClientObject
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -ParentObject
Indicates the list item which the attachment is contained.

```yaml
Type: SPClientAttachmentParentPipeBind
Parameter Sets: FileName
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -FileName
Indicates the attachment file name.

```yaml
Type: String
Parameter Sets: FileName
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### None or Microsoft.SharePoint.Client.Attachment or SPClient.SPClientAttachmentParentPipeBind

## OUTPUTS

### None

## NOTES

## RELATED LINKS

[https://github.com/karamem0/SPClient/blob/master/doc/Remove-SPClientAttachment.md](https://github.com/karamem0/SPClient/blob/master/doc/Remove-SPClientAttachment.md)


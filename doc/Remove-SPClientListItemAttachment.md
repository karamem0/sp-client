# Remove-SPClientListItemAttachment

## SYNOPSIS
Deletes the attachment.

## SYNTAX

### ClientObject (Default)
```
Remove-SPClientListItemAttachment [-ClientContext <ClientContext>] [-ClientObject] <Attachment>
```

### FileName
```
Remove-SPClientListItemAttachment [-ClientContext <ClientContext>] [-ParentListItem] <ListItem>
 -FileName <String>
```

## DESCRIPTION
The Remove-SPClientListItemAttachment function deletes the attachment from the
list item.

## EXAMPLES

### -------------------------- Example 1 --------------------------
```
Remove-SPClientListItemAttachment $attachment
```

### -------------------------- Example 2 --------------------------
```
Remove-SPClientListItemAttachment $item -FileName "CustomAttachment.xlsx"
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

### -ParentListItem
Indicates the list item which the attachment is contained.

```yaml
Type: ListItem
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

### None or Microsoft.SharePoint.Client.Attachment or Microsoft.SharePoint.Client.ListItem

## OUTPUTS

### None

## NOTES

## RELATED LINKS

[https://github.com/karamem0/SPClient/blob/master/doc/Remove-SPClientListItemAttachment.md](https://github.com/karamem0/SPClient/blob/master/doc/Remove-SPClientListItemAttachment.md)


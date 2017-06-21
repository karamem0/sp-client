# Get-SPClientListItemAttachment

## SYNOPSIS
Gets one or more attachments.

## SYNTAX

### All (Default)
```
Get-SPClientListItemAttachment [-ClientContext <ClientContext>] [-ParentListItem] <ListItem>
 [-Retrievals <String>]
```

### Name
```
Get-SPClientListItemAttachment [-ClientContext <ClientContext>] [-ParentListItem] <ListItem> -Name <String>
 [-Retrievals <String>]
```

## DESCRIPTION
The Get-SPClientListItemAttachment function lists all attachments or retrieves
the specified attachment.
If not specified filterable parameter, returns all
attachments of the list item.
Otherwise, returns a attachment which matches
the parameter.

## EXAMPLES

### -------------------------- Example 1 --------------------------
```
Get-SPClientListItemAttachment $item
```

### -------------------------- Example 2 --------------------------
```
Get-SPClientListItemAttachment $item -FileName "CustomAttachment.xlsx"
```

### -------------------------- Example 3 --------------------------
```
Get-SPClientListItemAttachment $item -Retrievals "FileName"
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

### -ParentListItem
Indicates the list item which the attachments are contained.

```yaml
Type: ListItem
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Name
{{Fill Name Description}}

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

### None or Microsoft.SharePoint.Client.ListItem

## OUTPUTS

### Microsoft.SharePoint.Client.AttachmentCollection or Microsoft.SharePoint.Client.Attachment

## NOTES

## RELATED LINKS

[https://github.com/karamem0/SPClient/blob/master/doc/Get-SPClientListItemAttachment.md](https://github.com/karamem0/SPClient/blob/master/doc/Get-SPClientListItemAttachment.md)


# New-SPClientListItemAttachment

## SYNOPSIS
Creates a new attachment.

## SYNTAX

### ContentStream (Default)
```
New-SPClientListItemAttachment [-ClientContext <ClientContext>] [-ParentListItem] <ListItem>
 -ContentStream <Stream> -Name <String> [-Retrievals <String>]
```

### ContentPath
```
New-SPClientListItemAttachment [-ClientContext <ClientContext>] [-ParentListItem] <ListItem>
 -ContentPath <String> [-Name <String>] [-Retrievals <String>]
```

## DESCRIPTION
The New-SPClientListItemAttachment function adds a new attachment to the list
item.

## EXAMPLES

### -------------------------- Example 1 --------------------------
```
New-SPClientListItemAttachment $item -Name "CustomAttachment.xlsx" -ContentStream $stream
```

### -------------------------- Example 2 --------------------------
```
New-SPClientListItemAttachment $item -ContentPath "C:\Users\admin\Documents\CustomAttachment.xlsx"
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
Indicates the list item which a attachment to be created.

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

### Microsoft.SharePoint.Client.Attachment

## NOTES

## RELATED LINKS

[https://github.com/karamem0/SPClient/blob/master/doc/New-SPClientListItemAttachment.md](https://github.com/karamem0/SPClient/blob/master/doc/New-SPClientListItemAttachment.md)


# Get-SPClientAttachment

## SYNOPSIS
Gets one or more attachments.

## SYNTAX

### All (Default)
```
Get-SPClientAttachment [-ClientContext <ClientContext>] [-ParentObject] <SPClientAttachmentParentParameter>
 [-NoEnumerate] [-Retrieval <String>]
```

### Name
```
Get-SPClientAttachment [-ClientContext <ClientContext>] [-ParentObject] <SPClientAttachmentParentParameter>
 -Name <String> [-Retrieval <String>]
```

## DESCRIPTION
The Get-SPClientAttachment function lists all attachments or retrieves the specified attachment.
If not specified filterable parameter, returns all attachments of the list item.
Otherwise, returns a attachment which matches the parameter.

## EXAMPLES

### -------------------------- Example 1 --------------------------
```
Get-SPClientAttachment $item
```

### -------------------------- Example 2 --------------------------
```
Get-SPClientAttachment $item -FileName "CustomAttachment.xlsx"
```

### -------------------------- Example 3 --------------------------
```
Get-SPClientAttachment $item -Retrieval "FileName"
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
Indicates the list item which the attachments are contained.

```yaml
Type: SPClientAttachmentParentParameter
Parameter Sets: (All)
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

### None or SPClient.SPClientAttachmentParentParameter

## OUTPUTS

### Microsoft.SharePoint.Client.AttachmentCollection or Microsoft.SharePoint.Client.Attachment

## NOTES

## RELATED LINKS

[https://github.com/karamem0/SPClient/blob/master/doc/Get-SPClientAttachment.md](https://github.com/karamem0/SPClient/blob/master/doc/Get-SPClientAttachment.md)


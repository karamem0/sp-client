# Remove-SPClientListItem

## SYNOPSIS
Deletes the list item.

## SYNTAX

### ClientObject (Default)
```
Remove-SPClientListItem [-ClientContext <ClientContext>] [-ClientObject] <ListItem>
```

### Identity
```
Remove-SPClientListItem [-ClientContext <ClientContext>] [-ParentList] <List> -Identity <Int32>
```

## DESCRIPTION
The Remove-SPClientListItem function deletes the list item from the list.

## EXAMPLES

### -------------------------- Example 1 --------------------------
```
Remove-SPClientListItem $item
```

### -------------------------- Example 2 --------------------------
```
Remove-SPClientListItem $list -Identity 7
```

### -------------------------- Example 3 --------------------------
```
Remove-SPClientListItem $list -IdentityGuid "77DF0F67-9B13-4499-AC14-25EB18E1D3DA"
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
Indicates the list item to delete.

```yaml
Type: ListItem
Parameter Sets: ClientObject
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -ParentList
Indicates the list which the list item is contained.

```yaml
Type: List
Parameter Sets: Identity
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Identity
Indicates the list item ID.

```yaml
Type: Int32
Parameter Sets: Identity
Aliases: Id

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### None or Microsoft.SharePoint.Client.ListItem or Microsoft.SharePoint.Client.List

## OUTPUTS

### None

## NOTES

## RELATED LINKS

[https://github.com/karamem0/SPClient/blob/master/doc/Remove-SPClientListItem.md](https://github.com/karamem0/SPClient/blob/master/doc/Remove-SPClientListItem.md)


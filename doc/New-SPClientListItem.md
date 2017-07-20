# New-SPClientListItem

## SYNOPSIS
Creates a new list item.

## SYNTAX

```
New-SPClientListItem [-ClientContext <ClientContext>] [-ParentObject] <SPClientListItemParentPipeBind>
 [-FieldValues <Hashtable>] [-Retrieval <String>]
```

## DESCRIPTION
The New-SPClientListItem function adds a new list item to the list.

## EXAMPLES

### -------------------------- Example 1 --------------------------
```
New-SPClientListItem $list -FieldValues @{ Title = "Custom List Item" }
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
Indicates the list which a list item to be created.

```yaml
Type: SPClientListItemParentPipeBind
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -FieldValues
Indicates the column key/value collection.

```yaml
Type: Hashtable
Parameter Sets: (All)
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

### None or SPClient.SPClientListItemParentPipeBind

## OUTPUTS

### Microsoft.SharePoint.Client.ListItem

## NOTES

## RELATED LINKS

[https://github.com/karamem0/SPClient/blob/master/doc/New-SPClientListItem.md](https://github.com/karamem0/SPClient/blob/master/doc/New-SPClientListItem.md)


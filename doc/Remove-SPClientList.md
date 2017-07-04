# Remove-SPClientList

## SYNOPSIS
Deletes the list.

## SYNTAX

### ClientObject (Default)
```
Remove-SPClientList [-ClientContext <ClientContext>] [-ClientObject] <List>
```

### Name
```
Remove-SPClientList [-ClientContext <ClientContext>] [-ParentObject] <SPClientListParentParameter>
 -Name <String>
```

### Url
```
Remove-SPClientList [-ClientContext <ClientContext>] [-ParentObject] <SPClientListParentParameter>
 -Url <String>
```

### Identity
```
Remove-SPClientList [-ClientContext <ClientContext>] [-ParentObject] <SPClientListParentParameter>
 -Identity <Guid>
```

## DESCRIPTION
The Remove-SPClientList function removes the list from the site.

## EXAMPLES

### -------------------------- Example 1 --------------------------
```
Remove-SPClientList $list
```

### -------------------------- Example 2 --------------------------
```
Remove-SPClientList $web -Identity "CE5D9232-37A1-41D0-BCDB-B8C59958B831"
```

### -------------------------- Example 3 --------------------------
```
Remove-SPClientList $web -Url "/Lists/CustomList"
```

### -------------------------- Example 4 --------------------------
```
Remove-SPClientList $web -Name "Custom List"
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
Indicates the list to delete.

```yaml
Type: List
Parameter Sets: ClientObject
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -ParentObject
Indicates the site which the list is contained.

```yaml
Type: SPClientListParentParameter
Parameter Sets: Name, Url, Identity
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Identity
Indicates the list GUID.

```yaml
Type: Guid
Parameter Sets: Identity
Aliases: Id

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Url
Indicates the list URL.

```yaml
Type: String
Parameter Sets: Url
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Indicates the list title or internal name.

```yaml
Type: String
Parameter Sets: Name
Aliases: Title

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### None or Microsoft.SharePoint.Client.List or SPClient.SPClientListParentParameter

## OUTPUTS

### None

## NOTES

## RELATED LINKS

[https://github.com/karamem0/SPClient/blob/master/doc/Remove-SPClientList.md](https://github.com/karamem0/SPClient/blob/master/doc/Remove-SPClientList.md)


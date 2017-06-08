# Remove-SPClientGroup

## SYNOPSIS
Deletes the group.

## SYNTAX

### ClientObject (Default)
```
Remove-SPClientGroup [-ClientContext <ClientContext>] [-ClientObject] <Group>
```

### Identity
```
Remove-SPClientGroup [-ClientContext <ClientContext>] -Identity <Int32>
```

### Name
```
Remove-SPClientGroup [-ClientContext <ClientContext>] -Name <String>
```

## DESCRIPTION
The Remove-SPClientGroup function deletes the group from the site.

## EXAMPLES

### -------------------------- Example 1 --------------------------
```
Remove-SPClientGroup $group
```

### -------------------------- Example 2 --------------------------
```
Remove-SPClientGroup -Identity 7
```

### -------------------------- Example 3 --------------------------
```
Remove-SPClientGroup -Name "Custom Group"
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
Indicates the group to delete.

```yaml
Type: Group
Parameter Sets: ClientObject
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Identity
Indicates the group ID.

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

### -Name
Indicates the group name.

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

## OUTPUTS

## NOTES

## RELATED LINKS


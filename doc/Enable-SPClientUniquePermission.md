# Enable-SPClientUniquePermission

## SYNOPSIS
Enables unique permissions.

## SYNTAX

```
Enable-SPClientUniquePermission [-ClientContext <ClientContext>] [-ClientObject] <SecurableObject>
 [-CopyRoleAssignments] [-ClearSubscopes]
```

## DESCRIPTION
The Enable-SPClientUniquePermission function enables unique role assignments
to the specified object.

## EXAMPLES

### -------------------------- Example 1 --------------------------
```
Enable-SPClientUniquePermission $item
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
Indicates the web, list or item.

```yaml
Type: SecurableObject
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -CopyRoleAssignments
If specified, copies role assignments from the parent object.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ClearSubscopes
If specified, resets role assignments of child objects.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS


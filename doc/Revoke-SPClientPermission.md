# Revoke-SPClientPermission

## SYNOPSIS
Revokes one or more permissions.

## SYNTAX

### All (Default)
```
Revoke-SPClientPermission [-ClientContext <ClientContext>] [-ClientObject] <SecurableObject>
 -Member <Principal> [-All]
```

### Roles
```
Revoke-SPClientPermission [-ClientContext <ClientContext>] [-ClientObject] <SecurableObject>
 -Member <Principal> -Roles <Object[]>
```

## DESCRIPTION
The Revoke-SPClientPermission function revokes role assignments to the
specified object.

## EXAMPLES

### -------------------------- Example 1 --------------------------
```
Revoke-SPClientPermission $item -Member $user -Roles "Full Control"
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

### -Member
Indicates the user or group to be revoked permission.

```yaml
Type: Principal
Parameter Sets: (All)
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -All
{{Fill All Description}}

```yaml
Type: SwitchParameter
Parameter Sets: All
Aliases: 

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Roles
Indicates the roles to be removed.

```yaml
Type: Object[]
Parameter Sets: Roles
Aliases: 

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


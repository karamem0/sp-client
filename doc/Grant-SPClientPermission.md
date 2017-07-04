# Grant-SPClientPermission

## SYNOPSIS
Grants one or more permissions.

## SYNTAX

```
Grant-SPClientPermission [-ClientContext <ClientContext>] [-ClientObject] <SecurableObject> -Member <Principal>
 -Roles <Object[]> [-PassThru]
```

## DESCRIPTION
The Grant-SPClientPermission function grants role assignments to the specified object.

## EXAMPLES

### -------------------------- Example 1 --------------------------
```
Grant-SPClientPermission $item -Member $user -Roles "Full Control"
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
Indicates the site, list or item.

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
Indicates the user or group to be granted permission.

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

### -Roles
Indicates the roles to be added.

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PassThru
If specified, returns input object.

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

### None or Microsoft.SharePoint.Client.SecurableObject

## OUTPUTS

### None

## NOTES

## RELATED LINKS

[https://github.com/karamem0/SPClient/blob/master/doc/Grant-SPClientPermission.md](https://github.com/karamem0/SPClient/blob/master/doc/Grant-SPClientPermission.md)


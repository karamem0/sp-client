# Clear-SPClientPermission

## SYNOPSIS
Clears all permission.

## SYNTAX

```
Clear-SPClientPermission [-ClientContext <ClientContext>] [-ClientObject] <SecurableObject> [-PassThru]
```

## DESCRIPTION
The Clear-SPClientPermission function clears all role assignments from the specified object.

## EXAMPLES

### -------------------------- Example 1 --------------------------
```
Clear-SPClientPermission $item
```

## PARAMETERS

### -ClientContext
Indicates the client context.
If not specified, uses a default context.

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

[https://github.com/karamem0/SPClient/blob/master/doc/Clear-SPClientPermission.md](https://github.com/karamem0/SPClient/blob/master/doc/Clear-SPClientPermission.md)


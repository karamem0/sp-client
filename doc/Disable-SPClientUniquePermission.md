# Disable-SPClientUniquePermission

## SYNOPSIS
Disables unique permissions.

## SYNTAX

```
Disable-SPClientUniquePermission [-ClientContext <ClientContext>] [-ClientObject] <SecurableObject> [-PassThru]
```

## DESCRIPTION
The Disable-SPClientUniquePermission function disables unique role assignments
to the specified object.

## EXAMPLES

### -------------------------- Example 1 --------------------------
```
Disable-SPClientUniquePermission $item
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

[https://github.com/karamem0/SPClient/blob/master/doc/Disable-SPClientUniquePermission.md](https://github.com/karamem0/SPClient/blob/master/doc/Disable-SPClientUniquePermission.md)


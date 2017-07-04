# Remove-SPClientWeb

## SYNOPSIS
Deletes the site.

## SYNTAX

### ClientObject (Default)
```
Remove-SPClientWeb [-ClientContext <ClientContext>] [-ClientObject] <Web>
```

### Identity
```
Remove-SPClientWeb [-ClientContext <ClientContext>] -Identity <Guid>
```

### Url
```
Remove-SPClientWeb [-ClientContext <ClientContext>] -Url <String>
```

## DESCRIPTION
The Remove-SPClientWeb function removes the subsite from the site.

## EXAMPLES

### -------------------------- Example 1 --------------------------
```
Remove-SPClientWeb $web
```

### -------------------------- Example 2 --------------------------
```
Remove-SPClientWeb -Identity "B7FB9B8D-A815-496F-B16B-CC1B26CCAC33"
```

### -------------------------- Example 3 --------------------------
```
Remove-SPClientWeb -Url "/CustomWeb"
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
Indicates the site to delete.

```yaml
Type: Web
Parameter Sets: ClientObject
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Identity
Indicates the site GUID.

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
Indicates the site URL.

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

## INPUTS

### None or Microsoft.SharePoint.Client.Web

## OUTPUTS

### None

## NOTES

## RELATED LINKS

[https://github.com/karamem0/SPClient/blob/master/doc/Remove-SPClientWeb.md](https://github.com/karamem0/SPClient/blob/master/doc/Remove-SPClientWeb.md)


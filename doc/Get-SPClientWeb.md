# Get-SPClientWeb

## SYNOPSIS
Gets one or more webs.

## SYNTAX

### All (Default)
```
Get-SPClientWeb [-ClientContext <ClientContext>] [-Retrievals <String>]
```

### Root
```
Get-SPClientWeb [-ClientContext <ClientContext>] [-Root] [-Retrievals <String>]
```

### Default
```
Get-SPClientWeb [-ClientContext <ClientContext>] [-Default] [-Retrievals <String>]
```

### Url
```
Get-SPClientWeb [-ClientContext <ClientContext>] -Url <String> [-Retrievals <String>]
```

### Identity
```
Get-SPClientWeb [-ClientContext <ClientContext>] -Identity <Guid> [-Retrievals <String>]
```

## DESCRIPTION
The Get-SPClientWeb function lists all webs or retrieve the specified web.
If not specified filterable parameter, returns default web and its
descendants.
Otherwise, returns a web which matches the parameter.

## EXAMPLES

### -------------------------- Example 1 --------------------------
```
Get-SPClientWeb
```

### -------------------------- Example 2 --------------------------
```
Get-SPClientWeb -Identity "B7FB9B8D-A815-496F-B16B-CC1B26CCAC33"
```

### -------------------------- Example 3 --------------------------
```
Get-SPClientWeb -Url "/CustomWeb"
```

### -------------------------- Example 4 --------------------------
```
Get-SPClientWeb -Default
```

### -------------------------- Example 5 --------------------------
```
Get-SPClientWeb -Root
```

### -------------------------- Example 6 --------------------------
```
Get-SPClientWeb -Retrievals "Title"
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

### -Identity
Indicates the web GUID.

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
Indicates the web URL.

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

### -Default
If specified, returns default web of the client context.

```yaml
Type: SwitchParameter
Parameter Sets: Default
Aliases: 

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Root
If specified, returns root web.

```yaml
Type: SwitchParameter
Parameter Sets: Root
Aliases: 

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Retrievals
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

### None

## OUTPUTS

### Microsoft.SharePoint.Client.Web[]

## NOTES

## RELATED LINKS

[https://github.com/karamem0/SPClient/blob/master/doc/Get-SPClientWeb.md](https://github.com/karamem0/SPClient/blob/master/doc/Get-SPClientWeb.md)


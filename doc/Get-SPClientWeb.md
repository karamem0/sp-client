# Get-SPClientWeb

## SYNOPSIS
Gets one or more sites.

## SYNTAX

### All (Default)
```
Get-SPClientWeb [-ClientContext <ClientContext>] [-ParentObject] <SPClientWebParentPipeBind> [-NoEnumerate]
 [-Retrieval <String>]
```

### Identity
```
Get-SPClientWeb [-ClientContext <ClientContext>] -Identity <Guid> [-Retrieval <String>]
```

### Url
```
Get-SPClientWeb [-ClientContext <ClientContext>] -Url <String> [-Retrieval <String>]
```

### Default
```
Get-SPClientWeb [-ClientContext <ClientContext>] [-Default] [-Retrieval <String>]
```

### Root
```
Get-SPClientWeb [-ClientContext <ClientContext>] [-Root] [-Retrieval <String>]
```

### RecursiveAll
```
Get-SPClientWeb [-ClientContext <ClientContext>] [-RecursiveAll] [-Retrieval <String>]
```

## DESCRIPTION
The Get-SPClientWeb function lists all sites or retrieve the specified site.
If not specified filterable parameter, returns all subsites of the site.
Otherwise, returns a site which matches the parameter.

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
Get-SPClientWeb -Retrieval "Title"
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
Indicates the site which the subsites are contained.

```yaml
Type: SPClientWebParentPipeBind
Parameter Sets: All
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -NoEnumerate
If specified, suppresses enumeration in output.

```yaml
Type: SwitchParameter
Parameter Sets: All
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
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

### -Default
If specified, returns the default site of the client context.

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
If specified, returns the root site.

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

### -RecursiveAll
If specified, returns the default site and its descendants.

```yaml
Type: SwitchParameter
Parameter Sets: RecursiveAll
Aliases: 

Required: True
Position: Named
Default value: False
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

### None or SPClient.SPClientWebParentPipeBind

## OUTPUTS

### Microsoft.SharePoint.Client.Web[]

## NOTES

## RELATED LINKS

[https://github.com/karamem0/SPClient/blob/master/doc/Get-SPClientWeb.md](https://github.com/karamem0/SPClient/blob/master/doc/Get-SPClientWeb.md)


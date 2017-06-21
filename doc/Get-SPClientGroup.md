# Get-SPClientGroup

## SYNOPSIS
Gets one or more groups.

## SYNTAX

### All (Default)
```
Get-SPClientGroup [-ClientContext <ClientContext>] [-Retrievals <String>]
```

### Name
```
Get-SPClientGroup [-ClientContext <ClientContext>] -Name <String> [-Retrievals <String>]
```

### Identity
```
Get-SPClientGroup [-ClientContext <ClientContext>] -Identity <Int32> [-Retrievals <String>]
```

## DESCRIPTION
The Get-SPClientGroup function lists all site groups or retrieves the
specified site group.
If not specified filterable parameter, returns site all
groups.
Otherwise, returns a group which matches the parameter.

## EXAMPLES

### -------------------------- Example 1 --------------------------
```
Get-SPClientGroup
```

### -------------------------- Example 2 --------------------------
```
Get-SPClientGroup -Identity 7
```

### -------------------------- Example 3 --------------------------
```
Get-SPClientGroup -Name "Custom Group"
```

### -------------------------- Example 4 --------------------------
```
Get-SPClientGroup -Retrievals "Title"
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

### Microsoft.SharePoint.Client.GroupCollection Microsoft.SharePoint.Client.Group

## NOTES

## RELATED LINKS

[https://github.com/karamem0/SPClient/blob/master/doc/Get-SPClientGroup.md](https://github.com/karamem0/SPClient/blob/master/doc/Get-SPClientGroup.md)


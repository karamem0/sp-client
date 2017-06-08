# New-SPClientGroup

## SYNOPSIS
Creates a new group.

## SYNTAX

```
New-SPClientGroup [[-ClientContext] <ClientContext>] [-Name] <String> [[-Description] <String>]
 [[-Owner] <Principal>] [[-Users] <User[]>] [[-Retrievals] <String>]
```

## DESCRIPTION
The New-SPClientGroup function adds a new group to the site.

## EXAMPLES

### -------------------------- Example 1 --------------------------
```
New-SPClientGroup -Name "Custom Group"
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
Position: 1
Default value: $SPClient.ClientContext
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Indicates the group name.

```yaml
Type: String
Parameter Sets: (All)
Aliases: Title

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Description
Indicates the description.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Owner
Indicates the owner.

```yaml
Type: Principal
Parameter Sets: (All)
Aliases: 

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Users
Indicates the collection of users to add to group.

```yaml
Type: User[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 5
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
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS


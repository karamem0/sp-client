# Get-SPClientUser

## SYNOPSIS
Gets one or more users.

## SYNTAX

### All (Default)
```
Get-SPClientUser [-ClientContext <ClientContext>] [-Retrievals <String>]
```

### Current
```
Get-SPClientUser [-ClientContext <ClientContext>] [-Current] [-Retrievals <String>]
```

### Email
```
Get-SPClientUser [-ClientContext <ClientContext>] -Email <String> [-Retrievals <String>]
```

### Name
```
Get-SPClientUser [-ClientContext <ClientContext>] -Name <String> [-Retrievals <String>]
```

### Identity
```
Get-SPClientUser [-ClientContext <ClientContext>] -Identity <Int32> [-Retrievals <String>]
```

## DESCRIPTION
The Get-SPClientUser function lists all site users or retrieves the specified
site user.
If not specified filterable parameter, returns site all users.
Otherwise, returns a user which matches the parameter.

## EXAMPLES

### -------------------------- Example 1 --------------------------
```
Get-SPClientUser
```

### -------------------------- Example 2 --------------------------
```
Get-SPClientUser -Identity 7
```

### -------------------------- Example 3 --------------------------
```
Get-SPClientUser -Name "i:0#.f|membership|john@example.com"
```

### -------------------------- Example 4 --------------------------
```
Get-SPClientUser -Email "john@example.com"
```

### -------------------------- Example 5 --------------------------
```
Get-SPClientUser -Retrievals "Title"
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
Indicates the user ID.

```yaml
Type: Int32
Parameter Sets: Identity
Aliases: 

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Indicates the user login name.

```yaml
Type: String
Parameter Sets: Name
Aliases: LoginName

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Email
Indicates the user E-mail.

```yaml
Type: String
Parameter Sets: Email
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Current
If specified, returns current user.

```yaml
Type: SwitchParameter
Parameter Sets: Current
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

## OUTPUTS

## NOTES

## RELATED LINKS


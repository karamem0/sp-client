# Get-SPClientWebTemplate

## SYNOPSIS
Gets one or more site templates.

## SYNTAX

### All (Default)
```
Get-SPClientWebTemplate [-ClientContext <ClientContext>] [-Locale <String>] [-NoEnumerate] [-Name <String>]
 [-Retrieval <String>]
```

### Available
```
Get-SPClientWebTemplate [-ClientContext <ClientContext>] [-Locale <String>] [-NoEnumerate] [-Web <Web>]
 [-IncludeCrossLanguage] [-Name <String>] [-Retrieval <String>]
```

## DESCRIPTION
The Get-SPClientWebTemplate function lists all site templates or retrieves the specified site template.
If not specified filterable parameter, returns all site templates of the site collection.
Otherwise, returns a site template which matches the parameter.

## EXAMPLES

### -------------------------- Example 1 --------------------------
```
Get-SPClientWebTemplate
```

### -------------------------- Example 2 --------------------------
```
Get-SPClientWebTemplate -Locale 1033 -Web $Web -IncludeCrossLanguage
```

### -------------------------- Example 3 --------------------------
```
Get-SPClientWebTemplate -Name "STS#0"
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

### -Locale
Indicates the locale ID in which the site templates is used.
If not specified, uses the current thread locale.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: [System.Threading.Thread]::CurrentThread.CurrentCulture.LCID
Accept pipeline input: False
Accept wildcard characters: False
```

### -NoEnumerate
If specified, suppresses enumeration in output.

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

### -Web
Indicates the site to which the site templates are available.

```yaml
Type: Web
Parameter Sets: Available
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludeCrossLanguage
If specified, includes language-neutral site templates.

```yaml
Type: SwitchParameter
Parameter Sets: Available
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Indicates the site template name.

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

### None

## OUTPUTS

### Microsoft.SharePoint.Client.WebTemplate[]

## NOTES

## RELATED LINKS

[https://github.com/karamem0/SPClient/blob/master/doc/Get-SPClientWebTemplate.md](https://github.com/karamem0/SPClient/blob/master/doc/Get-SPClientWebTemplate.md)


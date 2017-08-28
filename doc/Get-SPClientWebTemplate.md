# Get-SPClientWebTemplate

## SYNOPSIS
Gets one or more site templates.

## SYNTAX

### All (Default)
```
Get-SPClientWebTemplate [-ClientContext <ClientContext>] [[-ParentObject] <SPClientWebTemplateParentPipeBind>]
 [-Locale <String>] [-NoEnumerate]
```

### Name
```
Get-SPClientWebTemplate [-ClientContext <ClientContext>] [[-ParentObject] <SPClientWebTemplateParentPipeBind>]
 [-Locale <String>] [-Name <String>]
```

## DESCRIPTION
The Get-SPClientWebTemplate function lists all site templates or retrieves the specified site template.
If not specified filterable parameter, returns all site templates of the site collection or site.
Otherwise, returns a site template which matches the parameter.

## EXAMPLES

### -------------------------- Example 1 --------------------------
```
Get-SPClientWebTemplate
```

### -------------------------- Example 2 --------------------------
```
Get-SPClientWebTemplate $web -Locale 1033
```

### -------------------------- Example 3 --------------------------
```
Get-SPClientWebTemplate -Name "STS#0"
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

### -ParentObject
Indicates the site collection or site to which the site templates are contained.

```yaml
Type: SPClientWebTemplateParentPipeBind
Parameter Sets: (All)
Aliases: 

Required: False
Position: 1
Default value: $ClientContext.Site
Accept pipeline input: True (ByValue)
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
Parameter Sets: All
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
Parameter Sets: Name
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### None or SPClient.SPClientWebTemplateParentPipeBind

## OUTPUTS

### Microsoft.SharePoint.Client.WebTemplate[]

## NOTES

## RELATED LINKS

[https://github.com/karamem0/SPClient/blob/master/doc/Get-SPClientWebTemplate.md](https://github.com/karamem0/SPClient/blob/master/doc/Get-SPClientWebTemplate.md)


# Get-SPClientFeature

## SYNOPSIS
Gets one or more activated features.

## SYNTAX

### All (Default)
```
Get-SPClientFeature [-ClientContext <ClientContext>] [[-ParentObject] <SPClientFeatureParentPipeBind>]
 [-NoEnumerate] [-Retrieval <String>]
```

### Identity
```
Get-SPClientFeature [-ClientContext <ClientContext>] [[-ParentObject] <SPClientFeatureParentPipeBind>]
 [-Identity <String>] [-Retrieval <String>]
```

## DESCRIPTION
The Get-SPClientFeature function lists all features or retrieves the specified feature.
If not specified filterable parameter, returns all features of the site collection or site.
Otherwise, returns a feature which matches the parameter.

## EXAMPLES

### -------------------------- Example 1 --------------------------
```
Get-SPClientFeature
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
Indicates the site collection or site to which the features are contained.

```yaml
Type: SPClientFeatureParentPipeBind
Parameter Sets: (All)
Aliases: 

Required: False
Position: 1
Default value: $ClientContext.Site
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
Indicates the feature GUID.

```yaml
Type: String
Parameter Sets: Identity
Aliases: Id

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

### None or SPClient.SPClientFeatureParentPipeBind

## OUTPUTS

### Microsoft.SharePoint.Client.Feature[]

## NOTES

## RELATED LINKS

[https://github.com/karamem0/SPClient/blob/master/doc/Get-SPClientFeature.md](https://github.com/karamem0/SPClient/blob/master/doc/Get-SPClientFeature.md)


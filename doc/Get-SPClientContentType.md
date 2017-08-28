# Get-SPClientContentType

## SYNOPSIS
Gets one or more content types.

## SYNTAX

### All (Default)
```
Get-SPClientContentType [-ClientContext <ClientContext>] [-ParentObject] <SPClientContentTypeParentPipeBind>
 [-NoEnumerate] [-Retrieval <String>]
```

### Identity
```
Get-SPClientContentType [-ClientContext <ClientContext>] [-ParentObject] <SPClientContentTypeParentPipeBind>
 -Identity <String> [-Retrieval <String>]
```

### Name
```
Get-SPClientContentType [-ClientContext <ClientContext>] [-ParentObject] <SPClientContentTypeParentPipeBind>
 -Name <String> [-Retrieval <String>]
```

## DESCRIPTION
The Get-SPClientContentType function lists all content types or retrieves the specified content type.
If not specified filterable parameter, returns all content types of the site or list.
Otherwise, returns a content type which matches the parameter.

## EXAMPLES

### -------------------------- Example 1 --------------------------
```
Get-SPClientContentType $web
```

### -------------------------- Example 2 --------------------------
```
Get-SPClientContentType $web -Identity "0X01009BD26CA6BE114008A9D56E68022DD1A7"
```

### -------------------------- Example 3 --------------------------
```
Get-SPClientContentType $web -Name "Custom Content Type"
```

### -------------------------- Example 4 --------------------------
```
Get-SPClientContentType $web -Retrieval "Title"
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
Indicates the site or list which the content types are contained.

```yaml
Type: SPClientContentTypeParentPipeBind
Parameter Sets: (All)
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
Indicates the content type ID.

```yaml
Type: String
Parameter Sets: Identity
Aliases: Id

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Indicates the content type name.

```yaml
Type: String
Parameter Sets: Name
Aliases: 

Required: True
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

### None or SPClient.SPClientContentTypeParentPipeBind

## OUTPUTS

### Microsoft.SharePoint.Client.ContentType[]

## NOTES

## RELATED LINKS

[https://github.com/karamem0/SPClient/blob/master/doc/Get-SPClientContentType.md](https://github.com/karamem0/SPClient/blob/master/doc/Get-SPClientContentType.md)


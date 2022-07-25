---
external help file: PsSysPassAPI-help.xml
Module Name: PsSysPassAPI
online version:
schema: 2.0.0
---

# Find-SysPassAccount

## SYNOPSIS
Search for SysPass Accounts

## SYNTAX

```
Find-SysPassAccount [[-AuthToken] <PSCredential>] [[-Text] <String>] [[-Count] <Int32>] [[-Category] <String>]
 [[-Client] <String>] [[-Tag] <String[]>] [[-Operator] <Object>] [<CommonParameters>]
```

## DESCRIPTION
Search for SysPass Accounts

## EXAMPLES

### EXAMPLE 1
```
Find-SysPassAccount -Text "use"
```

User1
User2
User3
PurpleUser
Fuse
...

## PARAMETERS

### -AuthToken
Credential object containing the API token and token password to use for this request.
If not specified, this cmdlet will look for the value set by Connect-SysPass.

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Text
The Text to search for.
If null or empty, then all accounts will be returned

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Count
The number of results to display

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Category
Category name to filter on.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Client
Client name to filter on

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Tag
Tag names to filter on

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Operator
Operator for filtering.
Defaults to 'or'

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: Or
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

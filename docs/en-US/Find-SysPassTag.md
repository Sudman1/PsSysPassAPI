---
external help file: PsSysPassAPI-help.xml
Module Name: PsSysPassAPI
online version:
schema: 2.0.0
---

# Find-SysPassTag

## SYNOPSIS
Search for SysPass Accounts

## SYNTAX

```
Find-SysPassTag [[-AuthToken] <PSCredential>] [[-Regex] <String>] [[-Count] <Int32>] [<CommonParameters>]
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

### -Regex
The regex text to search for.
If null or empty, then all accounts will be returned

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: .*
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
Default value: 2147483647
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

---
external help file: PsSysPassAPI-help.xml
Module Name: PsSysPassAPI
online version:
schema: 2.0.0
---

# Connect-SysPass

## SYNOPSIS
Initiates connection details for executing commands against the specified SysPassServer.

## SYNTAX

```
Connect-SysPass [-URI] <String> [-Token] <PSCredential> [<CommonParameters>]
```

## DESCRIPTION
Initiates connection details for executing commands against the specified SysPassServer.
Requires a URI to the
syspass server and a credential object representing the authentication token and token password.

## EXAMPLES

### EXAMPLE 1
```
Connect-SysPass -URI "https://10.0.0.105:8443/syspass" -Token (Get-Credential "aaaabbbbccccddddeeeeffff")
```

## PARAMETERS

### -URI
URI of syspass web site (eg: https://syspass.local.domain/syspass)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Token
Token id and password

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
NONE

## RELATED LINKS

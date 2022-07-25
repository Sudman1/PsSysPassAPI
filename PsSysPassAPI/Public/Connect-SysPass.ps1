<#
.SYNOPSIS
    Initiates connection details for executing commands against the specified SysPassServer.
.DESCRIPTION
    Initiates connection details for executing commands against the specified SysPassServer. Requires a URI to the
    syspass server and a credential object representing the authentication token and token password.
.NOTES
    NONE
.EXAMPLE
    Connect-SysPass -URI "https://10.0.0.105:8443/syspass" -Token (Get-Credential "aaaabbbbccccddddeeeeffff")
#>
function Connect-SysPass {
    [CmdletBinding()]
    param (
        # URI of syspass web site (eg: https://syspass.local.domain/syspass)
        [Parameter(Mandatory)]
        [string] $URI,

        # Token id and password
        [Parameter(Mandatory)]
        [pscredential] $Token
    )

    begin {

    }

    process {
        $global:__SysPassGlobal = @{
            uri = $URI
            token = $Token
        }
    }

    end {

    }
}

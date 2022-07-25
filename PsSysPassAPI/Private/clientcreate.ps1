<#
.SYNOPSIS
    Create client
.DESCRIPTION
    Create client
.NOTES
    Private function
.EXAMPLE

#>
function clientcreate {
    [CmdletBinding()]
    param (
        # User's API token
        [Parameter()]
        [string] $authToken,

        # Client's name
        [Parameter(Mandatory)]
        [string] $name,

        # Client's description
        [Parameter()]
        [string] $description,

        # Set client as global. It can be either 0 or 1
        [Parameter()]
        [int] $global
    )

    begin {

    }

    process {
        if (-not $authToken) {
            $PSBoundParameters["authToken"] = $global:__SysPassGlobal.Token.UserName
        }

        $payload = New-JsonRpcPayload -method "client/create" -params $PSBoundParameters

        $response = Invoke-RestMethod -URI "$($global:__SysPassGlobal.uri)/api.php" -Body $payload -Method POST -ContentType "application/json"
        if ($response.result.resultCode -eq 0) {
            $response.result.result | Select-Object ...
        }
    }

    end {

    }
}


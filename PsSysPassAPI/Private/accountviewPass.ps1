<#
.SYNOPSIS
    Get account's password
.DESCRIPTION
    Get account's password
.NOTES
    Private function
.EXAMPLE

#>
function accountviewPass {
    [CmdletBinding()]
    param (
        # User's API token
        [Parameter()]
        [string] $authToken,

        # API token's pass
        [Parameter(Mandatory)]
        [string] $tokenPass,

        # Account's Id
        [Parameter(Mandatory)]
        [int] $id,

        # Whether to return account's details within response
        [Parameter()]
        [int] $details
    )

    begin {

    }

    process {
        if (-not $authToken) {
            $PSBoundParameters["authToken"] = $global:__SysPassGlobal.Token.UserName
        }

        $payload = New-JsonRpcPayload -method "account/viewPass" -params $PSBoundParameters

        $response = Invoke-RestMethod -URI "$($global:__SysPassGlobal.uri)/api.php" -Body $payload -Method POST -ContentType "application/json"
        if ($response.result.resultCode -eq 0) {
            $response.result.result | Select-Object ...
        }
    }

    end {

    }
}


﻿<#
.SYNOPSIS
    Delete user group
.DESCRIPTION
    Delete user group
.NOTES
    Private function
.EXAMPLE

#>
function userGroupdelete {
    [CmdletBinding()]
    param (
        # User's API token
        [Parameter()]
        [string] $authToken,

        # User group's Id
        [Parameter(Mandatory)]
        [int] $id
    )

    begin {

    }

    process {
        if (-not $authToken) {
            $PSBoundParameters["authToken"] = $global:__SysPassGlobal.Token.UserName
        }

        $payload = New-JsonRpcPayload -method "userGroup/delete" -params $PSBoundParameters

        $response = Invoke-RestMethod -URI "$($global:__SysPassGlobal.uri)/api.php" -Body $payload -Method POST -ContentType "application/json"
        if ($response.result.resultCode -eq 0) {
            $response.result.result | Select-Object ...
        }
    }

    end {

    }
}

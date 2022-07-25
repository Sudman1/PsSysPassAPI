<#
.SYNOPSIS
    Create user group
.DESCRIPTION
    Create user group
.NOTES
    Private function
.EXAMPLE

#>
function userGroupcreate {
    [CmdletBinding()]
    param (
        # User's API token
        [Parameter()]
        [string] $authToken,

        # User group's name
        [Parameter(Mandatory)]
        [string] $name,

        # User group's description
        [Parameter()]
        [string] $description,

        # User group's users Id
        [Parameter()]
        [array] $usersId
    )

    begin {

    }

    process {
        if (-not $authToken) {
            $PSBoundParameters["authToken"] = $global:__SysPassGlobal.Token.UserName
        }

        $payload = New-JsonRpcPayload -method "userGroup/create" -params $PSBoundParameters

        $response = Invoke-RestMethod -URI "$($global:__SysPassGlobal.uri)/api.php" -Body $payload -Method POST -ContentType "application/json"
        if ($response.result.resultCode -eq 0) {
            $response.result.result | Select-Object ...
        }
    }

    end {

    }
}


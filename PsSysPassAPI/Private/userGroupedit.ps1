﻿<#
.SYNOPSIS
    Edit user group
.DESCRIPTION
    Edit user group
.NOTES
    Private function
.EXAMPLE

#>
function userGroupedit {
    [CmdletBinding(DefaultParameterSetName="ImplicitAuth")]
    param (
        # User's API token
        [Parameter(Mandatory, ParameterSetName="ExplicitAuth")]
        [string] $authToken,

        # User group's Id
        [Parameter(Mandatory)]
        [int] $id,

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

        $commonParameters = "Debug,WarningAction,ErrorVariable,InformationVariable,OutBuffer,Verbose,ErrorAction,InformationAction,WarningVariable,OutVariable,PipelineVariable" -split ","

        foreach ($commonParameter in $commonParameters) {
            if ($PSBoundParameters.ContainsKey($commonParameter)) {
                $PSBoundParameters.Remove($commonParameter)
            }
        }

        if ($PSCmdlet.ParameterSetName -eq "ImplicitAuth") {
            $PSBoundParameters["authToken"] = $global:__SysPassGlobal.Token.UserName
        }

        $payload = New-JsonRpcPayload -method "userGroup/edit" -params $PSBoundParameters

        Write-Debug "Payload:`n$payload"

        $response = Invoke-RestMethod -URI "$($global:__SysPassGlobal.uri)/api.php" -Body $payload -Method POST -ContentType "application/json"

        Write-Debug "Response:`n$($response | ConvertTo-Json)"

        if ($response.result.resultCode -eq 0) {
            $response.result.result
        } else {
            $response.error
        }
    }

    end {

    }
}


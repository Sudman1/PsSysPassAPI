<#
    API Documentation source can be found at https://raw.githubusercontent.com/sysPass/sysPass-doc/3.1/docs/source/application/api.rst
#>

$content = (Invoke-WebRequest https://raw.githubusercontent.com/sysPass/sysPass-doc/3.1/docs/source/application/api.rst).Content

$blocks = [regex]::Matches($content, "(\w+/\w+\n):+\n\n(.*?\n).*?=\n(.*?)[= ]+\n(.*?)\n=", "SingleLine")
$blocks -join "`n`n------------------------------------------------------------------------------------------`n`n"

$defs = @{}
$blocks | ForEach-Object {
    $endpoint = $_.groups[1].value.trim()
    $defs[$endpoint] = @{
        description = $_.groups[2].value.trim()
        params      = $_.groups[4].value.trim() -replace "  +", "`t" | ConvertFrom-Csv -Delimiter "`t" -Header ($_.groups[3].value.trim() -split "  +")
    }
}

$parameterTemplate = @'
        # {0}
        [Parameter({1})]
        [{3}] ${2}
'@

$functionTemplate = @'
<#
.SYNOPSIS
    {0}
.DESCRIPTION
    {0}
.NOTES
    Private function
.EXAMPLE

#>
function {1} {{
    [CmdletBinding(DefaultParameterSetName="ImplicitAuth")]
    param (
{2}
    )

    begin {{

    }}

    process {{

        $commonParameters = "Debug,WarningAction,ErrorVariable,InformationVariable,OutBuffer,Verbose,ErrorAction,InformationAction,WarningVariable,OutVariable,PipelineVariable" -split ","

        foreach ($commonParameter in $commonParameters) {{
            if ($PSBoundParameters.ContainsKey($commonParameter)) {{
                $PSBoundParameters.Remove($commonParameter)
            }}
        }}

        if ($PSCmdlet.ParameterSetName -eq "ImplicitAuth") {{
            $PSBoundParameters["authToken"] = $global:__SysPassGlobal.Token.UserName
        }}

        $payload = New-JsonRpcPayload -method "{3}" -params $PSBoundParameters

        Write-Debug "Payload:`n$payload"

        $response = Invoke-RestMethod -URI "$($global:__SysPassGlobal.uri)/api.php" -Body $payload -Method POST -ContentType "application/json"

        Write-Debug "Response:`n$($response | ConvertTo-Json)"

        if ($response.result.resultCode -eq 0) {{
            $response.result.result
        }} else {{
            $response.error
        }}
    }}

    end {{

    }}
}}

'@

foreach ($endpoint in $defs.keys) {
    $params = ($defs[$endpoint].params | ForEach-Object {
        if ($_.required -eq "yes" -and $_.parameter -notlike "*token*") {
            $paramArgs = "Mandatory"
        } elseif ($_.parameter -like "*token*") {
            $paramArgs = 'ParameterSetName="ExplicitAuth"'
        } else {
            $paramArgs = ""
        }
        $parameterTemplate -f $_.description, $paramArgs, $_.parameter, $_.type
    }) -join ",`n`n"

    $functionName = $endpoint.replace("/","")
    $functionContent = $functionTemplate -f $defs[$endpoint].description, $functionName, $params, $endpoint

    Set-Content -Path .\PsSysPassAPI\Private\$functionName.ps1 -Value $functionContent -Encoding UTF8
}

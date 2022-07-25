<#
    API Documentation source can be found at https://raw.githubusercontent.com/sysPass/sysPass-doc/3.1/docs/source/application/api.rst
#>

$content = (Invoke-WebRequest https://raw.githubusercontent.com/sysPass/sysPass-doc/3.1/docs/source/application/api.rst).Content

$lines = $content -split "`r*`n"

$endpointIndicators = $lines | Where-Object {$_ -match "^:"}


$blocks = [regex]::Matches($content,"\n(\w+/\w+)\n:+\n\n(.*?\n).*?=\n(.*?)\n?=\n\n","Singleline")
$blocks -join "`n`n------------------------------------------------------------------------------------------`n`n"

$defs = @{}
$blocks | foreach {
    $endpoint = $_.groups[1].value
    $defs[$endpoint] = @{
        description = $_.groups[2].value.trim()
        params = ($_.groups[3].value -replace "=+\s+=+\s+\=+\s+\=+(\n)*","" -replace "  +", "`t") | ConvertFrom-Csv -Delimiter "`t"
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
    [CmdletBinding()]
    param (
{2}
    )

    begin {{

    }}

    process {{
        if (-not $authToken) {{
            $PSBoundParameters["authToken"] = $global:__SysPassGlobal.Token.UserName
        }}

        $payload = New-JsonRpcPayload -method "{3}" -params $PSBoundParameters

        $response = Invoke-RestMethod -URI "$($global:__SysPassGlobal.uri)/api.php" -Body $payload -Method POST -ContentType "application/json"
        if ($response.result.resultCode -eq 0) {{
            $response.result.result | Select-Object ...
        }}
    }}

    end {{

    }}
}}

'@

foreach ($endpoint in $defs.keys) {
    $params = ($defs[$endpoint].params | foreach {
        if ($_.required -eq "yes" -and $_.parameter -notlike "auth*") {
            $mandatory = "Mandatory"
        } else {
            $mandatory = ""
        }
        $parameterTemplate -f $_.description, $mandatory, $_.parameter, $_.type
    }) -join ",`n`n"

    $functionName = $endpoint.replace("/","")
    $functionContent = $functionTemplate -f $defs[$endpoint].description, $functionName, $params, $endpoint

    Set-Content -Path .\PsSysPassAPI\Private\$functionName.ps1 -Value $functionContent -Encoding UTF8
}

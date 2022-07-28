<#
.SYNOPSIS
    Retrieve the password for a specific SysPass Account
.DESCRIPTION
    Retrieve the password for a specific SysPass Account based on its Id
.NOTES

.EXAMPLE
    Get-SyspasAccountPassword -Id 4

    a*b$c&76d3f@!
.EXAMPLE
    Find-SysPassAccount -Text "user" | Get-SyspasAccountPassword

    a*b$c&76d3f@!
#>
function Get-SysPassAccountPassword {
    [CmdletBinding()]
    param (
        # The regex text to search for. If null or empty, then all accounts will be returned
        [Parameter(
            Mandatory,
            Position = 0,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true
        )]
        [alias("AccountId")]
        [int] $Id,

        # Credential object containing the API token and token password to use for this request. If not specified, this cmdlet will look for the value set by Connect-SysPass.
        [pscredential] $AuthToken
    )

    begin {

    }

    process {
        $params = @{
            id = $Id
        }

        if ($PSBoundParameters.ContainsKey("AuthToken")) {
            $params["authToken"] = $AuthToken.UserName
            $params["tokenPass"] = $AuthToken.GetNetworkCredential().Password
        }

        (accountviewPass @params).Password
    }

    end {

    }
}

<#
.SYNOPSIS
    Search for SysPass Tags
.DESCRIPTION
    Search for SysPass Tags
.NOTES

.EXAMPLE
    Find-SysPassTag

    id name
    -- ----
    1 Active Directory
    3 Automation
    2 Events
.EXAMPLE
    Find-SysPassTag -Regex "^auto"

    id name
    -- ----
    3 Automation
#>
function Find-SysPassTag {
    [CmdletBinding()]
    param (
        # Credential object containing the API token and token password to use for this request. If not specified, this cmdlet will look for the value set by Connect-SysPass.
        [pscredential] $AuthToken,

        # The regex text to search for. If null or empty, then all accounts will be returned
        [string] $Regex = ".*",

        # The number of results to display
        [int] $Count = [int]::MaxValue
    )

    begin {

    }

    process {
        $params = @{}

        if ($PSBoundParameters.ContainsKey("AuthToken")) {
            $params["authToken"] = $AuthToken.UserName
        }

        tagsearch @params | Where-Object {$_.name -match $Regex} | Select-Object -First $Count
    }

    end {

    }
}

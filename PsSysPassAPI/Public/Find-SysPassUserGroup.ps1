<#
.SYNOPSIS
    Search for SysPass User Groups
.DESCRIPTION
    Search for SysPass User Groups
.NOTES

.EXAMPLE
    Find-SysPassUserGroup

    id name   description    users
    -- ----   -----------    -----
    1 Admins sysPass Admins
    2 CSSD
.EXAMPLE
    Find-SysPassUserGroup -Regex "CSSD"

    id name   description    users
    -- ----   -----------    -----
    2 CSSD
#>
function Find-SysPassUserGroup {
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

        usergroupsearch @params | Where-Object {$_.name -match $Regex} | Select-Object -First $Count
    }

    end {

    }
}

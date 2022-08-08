# Taken with love from @juneb_get_help (https://raw.githubusercontent.com/juneb/PesterTDD/master/Module.Help.Tests.ps1)

$outputDir = Join-Path -Path $ENV:BHProjectPath -ChildPath 'Output'
$outputModDir = Join-Path -Path $outputDir -ChildPath $env:BHProjectName
$manifest = Import-PowerShellDataFile -Path $env:BHPSModuleManifest
$outputModVerDir = Join-Path -Path $outputModDir -ChildPath $manifest.ModuleVersion

# Get module commands
# Remove all versions of the module from the session. Pester can't handle multiple versions.
Get-Module $env:BHProjectName | Remove-Module -Force
Import-Module -Name (Join-Path -Path $outputModVerDir -ChildPath "$($env:BHProjectName).psd1") -Verbose:$false -ErrorAction Stop


Describe "Functionality Tests" {
    It "Stores connection information." {
        Connect-SysPass -URI "https://syspass.eastus2.cloudapp.azure.com/" -Token ([pscredential]::new("e20efab40cb769d7069ff9f4a1cbc383d19591369bf6f84dc1e8d466c532f825", (ConvertTo-SecureString -Force -AsPlainText "1234")))
        $global:__SysPassGlobal.uri | Should -Be "https://syspass.eastus2.cloudapp.azure.com/"
        $global:__SysPassGlobal.token.username | Should -Be "e20efab40cb769d7069ff9f4a1cbc383d19591369bf6f84dc1e8d466c532f825"
        $global:__SysPassGlobal.token.GetNetworkCredential().Password | Should -Be "1234"
    }

    It "Finding test account details succeeds" {
        $account = Find-SysPassAccount -Regex '^test$' -Category "Test"
        $account.name | Should -Be "Test"
        $account.login | Should -Be "Test"
        $account.categoryName | Should -Be "Test"
    }

    It "Finding test account fails when a user does not have API Authorization" {
        $badToken = [pscredential]::new("c33d74e892eefff1a1558f7b49b92e20b20c07b2553aad26c14d8471c78b3087", (ConvertTo-SecureString -Force -AsPlainText "1234"))
        { Find-SysPassAccount -AuthToken $badToken -Regex '^test$' -Category Test } | Should -Throw
    }

    It "Finding test category information succeeds" {
        $category = Find-SysPassCategory -Regex '^test$'
        $category.name | Should -Be "Test"
    }

    It "Finding test client information succeeds" {
        $client = Find-SysPassClient -Regex '^test$'
        $client.name | Should -Be "Test"
    }


    It "Finding test tag information succeeds" {
        $tag = Find-SysPassTag -Regex '^test$'
        $tag.name | Should -Be "Test"
    }

    It "Finding test user group information succeeds" {
        $ug = Find-SysPassUserGroup -Regex '^test$'
        $ug.name | Should -Be "Test"
    }


    It "Pulling test account password succeeds" {
        $pass = Find-SysPassAccount -Regex '^test$' | Get-SysPassAccountPassword
        $pass | Should -Be "123456789"
    }
}

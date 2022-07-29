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
        Connect-SysPass -URI "http://10.187.110.104/syspass" -Token ([pscredential]::new("9cb6ce43a4bafcbd7c80bd2ae88ba7b2eaa745f4ee34c9adbdc3a0edf1015724", (ConvertTo-SecureString -Force -AsPlainText "123456")))
        $global:__SysPassGlobal.uri | Should -Be "http://10.187.110.104/syspass"
        $global:__SysPassGlobal.token.username | Should -Be "9cb6ce43a4bafcbd7c80bd2ae88ba7b2eaa745f4ee34c9adbdc3a0edf1015724"
        $global:__SysPassGlobal.token.GetNetworkCredential().Password | Should -Be "123456"
    }

    It "Finding test account details succeeds" {
        $account = Find-SysPassAccount -Regex '^test$' -Category "Test"
        $account.name | Should -Be "Test"
        $account.login | Should -Be "Test"
        $account.categoryName | Should -Be "Test"
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
        $pass = Get-SysPassAccountPassword -Regex '^test$'
        $pass.name | Should -Be "123456789"
    }
}

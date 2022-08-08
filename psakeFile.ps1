properties {
    # Disable "compiling" module into monolithinc PSM1.
    # This modifies the default behavior from the "Build" task
    # in the PowerShellBuild shared psake task module
    $PSBPreference.Build.CompileModule = $false
    $PSBPreference.Test.OutputFile = "$(Resolve-Path .)\output\Artifacts\TestResults.xml"
    $PSBPreference.Test.ScriptAnalysis.Enabled = $false
    $PSBPreference.Test.CodeCoverage.OutputFormat = "JaCoCo"
    $PSBPreference.Test.CodeCoverage.OutputFile = "$(Resolve-Path .)\output\Artifacts\codeCoverage.xml"
    $PSBPreference.Test.CodeCoverage.Enabled = $false
    $PSBPreference.Test.CodeCoverage.Threshold = 0
    $PSBPreference.Test.CodeCoverage.Files = "..\Output\*\*\P*\*.ps1"
}

task default -depends Test

task Test -FromModule PowerShellBuild -Version '0.5.0'

task Release {
    Unregister-PSRepository -Name Release -ErrorAction Ignore
    # Unregister-PSRepository -Name Domain -ErrorAction Ignore

    $outputPath = "$(Resolve-Path .)\Output"
    $releasePath = "$(Resolve-Path .)\Release"
    if (-not (Test-Path $releasePath)) {
        mkdir $releasePath
    }
    Register-PSRepository -Name Release -PublishLocation $releasePath -SourceLocation $releasePath -InstallationPolicy Trusted
    $ver = Get-ChildItem -Path $outputPath\PsSysPassAPI | Select-Object -ExpandProperty Name | Sort-Object @{expression={[version]$_}} -Descending | Select-Object -First 1
    Remove-Item "$releasePath\*.nupkg" -ErrorAction SilentlyContinue
    Publish-Module -Path $outputPath\PsSysPassAPI\$ver -Repository Release -Force
    Unregister-PSRepository -Name Release -ErrorAction Ignore

    Write-Output (Get-ChildItem $releasePath).Name
}

task PublishToTED {

    $outputPath = "$(Resolve-Path .)\Output"
    $releasePath = "http://nuget.usa.bices.ted/nuget"

    $repositoryName = "Publish"
    $isTempRepo = $true

    $installedRepos = Get-PSRepository
    if ($installedRepos.PublishLocation -contains $releasePath) {
        $repositoryName = (Get-PSRepository | Where-Object { $_.PublishLocation -eq $releasePath }).Name
        $isTempRepo = $false
    }

    if ($isTempRepo) {
        Unregister-PSRepository -Name $repositoryName -ErrorAction Ignore
        Register-PSRepository -Name $repositoryName -PublishLocation $releasePath -SourceLocation $releasePath -InstallationPolicy Trusted
    }

    $ver = Get-ChildItem -Path $outputPath\PsSysPassAPI | Select-Object -ExpandProperty Name | Sort-Object @{expression = { [version]$_ } } -Descending | Select-Object -First 1

    Publish-Module -Path $outputPath\PsSysPassAPI\$ver -Repository $repositoryName -Force -NuGetApiKey "NoPasswordNeeded"

    Find-Module -Name PsSysPassAPI -Repository $repositoryName

    if ($isTempRepo) {
        Unregister-PSRepository -Name $repositoryName -ErrorAction Ignore
    }
}

task ReInstall {
    Uninstall-Module PsSysPassAPI -ErrorAction SilentlyCOntinue
    $releasePath = "$(Resolve-Path .)\Release"
    Register-PSRepository -Name Release -PublishLocation $releasePath -SourceLocation $releasePath -InstallationPolicy Trusted -ErrorAction SilentlyContinue
    Install-Module PsSysPassAPI -Repository Release -Scope CurrentUser -Force
    Unregister-PSRepository -Name Release -ErrorAction SilentlyContinue
    if ((Test-Path c:\SCC\Windows)) {
        $modulePath = Split-Path -Path (get-module -ListAvailable PsSysPassAPI | select -First 1).Path -Parent
        Copy-Item -Path C:\SCC\Windows -Destination $modulePath\SCC -Recurse -Force
    }
}


#!/usr/bin/env pwsh

param (
    [string]$Version = "9.0",
    [ValidateSet("windows", "macos", "linux")]
    [string]$OS = $null
)

function Detect-Platform {
    if ($IsWindows) { return "windows" }
    elseif ($IsLinux) { return "linux" }
    elseif ($IsMacOS) { return "macos" }
    else {
        throw "❌ Unsupported operating system."
    }
}

function Is-DotNetInstalled {
    param([string]$Version)
    
    try {
        $installed = dotnet --list-sdks | ForEach-Object {
            ($_ -split '\s+')[0]
        } | Where-Object { $_ -like "$Version*" }

        return $installed.Count -gt 0
    }
    catch {
        return $false
    }
}

function Install-DotNet {
    param([string]$Version, [string]$Platform)

    Write-Host "📦 Installing .NET SDK $Version on $Platform..."

    $dotnetInstallScript = "https://dot.net/v1/dotnet-install.ps1"
    $tempScript = "./dotnet-install.ps1"

    Invoke-WebRequest -Uri $dotnetInstallScript -OutFile $tempScript -UseBasicParsing

    & pwsh $tempScript -Channel $Version -InstallDir "$HOME/.dotnet"

    $env:PATH = "$HOME/.dotnet:$HOME/.dotnet/tools:" + $env:PATH

    # Optionally make it permanent (macOS/Linux)
    if ($Platform -ne "windows") {
        $profileFile = "$HOME/.bashrc"
        if (Test-Path "$HOME/.zshrc") { $profileFile = "$HOME/.zshrc" }

        if ((Get-Content $profileFile) -notmatch '\.dotnet') {
            Add-Content $profileFile "`n# Add .NET to PATH"
            Add-Content $profileFile "export PATH=`$HOME/.dotnet:`$HOME/.dotnet/tools:`$PATH"
            Write-Host "✅ .NET path added to $profileFile"
        }
    }

    Remove-Item $tempScript

    Write-Host "✅ .NET SDK $Version installed."
}

try {
    if (-not $OS) {
        $OS = Detect-Platform
    }

    if (Is-DotNetInstalled -Version $Version) {
        Write-Host "✅ .NET SDK $Version is already installed."
    }
    else {
        Install-DotNet -Version $Version -Platform $OS
        dotnet --info
    }
}
catch {
    Write-Error "❌ Installation failed: $_"
    exit 1
}
#!/usr/bin/env pwsh

Write-Host "🔧 Checking for required .NET SDK version $DotNetVersion..."

$dotnetVersion = dotnet --version 2>$null

if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ .NET SDK not found!"
    $dotnetVersion = ""
}

if ($dotnetVersion -like "9.0.*") {
    Write-Host "✅ .NET SDK 9.0.x is already installed."
} else {
    Write-Host "❌ .NET SDK 9.0.x is not installed."
    exit 1
}

Write-Host "✅ Environment ready."
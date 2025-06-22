#!/usr/bin/env pwsh

param (
    [string]$Configuration = "Release"
)

Write-Host "🏗️ Building project ($Configuration)..."

./scripts/init.ps1
dotnet restore
dotnet build --configuration $Configuration

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Build succeeded."
} else {
    Write-Error "❌ Build failed."
    exit 1
}
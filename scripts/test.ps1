#!/usr/bin/env pwsh

param (
    [string]$Configuration = "Release"
)

Write-Host "🧪 Running tests..."

./scripts/init.ps1
./scripts/build.ps1 -Configuration $Configuration
dotnet test --no-build --configuration $Configuration --logger "trx"

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ All tests passed."
} else {
    Write-Error "❌ Some tests failed."
    exit 1
}
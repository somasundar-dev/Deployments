#!/usr/bin/env pwsh

Write-Host "🧹 Cleaning artifacts..."

Remove-Item ./bin, ./obj, ./publish, ./publish.zip -Recurse -Force -ErrorAction SilentlyContinue

Write-Host "✅ Cleanup done."
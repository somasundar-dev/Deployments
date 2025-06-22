#!/usr/bin/env pwsh

param (
    [string]$Configuration = "Release"
)

Write-Host "📦 Packing application..."

$publishDir = "./publish"
Remove-Item $publishDir -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "./Deployment_Demo_API.zip" -ErrorAction SilentlyContinue

dotnet publish "./src/Deployments.Demo.API/Deployment.Demo.API.csproj" --configuration $Configuration --output "$publishDir"

if ($LASTEXITCODE -ne 0) {
    Write-Error "❌ Publishing failed."
    exit 1
}

Compress-Archive -Path "$publishDir/*" -DestinationPath "./Deployment_Demo_API.zip"

if ($LASTEXITCODE -ne 0) {
    Write-Error "❌ Packing failed."
    exit 1
}
else {
    Write-Host "✅ Packing completed successfully."
    Remove-Item $publishDir -Recurse -Force -ErrorAction SilentlyContinue
    Write-Host "📦 Deployment package created: Deployment_Demo_API.zip"
}
#!/usr/bin/env pwsh

param (
    [string]$Bucket,
    [ValidateSet("Dev", "Staging", "Prod")]
    [string]$Env = "Dev",
    [string]$Region = "ap-south-1"
)

Write-Host "🚀 Deployment Started"
./scripts/pack.ps1 -Configuration "Release"
Write-Host "🚀 Deploying to S3 bucket: $Bucket"

aws s3 cp Deployment_Demo_API.zip "s3://$Bucket/artifacts/Deployment_Demo_API/$Env/Publish.zip" --region $Region

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Deployed to S3."
    Write-Host "📦 Deployment package uploaded to s3://$Bucket/artifacts/Deployment_Demo_API/$Env/Publish.zip"
    Remove-Item "./Deployment_Demo_API.zip" -ErrorAction SilentlyContinue
} else {
    Write-Error "❌ Deployment failed."
    exit 1
}
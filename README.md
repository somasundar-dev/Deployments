# 🛠️ .NET SDK Environment Setup Scripts

This repository provides cross-platform PowerShell scripts to automate the setup, build, test, packaging, deployment, and CI/CD tasks for .NET projects.

## 📦 Scripts Overview

| Script               | Purpose                                                                |
| -------------------- | ---------------------------------------------------------------------- |
| `install-dotnet.ps1` | Installs the specified .NET SDK version if not already installed       |
| `init.ps1`           | Validates development environment (e.g., checks .NET SDK availability) |
| `build.ps1`          | Builds the .NET project                                                |
| `test.ps1`           | Runs unit and integration tests                                        |
| `pack.ps1`           | Publishes and packages the project into a zip                          |
| `deploy.ps1`         | Deploys the zipped artifact to AWS S3                                  |
| `clean.ps1`          | Cleans build artifacts                                                 |

## 🚀 Quick Start

### Prerequisites

- [PowerShell Core (`pwsh`)](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell) installed
- (Optional) [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) configured

### 📥 Install .NET SDK

```sh
pwsh ./scripts/install-dotnet.ps1 -Version 9.0
```

### ⚙️ Initialize Environment

```sh
pwsh ./scripts/init.ps1
```

### 🏗️ Build Project

```sh
pwsh ./scripts/build.ps1 -Configuration Release
```

### 🧪 Run Tests

```sh
pwsh ./scripts/test.ps1 -Configuration Release
```

### 📦 Package

```sh
pwsh ./scripts/pack.ps1 -Configuration Release
```

### 🚀 Deploy to AWS S3

```sh
pwsh ./scripts/deploy.ps1 -Bucket "your-bucket-name" -Env "Dev" -Region "ap-south-1"
```

## 🧹 Cleanup

```sh
pwsh ./scripts/clean.ps1
```

---

## 🔒 Security Notes

- Always review downloaded PowerShell scripts before running.
- AWS credentials must be configured using `aws configure`.

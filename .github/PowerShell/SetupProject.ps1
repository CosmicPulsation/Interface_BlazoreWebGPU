
dotnet build ".\.github\Setup.csproj" --configuration Release --no-incremental --force

Write-Host $PSScriptRoot

$ExicutionPath = Resolve-Path -Path "$PSScriptRoot\..\bin\Release\*\PowerShell"

Write-Host "InvocationName: $ExicutionPath"

& "$ExicutionPath/SetupWorkflows.ps1"
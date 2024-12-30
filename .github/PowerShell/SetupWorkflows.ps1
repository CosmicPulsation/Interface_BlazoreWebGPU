function GitAuthensication
{
    param(
        [Parameter(Mandatory=$true)]
        [string]$accessToken
    )

    $authenticationToken = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes("$accessToken"))
    $headers = "Authorization: Basic $authenticationToken"

    git -c http.extraheader=$headers fetch --force --tags --prune --progress --no-recurse-submodules origin
}
if (-not ([string]::IsNullOrEmpty($env:ACCESS_TOKEN )))
{
    Write-Output "acces token is eamy"
}

Write-Output "test output"
$authenticationToken = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes("$env:ACCESS_TOKEN"))
$headers = "Authorization: Basic $authenticationToken"

Write-Output "test output"
$Env:MyVariable
$PSVersionTable


# Update pipline
$ExicutionPath = Resolve-Path "$PSScriptRoot\CompileWorkflows\copyWorkflow.psm1"
Import-Module $ExicutionPath -Force

CompileWorkfolw
return
git add .
git commit -m "Pipline Update" -a
git -c http.extraheader=$headers push

# Start buildpipline
$branchNumber = Get-Random -Minimum 10000 -Maximum 99999
$branchName = "temp/$branchNumber"
git switch --create $branchName
git merge upstream/master

git commit
git push --set-upstream origin $branchName

Write-Output "BranchName=$($branchName)" >> $Env:GITHUB_OUTPUT
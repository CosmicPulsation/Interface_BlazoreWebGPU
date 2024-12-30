function CompileWorkfolw
{
	$path = Resolve-Path -Path "$PSScriptRoot\..\..\Pipline" | Select-Object -ExpandProperty Path
	
	Write-Host "Resolved Path: $path"
	$pastPath = ".\.github\workflows"
	
	$workflows = Get-ChildItem -Path $path -Filter "*.yaml" –depth 10 | Select-Object -ExpandProperty Fullname
	
	Write-Host "Clear: $pastPath" -ForegroundColor Cyan
	Remove-Item -Path "$pastPath\*" -exclude "SetupMainPipline.yml"

	foreach ($workflow in  $workflows )
	{
		$relativePath = $workflow.Replace("$path", "")
		$relativePath = $relativePath -replace "[\\\\|\\/]", "."
		$relativePath = $relativePath -replace "^.", ""
		Write-Host "Copy documents:`r`n $workflow -> $pastPath\$relativePath" -ForegroundColor Cyan
		Copy-Item -Path $workflow -Destination "$pastPath\$relativePath"
	}
}
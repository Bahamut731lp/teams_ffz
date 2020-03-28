Write-Output "Teams FFZ update script"
Write-Output "======================="


$latestRelease = Invoke-WebRequest https://api.github.com/repos/bahamut731lp/teams_ffz/releases/latest -Headers @{"Accept"="application/json"}
$json = $latestRelease.Content | ConvertFrom-Json
$latestVersion = $json.zipball_url
$output =  "./release.zip"

Write-Output "URL: $latestVersion"
Write-Output "Output: $output"

Write-Output "Starting file download..."
Invoke-WebRequest -Uri $latestVersion -OutFile $output
Write-Output "File download complete!"

Write-Output "Extracting files..."
Expand-Archive -Path release.zip
Get-ChildItem -Path ".\release" -Recurse | %{Join-Path -Path $_.Directory -ChildPath $_.Name -erroraction 'silentlycontinue'} | Copy-Item -Destination ".\"
Write-Output "Files extracted!"


Write-Output "Cleaning up the mess..."
Remove-Item ".\release" -Force -Recurse
Remove-Item ".\release.zip" -Force
Write-Host "Update has been completed! Press any key to continue...";

$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
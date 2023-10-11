$folder = "$PSScriptRoot\themes"
$themes = Get-ChildItem $folder
$themes = $themes | ForEach-Object { $_.Name }
$themes = $themes | ForEach-Object { $_.Substring(0, $_.Length - 9) }
$themes = $themes | Sort-Object
#display the themes
foreach ($theme in $themes) {
    Write-Host $theme -ForegroundColor Green
}

#read the file : install_theme.ps1
$file = "$PSScriptRoot\actual_theme.ps1"
$theme = Get-Content $file
if ($theme -match "oh-my-posh init pwsh --config") {
    $theme = $theme -replace "oh-my-posh init pwsh --config ", ""
    $string = "$PSScriptRoot\themes\"
    $escapedString = [regex]::Escape($string) 
    $theme = $theme -replace $escapedString, ""
    $theme = $theme -replace ".omp.json | Invoke-Expression", ""
    $theme = $theme.Substring(0, $theme.Length - 1)
    Write-Host "Actual theme : $theme" -ForegroundColor Green
}
else {
    Write-Host "No theme installed" -ForegroundColor Green
}

#get the actual font
$utilisateur = $env:USERNAME
$programFiles = "C:\Program Files"
$terminalPath = Get-ChildItem -Path "$programFiles\WindowsApps" -Filter "Microsoft.WindowsTerminal*" -Directory | Select-Object -First 1
$cheminTerminal = $terminalPath.FullName
$cheminTerminal = $cheminTerminal.Split("_")[-1]
$Path = "C:\Users\$utilisateur\AppData\Local\Packages\Microsoft.WindowsTerminal_$cheminTerminal\LocalState\settings.json"


$file = Get-Content $Path -Raw | ConvertFrom-Json
$profiles = $file.profiles.defaults
if ($profiles.font) {
    $font = $profiles.font.face
    Write-Host "Actual font  : $font" -ForegroundColor Green
}
else {
    Write-Host "No font used" -ForegroundColor Green
}

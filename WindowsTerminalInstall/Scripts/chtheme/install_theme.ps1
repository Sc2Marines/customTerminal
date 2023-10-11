#get the arg wich is called with the script
$argument = $args[0].Split(" ")[0]

#test if the argument is empty
if ($argument -eq "") {
    Write-Host "You must specify a theme" -ForegroundColor Yellow
    return
}

#gzt int the folder themes the list of themes
$folder = "$PSScriptRoot\themes"
$themes = Get-ChildItem $folder
$themes = $themes | ForEach-Object { $_.Name }
$themes = $themes | ForEach-Object { $_.Substring(0, $_.Length - 9) }
$themes = $themes | Sort-Object

#check if the argument is in the list of themes
$theme_exist = $false
foreach ($theme in $themes) {
    if ($theme -eq $argument) {
        $theme_exist = $true
    }
}

if ($theme_exist) { # Vérifie si le thème existe
    #installe le thème
    Write-Host "Installing theme $argument" -ForegroundColor Green
    #ouvre le fichier actual_theme.ps1
    $file = "$PSScriptRoot\actual_theme.ps1" 

    $string = "oh-my-posh init pwsh --config $PSScriptRoot\themes\$argument.omp.json | Invoke-Expression" 

    #efface l'ancien thème (fichier)
    Remove-Item $file -Force -ErrorAction SilentlyContinue 

    #écrit le nouveau thème
    Set-Content $file $string

    #execute le nouveau thème
    . $file
    Write-Host "Theme $argument installed" -ForegroundColor Green
}
else {
    Write-Host "Theme $argument doesn't exist" -ForegroundColor Red
}


$argument = $args[0]
Write-Warning $argument
# Récupérer le nom d'utilisateur
$utilisateur = $env:USERNAME

# Récupérer le chemin du package Windows Terminal
$programFiles = [Environment]::GetFolderPath("ProgramFiles")
$terminalPath = Get-ChildItem -Path "$programFiles\WindowsApps" -Filter "Microsoft.WindowsTerminal*" -Directory | Select-Object -First 1
$cheminTerminal = $terminalPath.FullName
#split the last _ 
$cheminTerminal = $cheminTerminal.Split("_")[-1]

$Path = "C:\Users\$utilisateur\AppData\Local\Packages\Microsoft.WindowsTerminal_$cheminTerminal\LocalState\settings.json"

#ouvre le fichier
$file = Get-Content $Path -Raw | ConvertFrom-Json
#récupère "profiles" dans le fichier
$profiles = $file.profiles.defaults
#si la clé "font" existe
if ($profiles.font) {
    #affiche la police
    Write-Host $profiles.font.face -ForegroundColor Green
    #la change par l'argument
    $profiles.font.face = $argument
}
else {
    #crée la clé "font"
    $profiles = @{
        font = @{
            face = $argument
        }
    }
    #ajoute la clé "font" dans le fichier
    $file.profiles.defaults = $profiles
}

#enregistre le fichier
$json = ConvertTo-Json $file -Depth 100
$json | Set-Content $Path

Write-Host "Change done" -ForegroundColor Green
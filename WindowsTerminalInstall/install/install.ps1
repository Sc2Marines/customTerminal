#test if the script is run as administrator
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    #ask for administrator rights
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    #exit the current script
    exit
}

#verify that powershell 7 is installed
Write-Host "Install powershell" -ForegroundColor Green
winget install Microsoft.PowerShell -e

#oh-my-posh
Write-Host "Install oh-my-posh" -ForegroundColor Green
winget install JanDeDobbeleer.OhMyPosh -s winget
winget upgrade JanDeDobbeleer.OhMyPosh -s winget

#install Windows Terminal
Write-Host "Install Windows Terminal" -ForegroundColor Green
$package = "Microsoft.WindowsTerminal"
$packageFullName = (Get-AppxPackage -Name $package).PackageFullName
if ($packageFullName) {
    Write-Host "Windows Terminal is already installed" -ForegroundColor Green
}
else {
    Write-Host "Windows Terminal is not installed" -ForegroundColor Yellow

    #install windows terminal through the store with winget
    Write-Host "Install windows terminal through the store" -ForegroundColor Green
    #install and auto accept the license
    winget install $package -e

    #auto update windows terminal with winget
    Write-Host "Auto update windows terminal" -ForegroundColor Green
    winget upgrade --id $package

    #start windows terminal wait 1 sec and close it
    Write-Host "Start windows terminal wait 1 sec and close it" -ForegroundColor Green
    #go to C:\Program Files\WindowsApps\ and look for a folder who begin with Microsoft.WindowsTerminal and then exec WindowsTerminal.exe inside
    $windowsTerminalPath = Get-ChildItem -Path "C:\Program Files\WindowsApps\" -Filter "Microsoft.WindowsTerminal*" -Directory | Select-Object -First 1
    $windowsTerminalPath = $windowsTerminalPath.FullName
    $windowsTerminalPath = $windowsTerminalPath + "\WindowsTerminal.exe"
    Start-Process -FilePath $windowsTerminalPath


    
    Start-Sleep -s 1
    Stop-Process -Name WindowsTerminal


}


Write-Host "Install windows terminal profile" -ForegroundColor Green
#get the current user
$user = [Environment]::UserName
#create a profile for the current user
if (!(Test-Path "C:\Users\$user\Documents\PowerShell")) {
    Write-Host "Create a profile for the current user" -ForegroundColor Green
    mkdir "C:\Users\$user\Documents\PowerShell"
}
if (!(Test-Path "C:\Users\$user\Documents\PowerShell\Microsoft.PowerShell_profile.ps1")) {
    Write-Host "Create a profile for the current user" -ForegroundColor Green
    New-Item "C:\Users\$user\Documents\PowerShell\Microsoft.PowerShell_profile.ps1" -ItemType file
}


#path of the current script
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

#copy the file powershell (../etc) profile and the folder scripts to the profile folder
Write-Host "C:\Users\$user\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
Copy-Item -Path "$scriptPath\..\Microsoft.PowerShell_profile.ps1" -Destination "C:\Users\$user\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
Write-Host "C:\Users\$user\Documents\PowerShell\Scripts"
Copy-Item -Path "$scriptPath\..\Scripts" -Destination "C:\Users\$user\Documents\PowerShell" -Recurse -Force

#set powershell 7 as default in windows terminal
Write-Host "Set powershell 7 as default in windows terminal" -ForegroundColor Green
$settings = Get-Content "C:\Users\$user\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" -Raw | ConvertFrom-Json

$settings.defaultProfile = "{574e775e-4f2a-5b96-ac1e-a2962a402336}"
# Convert the updated settings back to JSON
$jsonSettings = $settings | ConvertTo-Json -Depth 10
# Save the updated JSON to the file
$jsonSettings | Set-Content "C:\Users\$user\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
Write-Host "Set powershell 7 as default in windows terminal" -ForegroundColor Green

#set the windows terminal as administrator by default
Write-Host "Set the windows terminal as administrator by default" -ForegroundColor Green
$settings = Get-Content "C:\Users\$user\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" -Raw | ConvertFrom-Json


# Vérify if the key 'elevate' exist
if (-not $settings.profiles.defaults.elevate) {
    $settings.profiles.defaults | Add-Member -MemberType NoteProperty -Name elevate -Value $true
} else {
    $settings.profiles.defaults.elevate = $true
}


# Convert the updated settings back to JSON
$jsonSettings = $settings | ConvertTo-Json -Depth 10
# Save the updated JSON to the file
$jsonSettings | Set-Content "C:\Users\$user\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"

#Set the windows terminal as default terminal
$regPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\App Paths\wt.exe"
if (-Not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force
}
Set-ItemProperty -Path $regPath -Name "(Default)" -Value $windowsTerminalPath




Write-Host "Installation done" -ForegroundColor Green
Write-Host "The theme zash is already downloaded as an exemple." -ForegroundColor Green
Write-Host "Close and restart Terminal to apply changes." -ForegroundColor Yellow 
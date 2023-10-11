$package = "Microsoft.WindowsTerminal"
$user = [Environment]::UserName

#oh-my-posh
Write-Host "uninstall oh-my-posh" -ForegroundColor Green
winget uninstall --id JanDeDobbeleer.OhMyPosh

#Microsoft terminal
Write-Host "Install windows terminal settings" -ForegroundColor Green
Write-Host "Fonts will not be removed, you can remove it from : C:\Users\$user\AppData\Local\Microsoft\Windows\Fonts , C:\Windows\Fonts" -ForegroundColor Yellow
Write-Host "Would  you like to keep Microsoft's Terminal (y/n) ?" -ForegroundColor Green
$keep_microsoft_terminal = Read-Host
while ($keep_microsoft_terminal -ne "y" -and $keep_microsoft_terminal -ne "n") {
    Write-Host "Would  you like to keep Microsoft's Terminal (y/n) ?" -ForegroundColor Green
    $keep_microsoft_terminal = Read-Host
}
if ($keep_microsoft_terminal -eq "n")
{
    #uninstall windows terminal with winget
    Write-Host "Uninstall windows terminal with winget" -ForegroundColor Green
    winget uninstall --id $package
}

#theme and profile

if ((Test-Path "C:\Users\$user\Documents\PowerShell")) {
    Write-Host "Remove the files for the current user" -ForegroundColor Green
    Remove-Item "C:\Users\$user\Documents\PowerShell" -Recurse -Force
}
if ((Test-Path "C:\Users\$user\Documents\PowerShell\Microsoft.PowerShell_profile.ps1")) {
    Write-Host "Remove the profile for the current user" -ForegroundColor Green
    Remove-Item "C:\Users\$user\Documents\PowerShell\Microsoft.PowerShell_profile.ps1" -Force
    New-Item "C:\Users\$user\Documents\PowerShell\Microsoft.PowerShell_profile.ps1" -ItemType file
}
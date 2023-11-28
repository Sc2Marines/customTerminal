#check if we are in powershell admin mode
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "You do not have Administrator rights, no worries, we will install the font for the current user."
    Write-Warning "Installing as a user might not work, consider running this script as an administrator." 
    oh-my-posh font install --user
}
else {
    
    oh-my-posh font install

}

# $user = [Environment]::UserName

# for each font installed in "C:\Windows\Fonts"
$fonts = Get-ChildItem -Path "C:\Windows\Fonts" -Filter "*.ttf" -Recurse
foreach ($font in $fonts) {
    $destination = "C:\Windows\Fonts\$($font.Name)"
    if (!(Test-Path $destination)) {
        # if the font is not installed in "C:\Windows\Fonts" install it
        Copy-Item -Path $font.FullName -Destination $destination
    }
}

Write-Host "Font installed" -ForegroundColor Green
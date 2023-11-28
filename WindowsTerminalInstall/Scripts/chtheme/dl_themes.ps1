function Test_InternetConnection {
    $url = "http://www.google.com"
    $timeout = 5000 # 5 seconds

    try {
        $request = [System.Net.WebRequest]::Create($url)
        $request.Timeout = $timeout
        $response = $request.GetResponse()
        $response.Close()
        return $true
    }
    catch {
        return $false
    }
}

$argument = $args[0].Split(" ")[0]
if ($argument -eq "") {
    Write-Host "you must specify a theme" -ForegroundColor Yellow
    return
}
$path = "themes"
$url = "https://api.github.com/repos/JanDeDobbeleer/oh-my-posh/git/trees/main?recursive=1"
$theme_folder = "$PSScriptRoot\themes"
$internet = Test_InternetConnection

if ($internet -eq $false) {
    Write-Host "You are not connected to the internet." -ForegroundColor Red
    Write-Host "Please connect to the internet and try again." -ForegroundColor Red
    exit
}

$response = Invoke-RestMethod -Uri $url

$filenames = @()
foreach ($item in $response.tree) {
    if ($item.path.StartsWith($path)) {
        if ($item.path -eq $path) {
            continue
        }
        $temp = $item.path.Split("/")[1]
        $temp = $temp.Replace(".omp.json", "")
        $filenames += $temp
    }
}

$filenames = $filenames | Sort-Object



function display_available_themes
{
    Write-Host "Available themes:" -ForegroundColor Green
    $filenames | ForEach-Object { Write-Host $_ -ForegroundColor Green } | More
}

function download_theme {
    param (
        [Parameter(Mandatory=$true)]
        [string]$name
    )

    # Check if the theme exists in the filenames array
    if ($filenames -contains $name) {
        # Check if the theme is already downloaded
        if (Test-Path "$theme_folder\$name.omp.json") {
            Write-Host "The theme '$name' is already downloaded." -ForegroundColor Yellow
            # Ask if the user wants to download it again
            $answer = Read-Host "Do you want to download it again? (y/n)"
            if ($answer -eq "y") {
                # Download the theme
                $url = "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/$name.omp.json"
                try {
                    Invoke-WebRequest -Uri $url -OutFile "$theme_folder\$name.omp.json"
                    Write-Host "The theme '$name' has been downloaded." -ForegroundColor Green
                }
                catch {
                    Write-Host "Theme not found." -ForegroundColor Red
                }

            }
        }
        else {
            # Download the theme
            $url = "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/$name.omp.json"

            try {
                $response = Invoke-WebRequest -Uri $url -ErrorAction Stop
                $response.Content | Out-File "$theme_folder\$name.omp.json"
                Write-Host "The theme '$name' has been downloaded." -ForegroundColor Green
            } catch {
                Write-Host "Theme not found." -ForegroundColor Red
            }
        }
    }
    else {
        Write-Host "The theme '$name' does not exist." -ForegroundColor Red
    }
}

if ($argument -eq "available" -or $argument -eq "-a") {
    display_available_themes
}
else {
    download_theme -name $argument
}

$var = "$PSScriptRoot\Scripts\chtheme\main.ps1"


# we include the main function
. $var

function theme() {
    if ($args) { main $args } else { main }
}

& "$PSScriptRoot\Scripts\chtheme\actual_theme.ps1"
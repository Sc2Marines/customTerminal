
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
$fonts = (New-Object System.Drawing.Text.InstalledFontCollection).Families


#array to store the tags [Nerd Font, NF, Nerd, Nerd-Font, NerdFont, NFP, NFM]
$fonts_array = @("Nerd Font", "NF", "Nerd", "Nerd-Font", "NerdFont", "NFP", "NFM")

$font_families = @{}
#display the fonts
foreach ($font in $fonts) {
    #if the name of the font contains one of the tags
    foreach ($tag in $fonts_array) {
        if ($font.Name.Contains($tag)) {
            #display the font
            #pick the first word (before the first space)

            $font_name = $font.Name.Split(" ")[0]

            #add the font to the array
            if ($font_families.ContainsKey($font_name)) {
                $font_families[$font_name] += @($font.Name)
            } else {
                $font_families[$font_name] = @($font.Name)
            }

            break
        }
    }
}

function get_font_families
{
    # Trie les clés du tableau $font_families par ordre alphabétique
    $font_families_keys = $font_families.Keys | Sort-Object
    # Affiche les familles de polices triées par ordre alphabétique
    $font_families_keys | ForEach-Object { Write-Host $_ -ForegroundColor Green } | More
}

function get_font_child
{
    param (
        [Parameter(Mandatory=$true)]
        [string]$font_family
    )
    # Trie les valeurs du tableau $font_families par ordre alphabétique
    $font_families_values = $font_families[$font_family] | Sort-Object

    # Affiche les polices enfants triées par ordre alphabétique
    $font_families_values | ForEach-Object { Write-Host $_ -ForegroundColor Green } | More
}
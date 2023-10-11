function main{

    param (
        [Parameter(Mandatory=$false)]
        [string[]]$arguments
    )

    if ($null -eq $arguments) {
        . "$PSScriptRoot\get_theme.ps1"
        return
    }
    
    switch ($arguments[0]) {
        "--help" 
        {
            
            Write-Host "Fonctions available:"
            Write-Host "- theme                                                 : get the theme & the font used."
            Write-Host "- theme --help                                          : display this help."
            Write-Host "- theme --list theme                                    : get the list of themes available on this computer."
            Write-Host "- theme --list font                                     : get the list of family fonts available on this computer."
            Write-Host "- theme --list font <font-family-name>                  : get the list of family font children's available on this computer."
            Write-Host "- theme --change theme|font <theme name>|<font-name>    : change the theme or the font."
            Write-Host "- theme --download theme available|<theme name>         : download the theme or display the available themes."
            Write-Host "- theme --download font                                 : launch the font downloader manager."
            Write-Host "Symbols and syntax:"    
            Write-Host "- || : or"
            Write-Host "- [] : optional"
            Write-Host "- <> : argument"
            Write-Host "- |  : choice between"
            Write-Host "To change the font, you first need to have the complete name of the font, you can get it with the command ""theme --list font <font-family-name> "". "
            Write-Host "You can use the short version of the arguments for example: ""theme --list theme"" can be written ""theme -l -t"""
        }
        "-h"
        {
            Write-Host "Fonctions available:"
            Write-Host "- theme                                                 : get the theme & the font used."
            Write-Host "- theme --help                                          : display this help."
            Write-Host "- theme --list theme                                    : get the list of themes available on this computer."
            Write-Host "- theme --list font                                     : get the list of family fonts available on this computer."
            Write-Host "- theme --list font <font-family-name>                  : get the list of family font children's available on this computer."
            Write-Host "- theme --change theme|font <theme name>|<font-name>    : change the theme or the font."
            Write-Host "- theme --download theme available|<theme name>         : download the theme or display the available themes."
            Write-Host "- theme --download font                                 : launch the font downloader manager."
            Write-Host "Symbols and syntax:"    
            Write-Host "- || : or"
            Write-Host "- [] : optional"
            Write-Host "- <> : argument"
            Write-Host "- |  : choice between"
            Write-Host "To change the font, you first need to have the complete name of the font, you can get it with the command ""theme --list font <font-family-name> "". "
            Write-Host "You can use the short version of the arguments for example: ""theme --list theme"" can be written ""theme -l -t""."
        }
        "--download"
        {
            switch ($arguments[1]) {
                "theme"
                {  
                    $new = $arguments[2]
                    . "$PSScriptRoot\dl_themes.ps1" "$new"
                }
                "-t" 
                {  
                    $new = $arguments[2]
                    . "$PSScriptRoot\dl_themes.ps1" "$new"
                }
                "font" 
                {  
                    . "$PSScriptRoot\dl_fonts.ps1"
                }
                "-f" 
                {  
                    . "$PSScriptRoot\dl_fonts.ps1"
                }
                ""
                {
                    Write-Host "Missing parameter" -ForegroundColor Red
                }
                Default {}
            }
        }
        "-d"
        {
            switch ($arguments[1]) {
                "theme"
                {  
                    $new = $arguments[2]
                    . "$PSScriptRoot\dl_themes.ps1" "$new"
                }
                "-t" 
                {  
                    $new = $arguments[2]
                    . "$PSScriptRoot\dl_themes.ps1" "$new"
                }
                "font" 
                {  
                    . "$PSScriptRoot\dl_fonts.ps1"
                }
                "-f" 
                {  
                    . "$PSScriptRoot\dl_fonts.ps1"
                }
                ""
                {
                    Write-Host "Missing parameter" -ForegroundColor Red
                }
                Default {}
            }
        }
        "--change"
        {
    
            switch ($arguments[1]) {
                "theme"
                {

                    $new = $arguments[2]
                    . "$PSScriptRoot\install_theme.ps1" "$new"
                }
                "-t"
                {
                    $new = $arguments[2]
                    . "$PSScriptRoot\install_theme.ps1" "$new"
                }
                "font"
                {
                    $new = $arguments[2]
                    . "$PSScriptRoot\install_font.ps1" "$new"
                }
                "-f"
                {
                    $new = $arguments[2]
                    . "$PSScriptRoot\install_font.ps1" "$new"
                }
                ""
                {
                    Write-Host "Missing parameter" -ForegroundColor Red
                }
                Default {
                    Write-Host "Unknown parameter" -ForegroundColor Red
                }
            }
    
        }
        "-c"
        {
    
            switch ($arguments[1]) {
                "theme"
                {

                    $new = $arguments[2]
                    . "$PSScriptRoot\install_theme.ps1" "$new"
                }
                "-t"
                {
                    $new = $arguments[2]
                    . "$PSScriptRoot\install_theme.ps1" "$new"
                }
                "font"
                {
                    $new = $arguments[2]
                    . "$PSScriptRoot\install_font.ps1" "$new"
                }
                "-f"
                {
                    $new = $arguments[2]
                    . "$PSScriptRoot\install_font.ps1" "$new"
                }
                ""
                {
                    Write-Host "Missing parameter" -ForegroundColor Red
                }
                Default {
                    Write-Host "Unknown parameter" -ForegroundColor Red
                }
            }
    
        }
        "--list"
        {   
            switch ($arguments[1]) {
                "font"
                {
                    . "$PSScriptRoot\get_fonts.ps1"
                    #if there is a second argument get_font_child $arguments[2]
                    if ($null -ne $arguments[2]) {
                        get_font_child $arguments[2]
                    } else {
                        get_font_families
                    }
                }
                "-f"
                {
                    . "$PSScriptRoot\get_fonts.ps1"
                    #if there is a second argument get_font_child $arguments[2]
                    if ($null -ne $arguments[2]) {
                        get_font_child $arguments[2]
                    } else {
                        get_font_families
                    }
                }
                "theme"
                {
                    . "$PSScriptRoot\get_themes.ps1"
                }
                "-t"
                {
                    . "$PSScriptRoot\get_themes.ps1"
                }
                ""
                {
                    Write-Host "Missing parameter" -ForegroundColor Red
                }
                Default {
                    Write-Host "Unknown parameter" -ForegroundColor Red
                }
            }
        }   
        "-l"
        {   
            switch ($arguments[1]) {
                "font"
                {
                    . "$PSScriptRoot\get_fonts.ps1"
                    #if there is a second argument get_font_child $arguments[2]
                    if ($null -ne $arguments[2]) {
                        get_font_child $arguments[2]
                    } else {
                        get_font_families
                    }
                }
                "-f"
                {
                    . "$PSScriptRoot\get_fonts.ps1"
                    #if there is a second argument get_font_child $arguments[2]
                    if ($null -ne $arguments[2]) {
                        get_font_child $arguments[2]
                    } else {
                        get_font_families
                    }
                }
                "theme"
                {
                    . "$PSScriptRoot\get_themes.ps1"
                }
                "-t"
                {
                    . "$PSScriptRoot\get_themes.ps1"
                }
                ""
                {
                    Write-Host "Missing parameter" -ForegroundColor Red
                }
                Default {
                    Write-Host "Unknown parameter" -ForegroundColor Red
                }
            }
        }   
        default
        {
            Write-Host "unknown command" -ForegroundColor Red
        }
    }
}
# Path to the folder containing pictures
$pictureFolder = "C:\BackgroundChange\pics"

# Function to set the desktop background
function Set-Wallpaper {
    param([string]$path)
    Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;

    public class Wallpaper {
        [DllImport("user32.dll", CharSet = CharSet.Auto)]
        public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
    }
"@
    [Wallpaper]::SystemParametersInfo(20, 0, $path, 3)
}

# Main loop to cycle through each picture
while ($true) {
    # Get a random picture from the folder
    $randomPicture = Get-ChildItem -Path $pictureFolder -Filter *.jpg | Get-Random

    # Set the random picture as the desktop background
    Set-Wallpaper -path $randomPicture.FullName
    
    # Wait for 10 seconds
    Start-Sleep -Seconds 10
}

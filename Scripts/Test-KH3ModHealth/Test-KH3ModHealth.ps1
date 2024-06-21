$PATH_MODS = "<add absolute path to ~mods>"
$PATH_REPAK = "<add absolute path to repak.exe>"

# Examples:
# $PATH_MODS = "C:\Program Files\Epic Games\KH_3\KINGDOM HEARTS III\Content\Paks\~mods"
# $PATH_REPAK = "C:\DEV\KH3\KH3TK-Release\repak\repak.exe"

function Test-KH3ModHealth ($ModPath, $RepakPath) {

    if (-not (Test-Path $PATH_MODS -PathType Container)) {
        throw "Invalid Path: $PATH_MODS. Doesn't exist or not a folder."
    }

    if (-not (Test-Path $PATH_REPAK -PathType Leaf)) {
        throw "Invalid Path: $PATH_REPAK. Doesn't exist or not a file. Get it from https://github.com/trumank/repak"
    }

    $Result = @{}

    Get-ChildItem $PATH_MODS -Filter *.pak -Recurse | 
        ForEach-Object {
            $CurrentPak =$_
            . $PATH_REPAK list $CurrentPak.FullName | 
                ForEach-Object {
                    $CurrentAsset=$_
                    if(!$Result[$CurrentAsset]){$Result[$CurrentAsset]=@()}
                    $Result[$CurrentAsset]+=$CurrentPak
            }
        }

    "======================================"
    "KH3 Mod Health"
    "======================================"
    "Mod Path: $PATH_MODS"
    "Timestamp: $(Get-Date)"
    ""

    # Check for INI
    "======================================"
    "Checking for INI Files in your Mods..."
    "======================================"

    $Result.GetEnumerator() | Sort-Object -Property Key | Where-Object {$_.Key -match "ini$"} | ForEach-Object {
        $File = $_.Key.Split("/")[-1]
        if ($File -match "desktop.ini"){return}
        "Affected Asset:"
        $_.Key
        "Found in:"
        $_.Value.FullName.Replace($PATH_MODS, ".")
        ""
    }

    # Check for mod conflicts
    "======================================"
    "Checking for Mod Conflicts..."
    "======================================"

    $Result.GetEnumerator() | Sort-Object -Property Key | Where-Object {$_.Value.Count -gt 1} | ForEach-Object {
        $AssetPath = $_.Key
        $AffectedMods = $_.Value
        "Affected Asset:"
        $AssetPath
        "Found in:"
        $AffectedMods.FullName.Replace($PATH_MODS, ".")
        ""
    }
}

Write-Host "Testing KH3 Mod Health..."
$ExecutionTimestamp = Get-Date -Format "yyyyMMdd-HHmm"
Test-KH3ModHealth -ModPath $PATH_MODS -RepakPath $PATH_REPAK | Set-Content -Path "$PSScriptRoot\KH3ModHealth-$ExecutionTimestamp.txt"
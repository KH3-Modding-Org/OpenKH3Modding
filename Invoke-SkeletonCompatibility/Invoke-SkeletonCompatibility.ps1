#############
# CONSTANTS #
#############

# Game
$GAME_AES_KEY = Get-Content $PSScriptRoot\AES.txt -ErrorAction SilentlyContinue
if (!$GAME_AES_KEY) {
    New-Item -ItemType File -Path "$PSScriptRoot\AES.txt" -Force | Out-Null
    throw "AES Key missing or invalid. Add it to AES.txt in the script root."
    return
}
$GAME_PAK_PATH = "C:\Program Files\Epic Games\KH_3\KINGDOM HEARTS III\Content\Paks"

# UModel
$UMODEL_BIN_PATH = "C:\DEV\KH3\KH3TK\uModel (BlasterGrim)\umodel_64.exe"
$UMODEL_GAME_TAG = "kh3"

# UAssetGUI
$UASSETGUI_BIN_PATH = "C:\DEV\KH3\KH3TK\UAssetGUI\UAssetGUI.exe"
$UASSETGUI_UE_VER = "VER_UE4_17"

#############
# FUNCTIONS #
#############

# Formats JSON in a nicer format than the built-in ConvertTo-Json does.
function Format-Json([Parameter(Mandatory, ValueFromPipeline)][String] $json) {
    $indent = 0;
    ($json -Split "`n" | ForEach-Object {
        if ($_ -match '[\}\]]\s*,?\s*$') {
            # This line ends with ] or }, decrement the indentation level
            $indent--
        }
        $line = ('  ' * $indent) + $($_.TrimStart() -replace '":  (["{[])', '": $1' -replace ':  ', ': ')
        if ($_ -match '[\{\[]\s*$') {
            # This line ends with [ or {, increment the indentation level
            $indent++
        }
        $line
    }) -Join "`n"
}

Function Save-UEPawnPackage () {
    param (
        [parameter(Mandatory = $true)]
        [String]
        $PawnID,

        [parameter()]
        [ValidateSet("All", "BP", "Skeleton", "Mesh")]
        $Type,

        [ValidateScript({
                if (-Not ($_ | Test-Path) ) {
                    throw "File or folder does not exist" 
                }
                if (-Not ($_ | Test-Path -PathType Container) ) {
                    throw "The Out argument must be a folder. File paths are not allowed."
                }
                return $true
            })]
        [System.IO.FileInfo]$Out
    )

    switch ($Type) {
        'BP' { $AssetFile = "$($PawnID)_Pawn.uasset" }
        'Skeleton' { $AssetFile = "$($PawnID)_0_Skeleton.uasset" }
        Default {}
    }
    
    $tmp = Get-Location
    Set-Location $Out
    & "$UMODEL_BIN_PATH" -save $AssetFile "-game=$UMODEL_GAME_TAG" "-path=$GAME_PAK_PATH" "-aes=$GAME_AES_KEY" | Out-Null
    # Known Error: Run this twice, or otherwise saving isn't finished.
    Set-Location $tmp

    return (Get-ChildItem $AssetFile -Path "$Out\UModelSaved" -Recurse).FullName
}

function Import-UEPawnPackage {
    param (
        [parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [ValidateScript({
                if (-Not ($_ | Test-Path) ) {
                    throw "File does not exist" 
                }
                if (-Not ($_ | Test-Path -PathType Leaf) ) {
                    throw "FilePath must be a file."
                }
                if (-Not ($_.ToString().EndsWith(".uasset"))) {
                    throw "FilePath must be a file."
                }
                return $true
            })]
        [String] $UAssetFilePath
    )

    $JSONFilePath = "$((Get-Item $UAssetFilePath).Directory)\$((Get-Item $UAssetFilePath).BaseName).json"
    Start-Process "$UASSETGUI_BIN_PATH" -ArgumentList "tojson $UAssetFilePath $JSONFilePath $UASSETGUI_UE_VER" -Wait

    return (Get-Content $JSONFilePath | ConvertFrom-Json)
}

function Add-CompatibleSkeleton () {
    param (
        [parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [ValidateScript({
                if (-Not ($_.GetType().Name -eq "PSCustomObject") ) {
                    throw "InputAsset must be a PSCustomObject. Use Import-UEPawnPackage." 
                }
                if (-Not ($Asset.Imports | Where-Object { $_.ObjectName -eq "Default__Skeleton" }) ) {
                    throw "InputAsset must be a Skeleton"
                }
                return $true
            })]
        [PSCustomObject]
        $InputAsset,

        [parameter(Mandatory = $true)]
        [String]
        $CompatibleSkeletonName,

        [parameter(Mandatory = $true)][ValidateScript({
                if (-not ($_.StartsWith("/Game/"))) {
                    throw "CompatibleSkeletonPath must be a reference to an in-game skeleton (e.g. /Game/...)"
                }
                if (-not ($_.EndsWith($CompatibleSkeletonName))) {
                    throw "CompatibleSkeletonPath must end with CompatibleSkeletonName"
                }
                return $true
            })][String]$CompatibleSkeletonPath
    )

    # Add NameMap stuff
    $NameMapAdditions = @(
        "SQEX_CompatibleSkeletonLists",
        "SqEX_CompatibleSkeletonData",
        "m_CompatibleSkeleton",
        "m_IgnoreNodes",
        "m_AppendNodes",
        $CompatibleSkeletonName,
        $CompatibleSkeletonPath
    )

    $Asset.NameMap = ($Asset.NameMap + $NameMapAdditions) | Select-Object -Unique

    # Add import for package path
    $ImportedObj = @{
        "`$type"       = "UAssetAPI.Import, UAssetAPI";
        "ClassPackage" = "/Script/CoreUObject";
        "ClassName"    = "Package";
        "ObjectName"   = $CompatibleSkeletonPath;
        "OuterIndex"   = 0
    }

    $Asset.Imports += @($ImportedObj)

    # Add import for Skeleton name
    $ImportedObj = @{
        "`$type"       = "UAssetAPI.Import, UAssetAPI";
        "ClassPackage" = "/Script/CoreUObject";
        "ClassName"    = "Skeleton";
        "ObjectName"   = $CompatibleSkeletonName;
        "OuterIndex"   = - $Asset.Imports.Count #Will reference previously added entry
    }

    $Asset.Imports += @($ImportedObj)

    # Add exports stuff
    if (-not ($Asset.Exports.Data | Where-Object { $_.Name -eq "SQEX_CompatibleSkeletonLists" })) {
        $Addition = @"
{
  "SkeletonCompatibilityListEntry": [
    {
      "`$type": "UAssetAPI.PropertyTypes.Objects.ArrayPropertyData, UAssetAPI",
      "ArrayType": "StructProperty",
      "Name": "SQEX_CompatibleSkeletonLists",
      "DuplicationIndex": 0,
      "Value": [
        {
          "`$type": "UAssetAPI.PropertyTypes.Structs.StructPropertyData, UAssetAPI",
          "StructType": "SqEX_CompatibleSkeletonData",
          "SerializeNone": true,
          "StructGUID": "00000000-0000-0000-0000-000000000000",
          "Name": "SqEX_CompatibleSkeletonData",
          "DuplicationIndex": 0,
          "Value": [
            {
              "`$type": "UAssetAPI.PropertyTypes.Objects.ArrayPropertyData, UAssetAPI",
              "ArrayType": "NameProperty",
              "Name": "m_IgnoreNodes",
              "DuplicationIndex": 0,
              "Value": []
            },
            {
              "`$type": "UAssetAPI.PropertyTypes.Objects.ArrayPropertyData, UAssetAPI",
              "ArrayType": "NameProperty",
              "DummyStruct": null,
              "Name": "m_AppendNodes",
              "DuplicationIndex": 0,
              "Value": []
            }
          ]
        }
      ]
    }
  ]
}
"@ | ConvertFrom-Json
        ($Asset.Exports | Select-Object -Last 1).Data += $Addition.SkeletonCompatibilityListEntry
    }

    # Get SkeletonCompatibilityList node from Asset
    $SkeletonCompatibilityListEntry = $Asset.Exports.Data | Where-Object { $_.Name -eq "SQEX_CompatibleSkeletonLists" }

    # Build m_CompatibleSkeleton object
    $m_CompatibleSkeleton = [PSCustomObject]@{
        "`$type"           = "UAssetAPI.PropertyTypes.Objects.ObjectPropertyData, UAssetAPI";
        "Name"             = "m_CompatibleSkeleton";
        "DuplicationIndex" = 0;
        "Value"            = - $Asset.Imports.Count #Will reference the last imported entry (=the skeleton)
    }
    
    $SkeletonCompatibilityListEntry.Value[0].Value += @($m_CompatibleSkeleton)
}

function Export-UEPawnPackage {
    param (
        [parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [ValidateScript({
                if (-Not ($_.GetType().Name -eq "PSCustomObject") ) {
                    throw "InputAsset must be a PSCustomObject. Use Import-UEPawnPackage." 
                }
                return $true
            })]
        [PSCustomObject]
        $InputAsset,

        [ValidateScript({
                if (-Not ($_ | Test-Path) ) {
                    throw "File or folder does not exist" 
                }
                if (-Not ($_ | Test-Path -PathType Container) ) {
                    throw "The Out argument must be a folder. File paths are not allowed."
                }
                return $true
            })]
        [System.IO.FileInfo]$OutputFolder = $PSScriptRoot,

        [String]$FileName

    )

    $Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding $False
    $JSONFileName = $FileName.Replace(".uasset", ".json")
    $JSONTempPath = "$OutputFolder\$JSONFileName" # export it here without BOM
    [System.IO.File]::WriteAllLines($JSONTempPath, ($InputAsset | ConvertTo-Json -Depth 100 | Format-Json), $Utf8NoBomEncoding)

    # Turn JSON back to uasset
    # see https://github.com/atenfyr/UAssetGUI/blob/master/UAssetGUI/Program.cs
    # UAssetGUI fromjson B.json A.umap
    & "$UASSETGUI_BIN_PATH" "fromjson" $JSONTempPath "$OutputFolder\$FileName"
}

# #### #
# MAIN #
# #### #

# Get Skeleton UAsset via Umodel
$TargetPawnID = Read-Host -Prompt "Enter Target Pawn where SkelCompat should be added (e.g.: n_he204)"

# Get Compatible Skeleton Data
$CompatiblePawnID = Read-Host -Prompt "Enter Source Pawn whose skeleton will be referenced (e.g.: e_ex304)"
 switch ($CompatiblePawnID[0]) {
    "n" { $Subfolder = "npc"  }
    "e" { $Subfolder = "enemy"  }
    "p" {  $Subfolder = "pc" }
    Default {throw "Pawn could not be identified..."; return}
 }
$CompatSkelName = "$($CompatiblePawnID)_0_Skeleton"
$CompatSkelPath = "/Game/Character/$Subfolder/$CompatiblePawnID/mdl/$CompatSkelName"

# Get Asset and Add Skeleton Compatibility
$AssetFilePath = Save-UEPawnPackage -PawnID $TargetPawnID -Type Skeleton -Out $PSScriptRoot
$Asset = Import-UEPawnPackage $AssetFilePath
$Asset | Add-CompatibleSkeleton -CompatibleSkeletonName $CompatSkelName -CompatibleSkeletonPath $CompatSkelPath

# Build Asset
$Asset | Export-UEPawnPackage -OutputFolder $PSScriptRoot -FileName "$($TargetPawnID)_0_Skeleton.uasset"
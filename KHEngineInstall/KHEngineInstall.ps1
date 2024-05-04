<#
.SYNOPSIS
    Helper script to install the Custom Unreal Engine (aka NarkEngine) and Unreal Project (aka TresGame) for Kingdom Hearts 3 Modding

.DESCRIPTION
    The script will guide through the process and tries to automate as much as possible.

    Steps are roughly:
    1) Check if git is installed or guide users to the DL page
    2) Get engine installation Path from user
    3) Clone the engine repository to disk
    4) Get project installation Path from user
    5) Clone the project repository to disk
    6) Initalize engine via setup.bat
    7) Run generateprojectfiles.bat
    8) Register new engine path
    9) Switch project to new engine (also generating .sln file)
    10) Launch project with new engine
 
.NOTES
    The code of this script is free for anyone to use and modify. It is provided AS IS and without warranty of any kind. 

    File Name       : KHEngineInstall.ps1  
    Author (Script) : Minty123 on GitHub / dedede123 on Discord

    Requires        : Linked Epic and Github Accounts
                      git.exe in path
                      Plenty of disk space (~20GB)

    Changes:        : 2024-05-02
                      - Added selection for multiple KHEngines.
                      - Renamed to KHEngine Install.

                       2022-12-08
                      - Added transcript logging, more checks, refactored code. Harmonized output using Write-LogMessage
                      - Downloads vswhere to avoid redistributing the file directly
                      - Added start.bat for simpler start + dealing with execution policy

                      2022-11-06
                      - Added VS 2017 install

                      2022-11-05
                      - Alpha Release
    
    Known Issues    : - VS 2017 detection logic may fail when theres multiple VS 2017 installs

    TODOs           : - Add more prerequisite checks?
                      - Make cloning a function to avoid code repition.
                      - Add async git clone via Start-Process. Issue: Output of git.exe not available via Start-Process. Unclear how to do error handling yet.

.LINK 
    For a manual guide of the custom engine and project setup see:
        https://github.com/KH3-Modding-Org/OpenKH3Modding

#>


function Start-Setup {
    # ######### #
    # Constants # 
    # ######### #

    # Script's data folder. Used for temp files, supplied configs, ...
    $DATA_FOLDER_NAME = "data"
    $DATA_FOLDER_PATH = "$PSScriptRoot\$DATA_FOLDER_NAME"

    # KH Engine Params
    # ...removed from constants. Will be dynamically chosen during script runtime
    $KHENGINE_FREESPACE_IN_GB = 25

    # uProject Params
    $KHPROJECT_REPO_URL = "https://github.com/KH3-Modding-Org/TresGame"
    $KHPROJECT_REPO_NAME = "TresGame"
    $KHPROJECT_GITFILE_URL = "https://github.com/KH3-Modding-Org/TresGame.git"
    $KHPROJECT_BRANCH_NAME = "TresGame-Built"
    $KHPROJECT_FREESPACE_IN_GB = 1.5

    # Other
    $UNREAL_ACCOUNT_LINK_URL = "https://www.unrealengine.com/en-US/ue-on-github"
    $GIT_DL_URL = "https://git-scm.com/download/win"

    $VS2017_DL_URL = "https://aka.ms/vs/15/release/vs_community.exe"
    $VS2017_INSTALLER_PATH = "$DATA_FOLDER_PATH\vs_community_2017.exe"
    $WIN10_SDK_MIN_BUILD_VER = 17763

    $VSWHERE_FILE_PATH = "$DATA_FOLDER_PATH\vswhere.exe"
    $VSWHERE_DL_URL = "https://github.com/microsoft/vswhere/releases/latest/download/vswhere.exe"

    # ################ #
    # Helper Functions #
    # ################ #

    function Select-KHEngineRepo() {
        try {
            $KHEngineList = Get-Content $PSScriptRoot\KHEngine_Repos.txt -ErrorAction Stop
        }
        catch {
            Write-LogMessage "Couldn't find repo list at $PSScriptRoot\KHEngine_Repos.txt. Creating default..." -Type Warning
            @"
# Enter list of KHEngine Destinations.
# Important: One Engine per line.
# Format: <title>,<URL to KHEngine Branch>
# Example: NarkEngine (Default),https://github.com/narknon/UnrealEngine-CEEnd/tree/KHEngineBuilt
# Empty lines or lines starting with a # will be skipped.

NarkEngine,https://github.com/narknon/UnrealEngine-CEEnd/tree/KHEngineBuilt
"@ | Out-File $PSScriptRoot\KHEngine_Repos.txt -Force
            $KHEngineList = Get-Content $PSScriptRoot\KHEngine_Repos.txt
        }
        
        # Read through repo list
        $KHEngineList | ForEach-Object {
            $str = $_.Trim()
            # Skip line when necessary
            if ((-not $str) -or ($str.StartsWith("#"))) {
                return
            }

            # Extract content
            Clear-Variable -Name Matches -ErrorAction SilentlyContinue
            $str -match "(?<Title>.+),(?<URL>.+)" | Out-Null
            
            [PSCustomObject]@{
                Title = $Matches["Title"].Trim()
                URL   = $Matches["URL"].Trim()
            }
        } | Out-GridView -Title "Select your Engine" -OutputMode Single
    }

    function Test-KHEngineURL {
        param (
            [Parameter(Mandatory = $true)][String]$URL
        )
        $URL = $URL.Trim()
        if ((-not [uri]::IsWellFormedUriString($URL, 'Absolute')) -and (-not $URL.EndsWith("KHEngineBuilt"))) {
            Write-LogMessage "KHEngine URL is not valid. Make sure that it ends on ""KHEngineBuilt""" -Type Error
            Write-LogMessage "Example: https://github.com/narknon/UnrealEngine-CEEnd/tree/KHEngineBuilt" -Type Error
            return $false
        }
        else {
            return $true
        }
    }

    function Write-LogMessage () {

        [CmdletBinding()]
        param (
            [parameter(Mandatory = $true, ValueFromPipeline = $true)]
            [String]
            $Message,

            [parameter()]
            [ValidateSet("Standard", "Warning", "Info", "Error", "OK", "Highlighted")]
            $Type = "Standard"
        )

        $TypeTags = @{
            "Standard"    = ""
            "Highlighted" = ""
            "OK"          = "[OK] "
            "Info"        = "[INFO] "
            "Warning"     = "[WARNING] "
            "Error"       = "[ERROR] "

        }

        $TypeColor = @{
            "Standard"    = [System.Console]::ForegroundColor
            "Highlighted" = "Cyan"
            "OK"          = "Green"
            "Info"        = "Yellow"
            "Warning"     = "Magenta"
            "Error"       = "Red"
        }

        Write-Host ("[{0:yyyy-MM-dd} {0:HH:mm:ss}] {1}{2}" -f (Get-Date), $TypeTags[$Type], $Message) -ForegroundColor $TypeColor[$Type]
    }

    function Get-GitDataFromRepoURL() {
        param (
            [Parameter(Mandatory = $true)]
            [String]$URL
        )

        # Verify URL
        if (-not [uri]::IsWellFormedUriString($URL, 'Absolute')) {
            throw "Provided URL is not valid: $URL"
        }

        # Extract
        $URLParts = $URL -split "/"
        return [PSCustomObject]@{
            GitFileURL = ($URLParts[0..4] -join "/") + ".git"
            Author = $URLParts[3]
            RepoName = $URLParts[4]
            BranchName = $URLParts[6]
        }
    }

    function Get-IntelCoreGeneration {
        $Name = (Get-WmiObject Win32_processor).Name
        if ($Name -match "(?<BrandModifier>i\d)-(?<GenDigits>\d+)") {
            return [Math]::Floor($Matches.GenDigits / 1000)
        }
        else {
            throw "No Intel Core Processor found"
        }
    }

    function Get-Folder($initialDirectory = "", $Title = "Select a folder") {
        [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null

        $foldername = New-Object System.Windows.Forms.FolderBrowserDialog
        $foldername.Description = $Title
        $foldername.rootfolder = "MyComputer"
        $foldername.SelectedPath = $initialDirectory
        if ($foldername.ShowDialog((New-Object System.Windows.Forms.Form -Property @{TopMost = $true })) -eq "OK") {
            $folder += $foldername.SelectedPath
        }
        return $folder
    }

    function Test-LongPathsEnabled {
        # https://learn.microsoft.com/en-US/windows/win32/fileio/maximum-file-path-limitation?tabs=registry
        try {
            $RegValue = Get-ItemProperty -Path HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem -Name "LongPathsEnabled" -ErrorAction Stop
            if ($RegValue.LongPathsEnabled -eq 1) {
                return $true
            }
        }
        catch {
            # Couldn't find regkey
        }

        return $false
    }

    function Get-UESwitchVersionRegKey {
        New-PSDrive -PSProvider registry -Root HKEY_CLASSES_ROOT -Name HKCR -ErrorAction SilentlyContinue | Out-Null
        try {
            return Get-ItemProperty -Path HKCR:\Unreal.ProjectFile\shell\switchversion\command -Name "(default)" -ErrorAction Stop | Select-Object -ExpandProperty "(default)"
        }
        catch {
            return $null
        }
    }

    function Test-WritePermissions ($Path) {
        Try { [io.file]::OpenWrite("$Path\test.txt").close(); Remove-Item "$Path\test.txt"; return $True }
        Catch { return $False; }
    }

    # #### #
    # Main #
    # #### #

    Write-Host @"
=============================
 KH Engine+Project Installer 
=============================

This script automates the guide found at:
https://github.com/KH3-Modding-Org/OpenKH3Modding/blob/main/Tutorials/uProject%20and%20Engine%20Installation.md#2-github-clone-install---update-with-the-click-of-a-button

Read every output of this script carefully.
General Hints:
    - If the script fails, it's recommended to delete the folders and files it created, fix the issue and start over.
    - Use at your own risk. Source code is open to read for anyone though.
"@
    # Verify user permissions
    if (-not (Test-WritePermissions -Path $PSScriptRoot)) {
        Write-LogMessage "User is missing write access on script location. Move the script to a different location and try again. Exiting..." -Type Error
        return
    }

    # Create temp dir if missing
    if (-not (Test-Path $DATA_FOLDER_PATH)) {
        Write-LogMessage "Creating data folder..." -Type Info
        New-Item -Name $DATA_FOLDER_NAME -Path $PSScriptRoot -ItemType Directory | Out-Null
    }

    ################################
    # Selection for KHEngine Repo  #
    ################################

    Write-LogMessage "Select a KHEngine Repo... (Default: NarkEngine)" -Type Highlighted
    Read-Host "Press enter to open selection screen"
    $KHENGINE_REPO_URL = (Select-KHEngineRepo).URL
    if (-not $KHENGINE_REPO_URL) {
        Write-LogMessage "Selection was cancelled. Exiting..." -Type Error
        return
    }
    elseif (-not (Test-KHEngineURL $KHENGINE_REPO_URL)) {
        return
    }
    Write-LogMessage "You selected $KHENGINE_REPO_URL" -Type OK
    
    # Extracting data from Git URL
    $GitRepoData = Get-GitDataFromRepoURL -URL $KHENGINE_REPO_URL
    $KHENGINE_GITFILE_URL = $GitRepoData.GitFileURL
    $KHENGINE_REPO_NAME = $GitRepoData.RepoName
    $KHENGINE_BRANCH_NAME = $GitRepoData.BranchName
    Write-Host ""

    ################################
    # 1. Check if git is available #
    ################################
    Write-LogMessage "Checking for git command..." -Type Highlighted
    $Sleep_in_seconds = 5
    if (Get-Command git -ErrorAction SilentlyContinue) {
        Write-LogMessage "Found git command" -Type OK
    }
    else {
        Write-LogMessage "Couldn't find git command. Is it not installed?" -Type Error
        Write-LogMessage "Make sure to download and install Git for Windows from $GIT_DL_URL with defaults. Make sure to include any options relating to adding GIT as an environmental variable/path." -Type Info
        Write-LogMessage "Opening git page in $Sleep_in_seconds seconds. Exiting..." -Type Info
        Start-Sleep $Sleep_in_seconds
        Start-Process $GIT_DL_URL
        return
    }
    Write-Host ""
    
    ######################################### #
    # 2. Check if VS Studio 2017 is available #
    ######################################### #
    Write-LogMessage "Checking for VS 2017 install..."  -Type Highlighted

    # Check for VSWhere tool
    if (-not (Test-Path $VSWHERE_FILE_PATH)) {
        Write-LogMessage "Couldn't find vswhere in script folder. Trying to grab it it from GitHub..." -Type Info
        Invoke-WebRequest -Uri $VSWHERE_DL_URL -OutFile $VSWHERE_FILE_PATH
    }

    # Check if DL finished
    if (-not (Test-Path $VSWHERE_FILE_PATH)) {
        Write-LogMessage "Download of VSWhere failed. If you got an error message before, share it with the community. Exiting..." -Type Error
        return
    }

    Write-LogMessage "Downloaded vswhere successfully" -Type OK

    # Check for VS2017 installer
    if (-not (Test-Path $VS2017_INSTALLER_PATH)) {
        Write-LogMessage "Couldn't find VS 2017 installer file in script folder. Trying to grab it from Microsoft..." -Type Warning
        Invoke-WebRequest -Uri $VS2017_DL_URL -OutFile $VS2017_INSTALLER_PATH
    }

    # Check if DL finished
    if (-not (Test-Path $VS2017_INSTALLER_PATH)) {
        Write-LogMessage "Download of VS 2017 installer failed. If you got an error message before, share it with the community. Exiting..." -Type Error
        return
    }

    Write-LogMessage "Downloaded VS 2017 installer successfully" -Type OK
    # Execute VSWhere
    $Output = & $VSWHERE_FILE_PATH | Out-String

    if ($Output -notmatch "VisualStudio/15.9") {
        Write-LogMessage "Couldn't find Visual Studio 2017 v15.9 installation." -Type Info
        $Answer = Read-Host -Prompt "Start VS2017 installation now? (Y/N)"
        if ($Answer.ToLower() -eq "y") {
            Write-LogMessage "Starting VS 2017 installation. Please wait for it to complete..." -Type Info
            # https://learn.microsoft.com/en-us/previous-versions/visualstudio/visual-studio-2017/install/use-command-line-parameters-to-install-visual-studio?view=vs-2017
            # https://learn.microsoft.com/de-de/previous-versions/visualstudio/visual-studio-2017/install/workload-component-id-vs-community?view=vs-2017#game-development-with-c
            Start-Process $VS2017_INSTALLER_PATH -ArgumentList "--add ""Microsoft.VisualStudio.Workload.NativeGame;includeRecommended"" --add Component.Unreal --Passive" -Wait
            # Execute VSWhere again for verification
            $Output = & $VSWHERE_FILE_PATH | Out-String
            if ($Output -notmatch "VisualStudio/15.9") {
                # Still not installed
                Write-LogMessage "Failed to install VS 2017. Please try again. Exiting..." -Type Error
                return
            }
        }
        else {
            Write-LogMessage "Cannot complete without Visual Studio 2017. Please install it and restart. Exiting..." -Type Error
            return
        }
    }
    else {
        # Check if components are installed
        Write-LogMessage "Found VS 2017 install. Checking components..." -Type OK
        # https://learn.microsoft.com/en-us/previous-versions/visualstudio/visual-studio-2017/install/command-line-parameter-examples?view=vs-2017#using-export
        $VSCONFIG_FILE_PATH = "$DATA_FOLDER_PATH\temp.vsconfig"
        Remove-Item $VSCONFIG_FILE_PATH -Force -ErrorAction SilentlyContinue | Out-Null
        $VSWhereRun = Start-Process $VS2017_INSTALLER_PATH -ArgumentList "export --config $VSCONFIG_FILE_PATH --quiet" -Wait -PassThru
        if ($VSWhereRun.ExitCode -ne 0) {
            Write-LogMessage "Failed to check components. Did you deny the User Account Control? Exiting..." -Type Error
            return
        }
        $VSConfig = Get-Content $VSCONFIG_FILE_PATH -ErrorAction Stop | ConvertFrom-Json
        
        # Check workload and components individually first
        # https://github.com/KH3-Modding-Org/OpenKH3Modding/blob/main/Tutorials/uProject%20and%20Engine%20Installation.md#install-visual-studio-2017
        $IncludesCPPGameDev = $VSConfig.Components -Contains "Microsoft.VisualStudio.Workload.NativeGame" # Game development with C++
        $IncludesCPPProfiling = $VSConfig.Components -Contains "Microsoft.VisualStudio.Component.VC.DiagnosticTools" # C++ profiling tools
        $IncludesUnreal = $VSConfig.Components -Contains "Component.Unreal" # Unreal Engine Installer
        $Win10SDKMatch = $VSConfig.Components -Match "Microsoft.VisualStudio.Component.Windows10SDK.\d*"
        $IncludesWin10SDK = $Win10SDKMatch -and ($Matches[0].Split(".")[-1] -ge $WIN10_SDK_MIN_BUILD_VER)
        
        if (-not ($IncludesCPPGameDev -and $IncludesCPPProfiling -and $IncludesUnreal -and $IncludesWin10SDK)) {
            Write-LogMessage -Type Error -Message @"
VS 2017 is installed, but components are incomplete. Make sure you have the following installed:
Microsoft.VisualStudio.Workload.NativeGame (Game development with C++)
Microsoft.VisualStudio.Component.VC.DiagnosticTools (C++ profiling tools)
Component.Unreal (Unreal Engine Installer)
Microsoft.VisualStudio.Component.Windows10SDK.17763 or above (Windows 10 SDK)

Exiting...
"@
            return
        }
    }

    Write-LogMessage "VS 2017 is installed with required components." -Type OK
    Write-Host ""

    ###################################################################################
    # 3. Ask them where they want to install the engine with a dialog/directory popup # 
    ###################################################################################
    Write-LogMessage "Checking for engine directory" -Type Highlighted

    Remove-Variable EnginePath -Force -ErrorAction SilentlyContinue
    while ($True) {
        $EnginePath = Get-Folder -Title "Select root folder where engine will be installed. Path length should not exceed 200 characters. Example: C:\DEV\KHEngine"
        Write-LogMessage "Selected Path: ""$EnginePath""" -Type Info
        Write-LogMessage "Path Length in Characters: $($EnginePath.Length)" -Type Info

        # Check if user canceled
        if (-not $EnginePath) {
            Write-LogMessage "No path selected for installation. Canceled by user. Exiting..." -Type Error
            return
        }

        # Verify path requirements
        if (($EnginePath.Length -gt 200) -and -not (Test-LongPathsEnabled)) {
            $ErrMsg = "Selected path is longer than 200 characters. Restart and select shorter path."
        }
        elseif (-not (Test-WritePermissions -Path $EnginePath)) {
            $ErrMsg = "Current user doesn't have write access to selected path."
        }
        elseif ((Get-Volume -FilePath $EnginePath).SizeRemaining -lt $KHENGINE_FREESPACE_IN_GB * 1024 * 1024 * 1024) {
            $ErrMsg = "Less than $KHENGINE_FREESPACE_IN_GB GB available at given path."
        }
        else {
            # all good. break the loop.
            break
        }

        # Not good. Retry...
        Write-LogMessage $ErrMsg -Type Error
        Write-LogMessage "Please try again." -Type Error
    }

    Write-LogMessage "Engine Path selection done." -Type OK
    Write-Host ""


    ###############################################################################################
    # 4. Take path and use it to do the git clone command for the engine branch in a new console. # 
    ###############################################################################################

    Write-LogMessage "Trying to git clone the engine repository..." -Type Highlighted
    Write-LogMessage "You might be asked to authenticate with your GitHub account." -Type Info
    Write-LogMessage "BEFORE you continue, make sure your GitHub account is linked to an Epic Games account. For details see:" -Type Info
    Write-LogMessage $UNREAL_ACCOUNT_LINK_URL -Type Info
    Write-LogMessage "Cloning could take a while." -Type Info
    Read-Host -Prompt "Press Enter to confirm your accounts are linked and proceed."
    Write-Host ""

    Write-LogMessage "KHENGINE_BRANCH_NAME: $KHENGINE_BRANCH_NAME" -Type Info
    Write-LogMessage "KHENGINE_GITFILE_URL: $KHENGINE_GITFILE_URL" -Type Info
    
    # Letsa go!
    # Synchronous call:
    Remove-Variable CloneOutput -Force -ErrorAction SilentlyContinue
    Set-Location $EnginePath

    # Clone the repo to a local folder
    & git clone --progress --branch $KHENGINE_BRANCH_NAME --single-branch $KHENGINE_GITFILE_URL *>&1 | ForEach-Object { "$_" } | Tee-Object -Variable CloneOutput

    <#
    # TODO: Implement async git clone via Start-Process.

    $Proc_KHEngineClone = Start-Process cmd.exe -ArgumentList "/c ""cd $EnginePath & git clone --branch $KHENGINE_BRANCH_NAME --single-branch $KHENGINE_GITFILE_URL & pause""" -PassThru
    Write-LogMessage "You can wait for the KHEngine cloning to complete or continue now." -Type Info
    Write-LogMessage "Press Enter to continue."
    Read-Host
    #>

    # Check if process terminated correctly. If not, advise user.
    if ($LASTEXITCODE -ne 0) {
        $CloneOutput = ($CloneOutput | Out-String) 
        #Write-LogMessage "Cloning failed. See output above for errors. Check if you...`n ...linked your GitHub account. `n ...reach the repository at  `n ...cloned the repository already at $EnginePath."
        if ($CloneOutput -match "already exists and is not an empty directory") {
            Write-LogMessage "Couldn't clone repo, because $EnginePath\$KHENGINE_REPO_NAME already exists." -Type Warning
            Write-LogMessage "Only continue if you're sure you have successfully cloned the repo already. Otherwise stop here, delete the folders and start fresh." -Type Warning
            $Answer = Read-Host -Prompt "Continue? (Y/N)"
            if (-not ($Answer.ToLower() -eq "y")) {
                Write-LogMessage "Exiting..."
                return
            }
        }
        elseif ($CloneOutput -match "fatal: repository .* not found") {
            Write-LogMessage "Couldn't clone repo. Check if you linked your GitHub account with an Epic Games account and that you can access $KHENGINE_REPO_URL. Exiting..." -Type Error
            return
        }
        else {
            Write-LogMessage "Unhandled error. Please raise issue for:"
            Write-LogMessage $CloneOutput -Type Error
            Write-LogMessage "Exiting..." -Type Error
            return
        }
    }

    Write-Host ""

    ########################################################################
    # 5. If continue, ask where they want to install project with a dialog # 
    ########################################################################
    Write-LogMessage "Checking for project directory" -Type Highlighted

    Remove-Variable ProjectPath -Force -ErrorAction SilentlyContinue
    while ($True) {
        $ProjectPath = Get-Folder -Title "Select root folder where project will be installed. Path length should not exceed 200 characters AND it should not be within the engine folder. Example: C:\DEV\KHProject"
        Write-LogMessage "Selected Path: ""$ProjectPath""" -Type Info
        Write-LogMessage "Path Length in Characters: $($ProjectPath.Length)" -Type Info

        # Check if user canceled
        if (-not $ProjectPath) {
            Write-LogMessage "No path selected for installation. Canceled by user. Exiting..." -Type Error
            return
        }

        # Verify path requirements
        if (($ProjectPath.Length -gt 200) -and -not (Test-LongPathsEnabled)) {
            $ErrMsg = "Selected Path is longer than 200 characters. Restart and select shorter path."
        }
        elseif ($ProjectPath.ToLower().StartsWith("$EnginePath\$KHENGINE_REPO_NAME".ToLower())) {
            $ErrMsg = "Selected project path should not be a child of the previously selected engine path."
        }
        elseif (-not (Test-WritePermissions -Path $ProjectPath)) {
            $ErrMsg = "Current user doesn't have write access to selected path."
        }
        elseif ((Get-Volume -FilePath $EnginePath).SizeRemaining -lt $KHPROJECT_FREESPACE_IN_GB * 1024 * 1024 * 1024) {
            $ErrMsg = "Less than $KHPROJECT_FREESPACE_IN_GB GB available at given path."
        }
        else {
            # All good. break the loop!
            break
        }
        
        # Not good. Retry...
        Write-LogMessage $ErrMsg -Type Error
        Write-LogMessage "Please try again." -Type Error
    }

    Write-LogMessage "Project path selection done." -Type OK
    Write-Host ""

    #########################################
    # 6. Run git clone for that in new console # 
    #########################################

    Write-LogMessage "Trying to git clone the project repository..."
    Write-LogMessage "You might be asked to authenticate with your GitHub account." -Type Info
    Write-LogMessage "Cloning could take a while." -Type Info
    Read-Host -Prompt "Press Enter to start"

    # Letsa go!
    # Synchronous call:
    Remove-Variable CloneOutput -Force -ErrorAction SilentlyContinue
    Set-Location $ProjectPath

    # Clone the repo to a local folder
    & git clone --progress --branch $KHPROJECT_BRANCH_NAME --single-branch $KHPROJECT_GITFILE_URL *>&1 | ForEach-Object { "$_" } | Tee-Object -Variable CloneOutput

    # Check if process terminated correctly. If not, advise user.
    if ($LASTEXITCODE -ne 0) {
        $CloneOutput = ($CloneOutput | Out-String) 
        #Write-LogMessage "Cloning failed. See output above for errors. Check if you...`n ...linked your GitHub account. `n ...reach the repository at  `n ...cloned the repository already at $EnginePath."
        if ($CloneOutput -match "already exists and is not an empty directory") {
            Write-LogMessage "Couldn't clone repo, because $ProjectPath\$KHPROJECT_REPO_NAME already exists." -Type Warning
            Write-LogMessage "Only continue if you're sure you have successfully cloned the repo already. Otherwise stop here, delete the folders and start fresh." -Type Warning
            $Answer = Read-Host -Prompt "Continue? (Y/N)"
            if (-not ($Answer.ToLower() -eq "y")) {
                Write-LogMessage "Exiting..."
                return
            }
        }
        elseif ($CloneOutput -match "fatal: repository .* not found") {
            Write-LogMessage "Couldn't clone repo. Check if you linked your GitHub account with an Epic Games account and that you can access $KHPROJECT_REPO_URL. Exiting..." -Type Error
            return
        }
        else {
            Write-LogMessage "Unhandled error. Please raise issue for:" -Type Error
            Write-LogMessage $CloneOutput -Type Error
            Write-LogMessage "Exiting..." -Type Error
            return
        }
    }

    Write-Host ""

    ########################
    # 7. Calling Setup.bat # 
    ########################

    Write-LogMessage "Trying to launch setup.bat to initialize engine..."
    Write-LogMessage "This will also launch a UAC prompt for elevated permissions." -Type Info
    Write-LogMessage "Press Enter to start."
    Read-Host

    & $EnginePath\$KHENGINE_REPO_NAME\setup.bat *>&1 | ForEach-Object { "$_" } | Tee-Object -Variable CloneOutput
    Write-Host ""

    ##########################################################
    # 8. Run generateprojectfiles.bat, wait for it to finish #
    ##########################################################

    Write-LogMessage "Generating project files via generateprojectfiles.bat... (duh)"
    & $EnginePath\$KHENGINE_REPO_NAME\GenerateProjectFiles.bat *>&1 | ForEach-Object { "$_" } | Tee-Object -Variable CloneOutput
    Write-Host ""

    #################################################################
    # 9. Run unrealversionselector.exe from within the engine path. #
    #################################################################

    Write-LogMessage "Registering KHEngine build via UnrealVersionSelector-Win64-Shipping.exe..."
    & $EnginePath\$KHENGINE_REPO_NAME\Engine\Binaries\Win64\UnrealVersionSelector-Win64-Shipping.exe /register *>&1 | ForEach-Object { "$_" } | Tee-Object -Variable CloneOutput
    Write-Host ""

    ########################################
    # 10. Switch new project to new engine #
    ########################################

    Write-LogMessage "Switching KHProject to KHEngine..."

    # https://forums.unrealengine.com/t/change-the-engine-version-of-a-project-via-command-line/327889
    $PathToUESwitcher = Get-UESwitchVersionRegKey
    if ($PathToUESwitcher) {
        $PathToUESwitcher = $PathToUESwitcher.replace(" /switchversion ""%1""", "") # Remove latter part
        $PathToUESwitcher = $PathToUESwitcher.replace("""", "") # Remove quotes or it'll mess up the call later
        Write-LogMessage "Found UE Version Selector at:" -Type Info
        Write-LogMessage $PathToUESwitcher
        Write-LogMessage "Calling..."
        & $PathToUESwitcher /switchversionsilent "$ProjectPath\$KHPROJECT_REPO_NAME\$KHPROJECT_REPO_NAME.uproject" "$EnginePath\$KHENGINE_REPO_NAME" *>&1 | ForEach-Object { "$_" } | Tee-Object -Variable CloneOutput
    }
    else {
        Write-LogMessage "Couldn't find UnrealVersionSelector. Right-click in $ProjectPath\$KHPROJECT_REPO_NAME\$KHPROJECT_REPO_NAME.uproject in Explorer and select ""Switch Unreal Engine Version..."". Select your KHEngine there." -Type Warning
    }
    Write-Host ""
    
    #############################################
    # 11. Check Processor for Incompatibilities #
    #############################################
    
    # For details see https://github.com/KH3-Modding-Org/OpenKH3Modding/blob/main/Tutorials/uProject%20and%20Engine%20Installation.md#installation-was-succesful-and-sln-generates-but-project-wont-launch
    # According to OpenKH discord, Intel Core Gen 10 and higher is affected.
    
    Write-LogMessage "Checking processor version..."

    try {
        $ProcGen = Get-IntelCoreGeneration -ge 10

        if ($ProcGen -ge 10) {
            Write-LogMessage "Processor is an Intel� Core� Processor Gen 10 or higher." -Type Warning
            Write-LogMessage "UE Launcher is known to have issues with those. Adjusting OpenSSL settings via environment variable is strongly recommended." -Type Warning
            $Answer = Read-Host -Prompt "Add environment variable OPENSSL_ia32cap now? You'll be asked for elevated permissions. (Y/N)"
            if ($Answer.ToLower() -eq "y") {
                Start-Process powershell -ArgumentList "-Command ""[System.Environment]::SetEnvironmentVariable('OPENSSL_ia32cap',':~0x20000000d',[System.EnvironmentVariableTarget]::Machine)""" -Verb runAs             
            }
            else {
                Write-LogMessage "If launching UE fails, set the system variable manually. Name: ""OPENSSL_ia32cap"". Value: "":~0x20000000d"" (both without quotes)"
            }
        }
    }
    catch {
        # No Intel Core. No problem.
    }

    # ########## #
    # Done! Yay! #
    # ########## #

    Write-LogMessage "Done!" -Type OK
    Write-LogMessage "You can launch the project by double-clicking $KHPROJECT_REPO_NAME.uproject at $ProjectPath\$KHPROJECT_REPO_NAME\"  -Type OK
    $Answer = Read-Host -Prompt "Launch explorer now at $ProjectPath\$KHPROJECT_REPO_NAME\? (Y/N)"
    if ($Answer.ToLower() -eq "y") {
        & explorer $ProjectPath\$KHPROJECT_REPO_NAME\
    }
}

# ######### #
# Execution #
# ######### #
Remove-Item $PSScriptRoot\tmp.log -ErrorAction SilentlyContinue | Out-Null
$LogFilePath = "$PSScriptRoot\KHEngineInstall-$(Get-Date -Format "yyyyMMddHHmm").log"
Start-Transcript "$PSScriptRoot\tmp.log" | Out-Null
Start-Setup
Stop-Transcript | Out-Null

Write-Host ""
# Workaround to remove personal data from log file
Get-Content "$PSScriptRoot\tmp.log" | Select-Object -Skip 18 | Set-Content $LogFilePath
Write-Host "Log file created at $LogFilePath"
Remove-Item $PSScriptRoot\tmp.log -ErrorAction SilentlyContinue | Out-Null
Write-Host "Done. You may close this window."
Here's a helper script to install the Custom Unreal Engine (aka NarkEngine) and Unreal Project (aka TresGame) for Kingdom Hearts 3. 🙂 Based on the guide for KH3 uProject and engine installation found at https://github.com/KH3-Modding-Org/OpenKH3Modding/blob/main/uProject%20and%20Engine%20Installation.md#2-github-clone-install---update-with-the-click-of-a-button. 

The script tries to automate process and tries to avoid common pitfalls. Steps (provided by @Narknon):
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

Requirements (will be checked/guided during runtime)
Linked Epic and Github Accounts
git.exe in path
Visual Studio 2017
Plenty of disk space (~20GB)

How to run?
Download ZIP and extract to disk
As it is a download from the Internet, you might need to unblock it via right-click -> Properties before you can run it.
Then run NarkEngine_Install.ps1 by right-click > "Run with PowerShell".
Follow the on-screen prompts closely and it should guide you through.

Known Issues
UnrealBuildTool will fail if VS2017 does not have all necessary modules installed.

To do:
Add verification step for UnrealBuildTool

As it's an "alpha" at this point, I'd be happy to get some feedback. If you run into errors, just send me the console output.
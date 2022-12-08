# NarkEngine_Install.ps1

Here's a helper script to install the Custom Unreal Engine (aka NarkEngine) and Unreal Project (aka TresGame) for Kingdom Hearts 3. 🙂 Based on the guide for KH3 uProject and engine installation found at:
https://github.com/KH3-Modding-Org/OpenKH3Modding/blob/main/uProject%20and%20Engine%20Installation.md#2-github-clone-install---update-with-the-click-of-a-button. 

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

## Requirements (will be checked/guided during runtime)
- Linked Epic and Github Accounts
- git.exe in path
- Plenty of disk space (~20GB)

## How to run?
1) Download the [latest release](https://github.com/Minty123/OpenKH3Modding/releases/latest/download/NarkEngine_Install.zip)
2) Extract archive to disk
3) Run start.bat
4) Follow the on-screen prompts closely and it should guide you through.

Please note: You will be asked to provide elevated permissions during runtime so the components can be installed on your computer. 

## Known Issues
- UnrealBuildTool will fail if VS2017 does not have all necessary modules installed. This should be covered already by previous checks though.

## To do:
- [ ] Add verification step for UnrealBuildTool

## Disclaimer
As it's an "alpha" at this point, I'd be happy to get some feedback. The script generates a log file. If you run into errors, send the file via OpenKH Discord or raise an issue in GitHub.

While the script doesn't do anything else than described above, as always: Use at your own risk.
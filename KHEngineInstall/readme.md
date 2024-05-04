# KHEngineInstall.ps1
(Formerly NarkEngine_Install.ps1)

Here's a helper script to install the Custom Unreal Engine (aka NarkEngine / KHEngine) and Unreal Project (aka TresGame) for Kingdom Hearts 3. 🙂 

The tool automates the steps descibed in the guide for [uProject and Engine installation via GitHub](https://github.com/KH3-Modding-Org/OpenKH3Modding/blob/main/uProject%20and%20Engine%20Installation.md#2-github-clone-install---update-with-the-click-of-a-button). Common pitfalls are checked and avoided.

#### Steps (provided by @Narknon)
1) Select which engine repository to use (NarkEngine / RynEngine / ...). Use NarkEngine if you don't know which one to pick!
2) Check if git is installed or guide users to the DL page
3) Get engine installation Path from user
4) Clone the engine repository to disk
5) Get project installation Path from user
6) Clone the project repository to disk
7) Initalize engine via setup.bat
8) Run generateprojectfiles.bat
9) Register new engine path
10) Switch project to new engine (also generating .sln file)
11) Check for CPU incompatibilities
12) Launch project with new engine

## Requirements (will be checked/guided during runtime)
- Linked Epic and Github Accounts
- git.exe in path
- Plenty of disk space (~20GB)

## How to run?
1) Download the [latest release](https://github.com/KH3-Modding-Org/OpenKH3Modding/blob/main/KHEngineInstall/KHEngineInstall.zip)
2) Extract archive to disk
3) Run start.bat
4) Follow the on-screen prompts closely and it should guide you through.

Please note: You will be asked to provide elevated permissions during runtime so the components can be installed on your computer. 

## Where to get help?
- [Tool Thread on OpenKH Discord](https://discordapp.com/channels/409140906625728532/1038584582016086057/1038584582016086057). Make sure to include the generated log file.
- Or raise an issue in GitHub

## License Info
KHEngineInstall is released under [The Unlicense](https://unlicense.org/). This does not apply to the 3rd party tools, which are downloaded on-demand by the script.
```
This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.

In jurisdictions that recognize copyright laws, the author or authors
of this software dedicate any and all copyright interest in the
software to the public domain. We make this dedication for the benefit
of the public at large and to the detriment of our heirs and
successors. We intend this dedication to be an overt act of
relinquishment in perpetuity of all present and future rights to this
software under copyright law.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

For more information, please refer to <https://unlicense.org>
```
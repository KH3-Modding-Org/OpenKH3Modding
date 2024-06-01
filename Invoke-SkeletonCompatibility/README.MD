# Invoke-SkeletonCompatibility.ps1

A helper to quickly add compatibility between skeletons. It uses UModel and UAssetGUI to extract and manipulate game assets.

**IMPORTANT**: This is in an alpha state. It may or may not work. I want to save it here, so it can serve as a reference in the future. Error handling is still rough around the edges.

**VERY IMPORTANT**: Adjust the constants at the top of the script to your environment...
- ``$GAME_AES_KEY``: The AES Key for the game
- ``$GAME_PAK_PATH``: Path to your pak folder, e.g. "C:\Program Files\Epic Games\KH_3\KINGDOM HEARTS III\Content\Paks"
- ``$UMODEL_BIN_PATH``: Path to the umodel_64.exe, e.g. "C:\DEV\KH3\KH3TK\uModel (BlasterGrim)\umodel_64.exe"
- ``$UASSETGUI_BIN_PATH``: Path to UAssetGUI.exe, e.g. "C:\DEV\KH3\KH3TK\UAssetGUI\UAssetGUI.exe"


## How to run it?
1) Create "AES.txt" in the script root folder. Put only the game's AES key inside. No new lines or anything!
2) Run the script in PowerShell. (Example: Via Rightclick > Run with PowerShell)
3) Enter the screen prompts for target pawn and source pawn

The target pawn's skeleton (uasset+exp) will be in the script root.

You can find pawn IDs at: https://openkh.dev/kh3/pawns.html

## License Info
This code is released under [The Unlicense](https://unlicense.org/). This does not apply to the 3rd party tools which are used but not included.
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
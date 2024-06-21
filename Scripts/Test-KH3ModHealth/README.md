# Test-KH3ModHealth.ps1

This script checks for...
- **ini files** in your mods. These may or may not break achievements in Steam. [Desktop.ini](https://learn.microsoft.com/en-us/windows/win32/shell/how-to-customize-folders-with-desktop-ini) is excluded.
- **conflicting** assets in your mods. Here the last loaded mod wins, commonly determined by the pak filename.

## Requirements
- [Repak](https://github.com/trumank/repak) downloaded and extracted to disk.

## How to run?
1) Download the script and save it to disk.
2) Copy the path to your repak.exe. (e.g. via Shift+Right-Click on it and selecting "Copy as path")
3) Add the path to the top of the script.
4) Copy the path to your ~mods folder.
5) Add the path also to the top of the script.
6) Right-Click the script and select "Run with PowerShell"

The result will be a text file in the script location.

**Please note**: You may need to unblock the script first. To do so, right-click the file, go to properties and select "Unblock" at the bottom of the window.

## License Info
This script is released under [The Unlicense](https://unlicense.org/).

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
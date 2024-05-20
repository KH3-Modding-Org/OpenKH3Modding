# Scaleform Quick Guide
Based on [original notes](https://docs.google.com/document/d/1OJ6guQR7HqA2Gn0SVzfwJzQyAqvKd5z-r3_jDdziF7Y/) by YuriLewd

Scaleform is a middleware used in KH3 to create UIs via Flash SWF files. This guide will only cover how to open the files for editing using the tool JPEXS.

Below you will find a step-by-step description how to save, convert and modify a Scaleform asset from the game files. The steps consist of two parts.

* Part A: [Extracting Scaleform File](#part-a-extracting-scaleform-file)
* Part B: [Opening the file in JPEXS](#part-b-opening-the-file-in-jpexs)

> **Optional**: It is recommended to get started with the [Scaleform Asset Pack in the OpenKH Discord](https://discordapp.com/channels/409140906625728532/1236577285381816373/1236577285381816373). It contains preconverted files for all Scaleform assets and their textures. After downloading and extracting the Scaleform Asset Pack, start at [Part B](#part-b-opening-the-file-in-jpexs).
## Part A: Extracting Scaleform File

1. Open the game files in uModel
2. Save the .uasset and .uexp files of the scaleform asset you want to edit
    - Example here: Title screen at \\UI\\Scaleform\\11_title\\Title
3. Open the .uexp file in a hex editor of your choice like [HxD](https://mh-nexus.de/en/hxd/)
![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/c580eae6-94fe-4284-ac43-202dab16732d)
4. Remove everything before ``GFX``. Backup the removed part in a temp file to re-add it later.
5. Save it as a new file with the file extension ``.gfx``.
![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/776e0016-97cc-43e9-ab2d-5c12012e06b5)

> **Please note**: You can also use the file extension ``.swf``. SWF is a general-purpose Flash format developed by Adobe, while GFX is specifically optimized for Scaleform.

## Part B: Opening the file in JPEXS

1. Download [JPEXS](https://github.com/jindrapetrik/jpexs-decompiler/releases/latest) if you haven't done already.
2. Open your ``.gfx`` file in JPEXS.
3. If you have pop-ups about missing SWF file, select ``no to all``. Normally this should not be an issue. If you import from the [Scaleform Asset Pack](https://discordapp.com/channels/409140906625728532/1236577285381816373/1236577285381816373), say ``yes to all``.
![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/dcdd80a7-2a4e-413e-88bd-01075641670b)
3. Edit it however you want. Note: The details about GFX editing are beyond the scope of this guide.
4. Save your edits and re-pak your file.

    **Option A (Recommended)**: Import it into a TresGame uProject and cook it with the correct settings. For the title scaleform (and probably all others) the settings are:
    ![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/b8d13306-dbb6-4862-9597-43eff82100cf)

    **Option B**:  Instead of cooking it, re-add the hex code that you removed earlier, and change the extension back from ``.gfx`` to ``.uexp``. Be aware that this is known to cause bugs. Also you'll need to fix the serial size in the ``.uassset`` file.

When your asset is ready, pak it up and launch the game to test it. Make sure to use the correct path when paking it, so the original game asset gets replaced.
# Uncooking Game Assets

Shipped game files are cooked and can only be edited using additional tools. If you want to edit them natively in Unreal Engine, you will need to uncook them. This does not work for all asset types.

For further reference see also: https://docs.unrealengine.com/4.27/en-US/WorkingWithContent/CookedContent/

## Prerequisites
This guide assumes you have the latest custom Unreal Engine and TresGame installed. If this is missing, see [KHEngineInstall](../KHEngineInstall/).

## Steps
1. Open uModel and extract the cooked game asset(s) via **Save Packages**. Make sure to check **Keep directory structure**.

2. The target path will contain your extracted assets. Example:
    - \<Export Path\>/Game/Load/Tres/TresItemData.uasset
    - \<Export Path\>/Game/Load/Tres/TresItemData.uexp

3. Copy the ``Game`` folder and its contents into the ``Content`` folder of your TresGame. Example:
    - \<TresGame Path\>/Content/Game/Load/Tres/TresItemData.uasset
    - \<TresGame Path\>/Content/Game/Load/Tres/TresItemData.uexp

4. When opening TresGame in UE, you will see the cooked asset and its data. Cooked assets will not be editable this way.

5. To uncook the asset in UE and make it editable, copy the subfolder(s) of the ``Game`` folder to your ``Content`` root folder.
    - You can do so, by dragging the subfolder to the ``Content`` root folder and selecting **Copy here**

6. You will need to save the new asset, so it won't show a star anymore.

The asset can now be renamed, edited and cooked for further use.

## Supported Asset Types
- Textures
- Datatables
- Effects
- Materials
- ...and more

## Unsupported Asset Types
Unsupported asset types can either not be loaded in UE in its cooked form or otherwise crash the engine/game.
- Blueprints
- Sound Files
- ...and probably more
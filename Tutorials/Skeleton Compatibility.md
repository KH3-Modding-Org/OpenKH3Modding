# Skeleton Compatibility

Steps and description provided by user dh from OpenKH Discord

## About

Some skeletons for whatever reason refuse to use custom animations targeted for them. When retargeting animations for such skeletons, the animation may look fine in UE4, but is distorted in game

insert image

Examples include:

- KH2 Kairi (n\_yt005)
- KH1 Riku (n\_dw202)
- Maskless Vanitas (e\_ex315)
- Yozora (e\_ex781)
- and a lot of the Org to name a few.

The workaround is to enable skeleton compatibility for these skeletons.

With compatibility skeleton parameters, characters with similar skeletons can use the same animations. 

**Example**: All of Sora's models have a compatibility skeleton parameter with his base KH3 skeleton. That way animations can be reused between all variants of the same model and don't have to be retargeted.

For modding, compatible skeletons are used to quickly allow non-Sora characters to use all of his animations and prevent those characters from getting stuck because of animations not targeted to them. The other use is to allow characters that don't like custom animations ported directly onto their skeleton to be usable.

If skeleton compatibility is used for characters with different shape, the animation will be stretched to the compatible skeleton.

insert image

*Figure 2: KH1 Riku (n\_dw202) using idle animation of KH1 Sora (p\_ex001)*

To fix this, animations need to be redone using the replacing characters mesh but referencing the compatible skeleton instead. **Note**: This method does not seem to work for cutscene animations.

## Steps to enable skeleton compatibility

In this example KH1 Riku (*n\_dw202*) will be given skeleton compatibility with KH3 Sora (*p\_ex001*). 

1. Export KH2 Sora's skeleton (*p\_ex011\_0\_Skeleton*) and KH1 Riku's skeleton (*n\_dw202\_0\_Skeleton*), from the game files (e.g. via umodel)
1. Open *p\_ex011\_0\_Skeleton* in the [SoD2 editor](https://github.com/kaiheilos/Utilities)
1. Scroll down in the left panel. In the Skeleton block, select the **SQEX\_CompatibleSkeletonLists** tab, then press **Edit** > **Export Sub**

   insert image

1. Save the file to a location where you can find it later
1. Open *n\_dw202\_0\_Skeleton* in SoD2 editor. Select the **Skeleton** block and press **Edit** > **Import Sub**

   insert image

1. Select the file you exported from Sora. After importing you will see that the new entry does not have any subentries. Do not save yet!

   insert image

1. Select the **Skeleton** block. You will see a new line defining the *SQEX\_CompatibleSkeletonLists* struct. Change its value to: *StructProperty*

   insert image

1. Now save and reopen the file
1. Select **Header List**. Click **Add Data** to add a new row. Scroll down in the right pane and enter: */Game/Character/pc/p\_ex001/mdl/p\_ex001\_0\_Skeleton*

   insert image

1. Select **Linked Classes** and click **Add Data** twice to add two new rows

   insert image

1. In the first new row set the value in the column **Connection*** to: */Game/Character/pc/p\_ex001/mdl/p\_ex001\_0\_Skeleton*
1. In the second new row…
   1. Replace */Script/CoreUObject* with */Script/Engine*
   1. Replace *Package* with *Skeleton*
   1. Enter *p\_ex001\_0\_Skeleton* in the column **Connection**
1. Enter the row number of the first new row in column **Link** (in this example: -6)

   insert image

1. Go to **Block 13: Skeleton > SQEX\_CompatibilityLists >** **SQEX\_CompatibilitySkeletonData**
1. In the row with the property *m\_CompatibleSkeleton*, enter the number of the new skeleton row from the linked classes as a value. (in this example: -7) It will autocorrect to the skeleton’s name.

   insert image

Now whenever you import an animation into Unreal Engine, select Sora's skeleton *p\_ex001\_0\_Skeleton*. UE will warn you about missing bones, but it doesn't matter. Also, make sure to include the modified skeleton in your PAK file.
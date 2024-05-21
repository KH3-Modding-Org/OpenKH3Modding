# Skeleton Compatibility

Steps and description provided by user dh from OpenKH Discord

> **Please note**: This guide describes how to add skeleton compatibility via the Asset Editor. You can also do it via the [Custom Engine](../KHEngineInstall).

## About

Some skeletons for whatever reason refuse to use custom animations targeted for them. When retargeting animations for such skeletons, the animation may look fine in UE4, but is distorted in game

![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/52223f72-f7ed-461b-b676-4c84822be884)

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

![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/2c42e207-4a70-4ae1-aa10-bfc43b328aba)

To fix this, animations need to be redone using the replacing characters mesh but referencing the compatible skeleton instead. **Note**: This method does not seem to work for cutscene animations.

## Steps to enable skeleton compatibility

In this example KH1 Riku (*n\_dw202*) will be given skeleton compatibility with KH3 Sora (*p\_ex001*). 

1. Export KH2 Sora's skeleton (*p\_ex011\_0\_Skeleton*) and KH1 Riku's skeleton (*n\_dw202\_0\_Skeleton*), from the game files (e.g. via umodel)
1. Open *p\_ex011\_0\_Skeleton* in the [SoD2 editor](https://github.com/kaiheilos/Utilities)
1. Scroll down in the left panel. In the Skeleton block, select the **SQEX\_CompatibleSkeletonLists** tab, then press **Edit** > **Export Sub**

    ![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/1b7262c3-cf16-4fb3-b0f2-797d0ad21aaf)

1. Save the file to a location where you can find it later
1. Open *n\_dw202\_0\_Skeleton* in SoD2 editor. Select the **Skeleton** block and press **Edit** > **Import Sub**

    ![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/d8b450c1-9c8f-482f-a2a9-31152b25aa77)


1. Select the file you exported from Sora. After importing you will see that the new entry does not have any subentries. Do not save yet!

   ![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/d2c3ade6-35ef-4ff8-9a9e-82f479567a96)

1. Select the **Skeleton** block. You will see a new line defining the *SQEX\_CompatibleSkeletonLists* struct. Change its value to: *StructProperty*

   ![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/efb2875c-2bef-46f9-95ca-623d0fbb3bce)

1. Now save and reopen the file
1. Select **Header List**. Click **Add Data** to add a new row. Scroll down in the right pane and enter: */Game/Character/pc/p\_ex001/mdl/p\_ex001\_0\_Skeleton*

   ![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/7ebe3c05-102b-4b20-9dfc-2b70d942746c)

1. Select **Linked Classes** and click **Add Data** twice to add two new rows

   ![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/c76a4468-fdd9-42c4-be0d-4a4ea479254c)

1. In the first new row set the value in the column **Connection*** to: */Game/Character/pc/p\_ex001/mdl/p\_ex001\_0\_Skeleton*
1. In the second new row…
   - Replace */Script/CoreUObject* with */Script/Engine*
   - Replace *Package* with *Skeleton*
   - Enter *p\_ex001\_0\_Skeleton* in the column **Connection**
   - Enter the row number of the first new row in column **Link** (in this example: -6)

   ![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/f7294914-1d1f-42ae-913f-90927748a6bc)

1. Go to **Block 13: Skeleton > SQEX\_CompatibilityLists >** **SQEX\_CompatibilitySkeletonData**
1. In the row with the property *m\_CompatibleSkeleton*, enter the number of the new skeleton row from the linked classes as a value. (in this example: -7) It will autocorrect to the skeleton’s name.

   ![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/019cc438-cb45-4b10-9e52-0846f2684f66)

Now whenever you import an animation into Unreal Engine, select Sora's skeleton *p\_ex001\_0\_Skeleton*. UE will warn you about missing bones, but it doesn't matter. Also, make sure to include the modified skeleton in your PAK file.

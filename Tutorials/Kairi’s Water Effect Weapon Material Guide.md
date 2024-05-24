# Kairi’s Water Effect Weapon Material Guide
Content provided by [DaXx](https://www.youtube.com/@daxx2756)

## Requirements

- [SoD2 Asset Editor](https://www.mediafire.com/file/mwpc8cm0342o7ep/SoD2.zip/file)
- Custom built of [UassetGUI](https://www.mediafire.com/file/dayra532z63y5t6/UassetGUI.zip/file)
- My [Custom Water Effect Materials](https://www.mediafire.com/file/euieb6jscy3xj3z/Custom+Water+Mat.zip/file)

It is assumed that you have followed the Custom Weapon guide, or know how to import weapons already for this guide.

[Kingdom Hearts III Modding Tutorial - Custom Weapon Models v3](https://www.youtube.com/watch?v=y0gY-ZY-QU8&t=0s&ab_channel=dallin1016)

Setting up your weapon using this guide will allow for quite a bit of flexibility, and at the same time allow the weapon to work with spawn/despawn and Rage Form.

## Step 1: Model and UV Setup

### Information about the UV’s

You’ll work with both UV channels:

- **``UV_SINGLE``** (responsable for the general texture layout)
- **``EXTRAUVS0``** (UV used to scroll the texture over the Model)
- The **``GREEN Channel``** of your Mask Texture defines the area of the effect.
- The **``BLUE Channel``** of your Mask Texture defines the Metallic effect (Same for the **``RED Channel``**).

**ATTENTION!:** The UV on ``EXTRAUVS0`` gets scrolled **DOWN**, so orientate your UV Layout after that!

To keep it simple, in my example the ``UV_SINGLE`` Channel and the ``EXTRAUVS0`` Channel use the exact same UV Layout.

### Texture and Mask (with UV Layout)

<img width="431" alt="image" src="https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/1a837b82-8cc3-42cb-b69e-8100535905fd">

The left image shows the Diffuse Texture with the UV Layout. The right image shows the Mask for the effect.

The gradient in the right image is fully used by the material, which means that it fades out/in at that point of the model's UV.

**NOTE:** Incase you’re using a different UV Layout for **``UV_SINGLE``** and **``EXTRAUVS0``** keep in mind that the Mask must still be made for the **``UV_SINGLE``** Channel!

## STEP 2: Editing the material W_dx000_mat1

Here the custom build of UassetGUI comes into play. 
1. Set the version in the top right part of the window to 4.17
1. Also make sure your textures have the exact same character length as the once replaced! (ex. w_ko000_0d00)
1. Open **w_dx000_mat1** and go to the **Name Map Section**
1. Edit the highlighted fields to match the location of your **Cooked** textures and do the same for the last highlighted entry except that you’re giving it the Name of your Material Instance (without \_Inst in the end).

    ![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/4e194046-c810-4230-b3dd-0afefb147cdd)

1. Next up scroll all the way down until you see the texture names and do the exact same except that you’re not typing in the full paths this time:

    ![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/04227246-2fae-4f3e-9207-590f90cf41fa)

### w_dx000_mat1_Inst

For this one we are going to use SoD2:

1. In the top right of the Window set the Version to 4.17!
1. Repeat the same steps you did for **w_dx000_mat1** except this time you’ll only find the path to the diffuse texture, the main Material this one is an Instance of and again the Material Instances path on the top in the **Headers List**

    ![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/52fe65a4-4ca4-4563-acde-4255dfbee9b2)

1. After that scroll down and repeat the same steps as for **w_dx000_mat1** once again and Save:

    ![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/5b099aa3-96c6-4ec8-8643-08131c0d0a3c)

## Step 3: Replace your Materials with the edited Materials

After everything above has been done, you’re ready to Pak your mod.

## Final Result

<img width="139" alt="image" src="https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/00bd4a3c-502c-4d66-a09a-7c65824d0e7f">

You can see an example of the applied material at:
<https://www.youtube.com/watch?v=74j2iBSqZQA&ab_channel=DaXx>

Congrats, you’ve done it!

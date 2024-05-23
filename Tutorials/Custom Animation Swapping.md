# Custom Animation Swapping
Based on original notes by Accel and Aproydtix from the OpenKH Discord. This tutorial is subject to change.

# Resources and Prerequisites

- [**Umodel**](https://www.gildor.org/en/projects/umodel)
  - Approximately 70 GB of free disk space if you want to unpack **all** game files
  - (Unpacked Game Files - [QuickBMS Tutorial](https://pastebin.com/3p6B1Xem) courtesy of Normie)
- Autodesk 3ds max
  - Offered by universities for students
  - Aproydtix’s 3ds max scripts (#resources channel in the [openKH discord](https://discord.openkh.dev/))
- OR Blender 2.9 and 2.8 (not yet supported in this tutorial)
- Custom Unreal Engine and TresGame. For an installer see [KHEngineInstall](../KHEngineInstall)
- [**State of Decay 2 Asset Editor**](https://github.com/kaiheilos/Utilities)
- [**UnrealPak**](https://drive.google.com/file/d/1MwnXT_j1UW9VrnQal_DvLiNVRjVjdxmv/view?usp=sharing) **or PatchPack**

Hello and welcome, today we are going to look at how to swap animations to custom animations, specifically, those found already in the game files. **To make them even more custom/original you can take a look at the Advanced Animations with 3ds max (not yet created)**.

# Unpacking Game Files

First up, you will need to unpack our game files. You can either unpack all game files at once using the QuickBMS method or Umodel. Umodel also has the option to unpack only specific files (as well as extract the contents of the .uasset/.uexp files).

We are going to use Umodel primarily since it is also equipped with a model viewer that allows us to look at the models as well as play their animations.

First, download Umodel, open its archive file with 7zip or WinRAR and extract (drag and drop) the contents into your desired location. My preferred location is

**C:\\Program Files\\Epic Games\\KH_3\\KINGDOM HEARTS III\\Content\\Paks**

(The path may differ if you installed the game on another drive and or in a different location)

Once placed, double click on umodel.exe and a window should pop up. The **Path to game files** should default to where the executable is located, if you placed it somewhere else enter the path by clicking on the \[...\] 3 dots button and navigate to your **Paks folder**.

Check the box for **Override game detection** and choose **Unreal engine 4** and **Kingdom Hearts 3** in the drop down menus.

![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/2c53de67-f4bb-46ce-b882-bdeec50f421a)

Hit OK, a new window should appear prompting you to enter the AES key (which was found thanks to [**iAmThatMichael**](https://twitter.com/iAmThatMichael))

**AES Key**: o9Gty60nWTc2OIkbN3lWQ81u6t7W6uUYGvz9fSb2Vpa5SD735c8bsOaTeE2MFJw3

![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/e98f6c00-048c-4bdd-8664-9f31f1db0a47)

Hit Ok again. After loading for a few seconds, a new window should appear.

## Viewing Character Animations

(The next step is used for being able to **watch** ingame animations. If you don’t want to do this, **skip** to the [**extraction step**](#_1h01endbpmtn).)

If you want to unpack all game files, navigate to the top of the directory tree and **right click** on All packages and choose **Save folder packages**.

![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/a96f8da5-410e-4ff7-bdfb-a2a0525f9ff6)

Choose in what directory you want to unpack your game files to but make sure that the **path isn’t too long** (folder1/folder2/folder3/.../Unpacked Game Folder/). If you are unpacking **all** files it’s going to take a while depending on your PC specs (20 min to 3 h), make sure to have at least 70 GB worth of free disk space.

If you want to unpack only **specific** files, navigate to their directory and use the aforementioned process (right click → save folder package). If you want only the animations and models navigate to the **Character** folder.

In our case, we will be using Repliku’s animation for Sora.

The characters are not called by names here but by their **Pawn ID**, to find out which ID corresponds to which character take a look at the [**openKH Pawn List**](https://openkh.dev/kh3/pawns.html).

**Repliku**, for example, is **e_ex313** but only his main story files are located here, for his Limit Cut animations you also have to check **e_ex361**.

![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/27408127-2683-4578-bb50-72535c70055e)

The **anm folder** contains all the animations.

\> **localization**: different animation that are played during the cutscenes

\> **rt/body and face**: different body and face animation during the gameplay/battle

\> **rt_holo_dlc**: animation that are used in the data greeting (they overlap somewhat with gameplay animations)

The **mdl** (model) folder holds the model of the character (and mat0 the materials/textures).

Once you’ve saved the files you can close and open Umodel once again and **navigate now to your saved files**. (The path may differ from yours)

![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/ad24dddd-ae93-458e-a174-b0abfc39bd50)

(If you get a black console window for more than a few seconds this means the path is too long, and you need to shorten it → cut and paste the unpacked game file folder a few folders before and try again.)

![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/c2b1f4e2-5735-462c-a128-7708b6565d2d)

Double click on the model, a new window should pop up.

On the bottom left corner you can see that we got no animations loaded.

![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/25fab41a-eb22-43fc-b4ab-f1aec959698a)

To load them in, press Ctrl+A on your keyboard. To switch between animations you need to press the square brackets \[ \] on your keyboard, depending on your keyboard layout they may be labeled differently

![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/bafc5cce-2cb5-4331-b7b2-f0bf2cd5afe7)

![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/99eaa1aa-b66d-46e0-93bf-827fbfa367be)

![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/1b8bc14e-778c-4ce5-93f5-cc90bd04b094)

The animations are mostly ordered, first being movement and stances related → Being hit and other miscellaneous ones → Story attack animations → Cutscene animations → Limit Cut attack animations. Repliku’s (and most other Organization XIII members’) attack animations begin at 500 (the number in the brackets is the animation ID).

![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/463537af-745c-48b3-a03a-59f648f67667)

A good resource for finding out animation ID’s is the [**KH3 Animation ID’s**](https://docs.google.com/spreadsheets/d/1NUn3B0p2avkyQ5-mbsljsDYuEZfpxRQEyPQAMfB3pNY/) sheet that has documented some animation ID’s (right now we got mostly Sora, Ventus, Repliku, and Vanitas).

If you want to see the animation play you can press the **Spacebar** to let it play once, press **X** to play it in a loop, or **. (Period)** to progress the animation by one frame forward or  
**, (Comma)** to progress the animation by one frame backward. Both Comma and Period can be pressed and held to progress the animation in a slow motion like manner.

Due to Sora’s texturing you may want to press **I** on the keyboard to make his mesh (model) more visible and easier to track during an animation.

![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/3982d856-45e8-4ecc-ac6e-d933d2885d78)

(Pressing **H** shows you the help menu along with other shortcuts.)

![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/1148cb82-e23d-4c42-96c6-8b0ef12f3858)

# Extracting Animations and Models

Once we know which animation we want, we need to extract it (or better yet all of them) from the uasset/uexp file as a psa file.

For that you can hit **O** (as in Omega) on your keyboard to return to the Packages window.

And once again right click on the folder of the character, but this time choose **Export folder content** and choose to what location you want to export it to.

![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/586c8ab5-429b-4947-9b0d-30dc57a447ce)

**What we are definitely going to need is Sora’s model**. So let’s make sure to export it. Our destination folder should now contain a **.config**, **.props**, and a **.psa** for every animation we exported (DO NOT delete them) and **.props** and **.psk** for the model. See path!

![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/7cf50240-9656-4a2d-b450-92091a5a2fa0)

# Setting up Autodesk 3ds max

Next up open Autodesk 3ds max. (I use the 2022 version but it also works with 2020 and others)

Below you can see a **wrench symbol**. **Click on it**, then on **Max Script**, and finally **Run Script**.

![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/691b62bb-7d38-4c84-b86b-00e368c4b8d5)

![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/c3929101-95f9-4604-80a5-d2c9df7b2b97)

A new window will pop up, prompting you to run a script.

![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/7c3059a5-0055-4452-8c3e-e7a7be07b075)

You can get those scripts from the **#resources channel** in the openKH discord server. Download Aproydtix’s 3ds max scripts and drag and drop them into the opened **Choose Editor File** window.

(ActorXAnimConverter is a modified script from [Gildor’s Homepage](https://www.gildor.org/projects/unactorx) for the purpose of KH3 animation modding)

![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/739930e7-4b82-403a-9974-0758878c5456)

Run the ActorXAnimConverter script. Three new windows should appear. Click on **Import PSK** and select Sora’s model (p_ex001_0.psk). (Sora’s model should appear on screen.) Next export it as an **fbx** by clicking on **Export meshes**.

![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/0d92f2aa-fb92-40eb-a769-14497d381812)

![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/696dcf00-e37c-4659-be7c-c140f4336f81)

In the same folder as where your .psk file is located a new folder should have been created which should contain your model as an .fbx file. If there is none click on the \[...\] three dots next to **Path to PSK** (see pic) and enter the mdl folder location, click then on **Export meshes** and check again. If there’s still no FBX folder, import the .psk again and this time click in the top left corner File>Export>Export and export as fbx in an appropriate location you can remember.

![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/22c72d07-3a0c-4786-9f19-b09b85d6de31)

**Import the psk** once more, but this time click on **Import PSA** next and navigate to the animation you want to export, in our case this is going to be 500.psa

![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/d7ba743d-ddde-479a-9089-6e6903d9785e)

You can double click and check to see if it is the correct animation.

![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/3ca68355-6031-4cd4-b489-badde61d6df0)

If you only want this animation exported click on **Export animations**.

If you want all of the animations you extracted to be converted into fbx files, click on **Mass-convertPSA**.

![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/fe6f0dd5-57b7-471a-b72d-7d7c9795cc85)

As with the .psk file, a new FBX folder with the **animation** inside should be in the **same place as your .psa files**, so in Repliku’s folder **NOT** Sora’s.

![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/1f9b5418-a7cf-4d65-8b90-abac667e8637)

# Setting up Visual Studio 2017 & Unreal Engine 4.17.2

Before proceeding make sure you have the KHEngine and TresGame installed. For an installer see [KHEngineInstall](../KHEngineInstall)

Continue here once you have opened ``TresGame.uproject``.

# Importing Animations

Next click on **Show source panel** for easier navigation and create the following folder structure **!!!Capitalisation is important!!!**

**Character>pc>p_ex001>anm>rt>body** inside the p_ex001 folder also create the **mdl** folder

Go into your **mdl folder first** and click on **import**, choose the fbx file that was created from Sora’s mesh (model) which should be called p_ex001_0.fbx if you haven’t renamed it beforehand.

The options should look like in the picture below, you can uncheck ``Import Textures`` if you are ok with Sora being totally grey inside the UE4 editor (he’s going to look normal inside the game).

![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/8b27acf9-481a-4c81-ae6e-16b47a20bdef)

It should now look like this (I moved the materials/textures into another folder for organisation’s sake).

**!!!Make sure that the Skeleton is named:** **p_ex001_0_Skeleton**

![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/84b2292c-316b-461a-ae9e-ec7310a152f1)

Now head into your **body** folder (in the UE4 editor via the Source Panel) and click **Import** here as well. This time navigate into your Repliku folder where you exported his animations to (Repliku\\Game\\Character\\enemy\\e_ex313\\anm\\rt\\body\\FBX) and select 500.fbx

1. Uncheck Import Mesh
2. Select Sora’s skeleton → p_ex001_0_Skeleton
3. Check import animations → Animation Length = Animated Time
4. Uncheck import textures<insert image>

This is how it should look like:
![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/670c85dd-37ec-47e0-a8a4-3057181322c1)

Click on **Import All** (you can import multiple animations at the same time with the same settings to not have to repeat this process needlessly.

# Animations: Root Motion, Animation Speed, Notifies

Since Sora’s attacks have different ID’s, the first thing we are going to do is rename the animation.

![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/baad8247-7b16-4369-8a9e-0b13a363489b)

1301 is the normal first hit without any combo modifiers equipped, you can, however, replace whichever move you want. (Check the [**KH3 Animation ID’s**](https://docs.google.com/spreadsheets/d/1NUn3B0p2avkyQ5-mbsljsDYuEZfpxRQEyPQAMfB3pNY/) sheet or find the ID in the Umodel viewer if you want to replace another animation.)

Next up double click on the animation, a new window should open with the animation playing. On the left side you should **enable Root Motion**, this is necessary so when the character is moved they remain in the place they arrived at at the end of the animation, without it they will ‘warp’ back to where the animation began, also set **Root Motion Root Lock** to **Anim First Frame**. If you want the entire animation to play faster (or slower) ingame, you can change the **Rate Scale** (higher = faster)

![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/179a9af8-68c3-4ad4-849c-258e9b388d73)

# Notifies & Notify States

Now to be able to attack and have fancy effects and whatnot we need to add some **Notifies** and **Notify States** to the animation.

To keep everything organized I recommend creating multiple tracks for different purposes, you can do this by clicking on the plus sign \[+\] next to a track and naming the new track (whatever you want).

![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/7052408d-61ba-4de5-89e5-3f144515dbfe)

Now you need to fill them up, **right click** on the track and choose the appropriate Notify or Notify State. A list of what they do is [further down](#_ossqi7qzz32i).

![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/e2a4f5d5-0a26-46d5-908d-3c33750c6dac)

![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/27108252-b114-4823-abea-c4cff9e7c3b5)

# Individual Notifies

| Tres Anim Notify | Explanation |
| --- | --- |
| Play Particle Effect |     |
| --- | --- |
| Play Sound |     |
| --- | --- |
| Reset Clothing Simulation |     |
| --- | --- |
| Appear End Timing |     |
| --- | --- |
| Attach Effect  <br>![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/7d913f3c-0c34-4408-aba4-e4dd50938ee5)
 | Everything regarding particle effects is going to be done through this notify, swing trails, light beams, keyblade effects, etc.  <br>**Once triggered it continues to play the effect.**  <br>Not to be mistaken for it’s **Notify State counterpart** |
| --- | --- |
| BonamikEnable |     |
| --- | --- |
| Common Timing |     |
| --- | --- |
| Enable Change | Allows you to change the character’s ‘‘state’. The earlier it is placed the earlier your character can **change from one animation to the next**. An example would be the hacker-like ground dodging without any cooldown. Also **enables gravity** so you fall during an air animation, this can be counteracted with the **Traction Notify State** being triggered during an attack. |
| --- | --- |
| Enable Input | Allows inputs, which are only able to be triggered **after Enable Change** has been triggered. This is vital to **make combos possible**, without it Sora will stop after executing your custom animation. |
| --- | --- |
| Face At | Vital for **animations that are combo**s themselves → Ars Arcanum’s automatic combo start. Every time the notify is triggered Sora will change his current position to **face the nearest targe**t/locked on target. |
| --- | --- |
| Fall Start |     |
| --- | --- |
| IKinema Reset | Resets Inverse Kinematics |
| --- | --- |
| Jump Start |     |
| --- | --- |
| Kine Driver Enable |     |
| --- | --- |
| Land Anim Pose |     |
| --- | --- |
| Last Anim Pose |     |
| --- | --- |
| Play Voice | Plays the character’s voice when triggered, you need to set which shout/voiceline should be played and with what probability beforehand. |
| --- | --- |
| Play Weapon Swing SE | Choose one of the swing sounds for the keyblade/weapon during a swing. |
| --- | --- |
| Set Actor Visible |     |
| --- | --- |
| Set Mesh Visible |     |
| --- | --- |
| Set Weapon Visible |     |
| --- | --- |
| Shot | Is responsible for projectiles being fired during animations that allow projectiles. You **can’t fire them during ‘normal’ attacks**, only during ones like the Double Arrowgun Formchange. More Shot notifies = more projectiles. |
| --- | --- |
| Throw Weapon | Used in Keyblade throwing animations but is **NOT the reason for the keyblade being thrown**. The animation for a keyblade throw needs to be done manually (see advanced animation with 3ds max) |
| --- | --- |
| Timing |     |
| --- | --- |
| SQEXSEADAnim Notify Change Audio Volume Enable |     |
| --- | --- |
| SQEXSEADAnim Notify Play Auto Se |     |
| --- | --- |
| SQEXSEADAnim Notify Play Sound |     |
| --- | --- |

# Individual Notify States

| Tres Anim Notify State | Explanation |
| --- | --- |
| Timed Particle Effect | Not recommended to create particle effects with this one, severely limited options. Use Attach Effect instead. |
| --- | --- |
| Trail | Not for keyblade trails. Creates a trail between two bones/sockets but needs a material for that to work. Can be used to create ‘speed lines’ for fast moving limbs. |
| --- | --- |
| Attach Effect  <br>![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/e6e2c849-02da-43dd-8588-0d91c2d34a83)
| Everything regarding particle effects is going to be done through this notify, swing trails, light beams, keyblade effects, etc.<br><br>Can be scaled → Plays for a set amount of frames. |
| --- | --- |
| Attack | Allows hitboxes to be utilized.  <br>**Collision Grp Name** determines the hitbox **shape** → KB_Stick, KB_Sphere, etc.<br><br>  <br>**M Attack Data IDName** determines the **damage**, damage type, how much RV is added, etc.<br><br>List can be found below. |
| --- | --- |
| Bp Event |     |
| --- | --- |
| IK  | Inverse Kinematics: make sure that the animation |
| --- | --- |
| Look At | For enemy AI |
| --- | --- |
| Traction | **Reduces** the character’s **traction** and allows them to **move further** towards the direction they are attacking towards. Best used before and during an attack. Making it too long for ground animations will make it look like the character is sliding along the ground. |
| --- | --- |
| Turn to Target | For enemy AI |
| --- | --- |
| SQEXSEADAnim Notify State Attach Sound |     |
| --- | --- |
| SQEXSEADAnim Notify State Change Auto SeEnable |     |
| --- | --- |
| SQEXSEADAnim Notify State Play Auto Se |     |
| --- | --- |

## Attack Notify State

**Collision Grp Name**: The shape of the hitbox (Sticks, Spheres, etc.)

**M Attack Data IDName**: Damage type and properties associated with it

**Interval**: How quickly the Attack can inflict damage. (Lower = attack hits more often in the same time)

**M B Override Hit Effect**: Changes the hit effect of the keyblade attack to another one

**M Hit SEAsset**: ???

**M Weapon Hit SEAlias ID**: Changes the hit sound when an enemy is struck

**M B Override Hit Effect Color/Alpha**: Changes the color and emission (glow) of the hit effect (not the star color from keyblade hits)

**M B Take Over Hit List**: ???

**M Take Over Hit List Grp Name**: ???

**M B Ignore Combo Count Up**: ???

**M Combo Count Up Param**: ???

![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/328d2ca9-4a3a-4af7-b4cc-e79e7e22b5df)

Most of **Sora’s Collision Grp Names** are saved in the KeybladeBase (uasset/uexp) while the ones from his formchanges are distributed over the different keyblades themselves (90% of those don’t work at all, while 10% work under specific circumstances). The Collision Grp Names and Attack Data IDNames can be found here [**Hitbox and Damage Types Sheet**](https://docs.google.com/spreadsheets/d/1iXNVMLokvZNVD0E1Tro80d729n7rVSHSufuEf1FFXJM/)**.**

## Attach Effect Notify/ Notify State

The easiest of effects has to be the keyblade trail.

![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/e942c82e-b6d7-4492-ae88-5611cf68d8bf)

![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/c7843901-8dc3-4dff-a45d-f8deec3c3a08)


In the **Attach Data List** row click on the \[+\] plus sign to create a new array. Next check the box for **Use Common Attach Data** choose an **Attach Type**: Weapon, RH Weapon (right hand weapon), LH Weapon (left hand weapon), All Weapon. And finally assign R_wep_skt as the **Socket Name**.

There are numerous effects that all behave differently, an easy way to replicate an effect or use an effect as reference for your customized effects, is to open an animation via the **State of Decay 2 Asset Editor** (even though it was not intended for KH3 thanks anyways Kai Hailos)

For our effect to be referenced in the file we have to make sure to create a ‘dummy’ reference file first. In the **Header List** we can see where the effect is supposed to be **located**, this is a folder hierarchy you need to recreate in UE4, and create a particle effect with the same name there.

![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/ebd708fc-90e7-47e2-b88c-1608de88c092)

Go to the UE4’s Source Panel and into the Content folder and create the following folder structure **Effects/dlc02/pc/attack/par** (the path may differ if your chosen effect is located in another subfolder).

![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/841f4b71-682c-4a44-9156-0d3334b177c9)

Right click inside the **par** folder and select **Particle System**. Rename the NewParticleSytem to your effect name, in our case this is **vp_rad_sho00**.

![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/9768ce6a-d72c-435d-8fb8-5da6495be649)

Now head back to your animation to add the effect via the Attach Effect Notify (State).

![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/936592e3-ac8c-43e3-a0bf-4452b501ea76)

The original settings can then be replicated in UE4.

Add array elements by clicking on the \[+\] signs and copy the settings of the effect from whichever animation you are looking to replicate.

![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/4e422bd9-eab6-4cf4-96d2-33da7b45910f)

![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/de59d7dd-0697-48ef-8ec3-b0fa0d4b97d7)

A few options are explained here:  
For the socket you are free to choose whatever bone you want the effect to attach to but you will generally find it to be attached to **vfx_root**, **X_effect**, **R_wep_skt**, and **center** most of the time.

![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/49293446-bab7-434d-bdfa-9652956f4654)

The bones may have different rotations and locations, so you may need to rotate the effect accordingly and adjust the location.

![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/08f56607-0f2e-4ad9-a592-5bcc2238c628)

Most of the effects will have their **Scale Offset** set to 1, increasing it increases the **size** of the particle effect. The same goes for **Particle Color**, they are in the **RBG** format (**XZY**), increasing the X value increases the amount of red, setting all colors to zero will either make the particle black or it won’t appear at all. **Particle Alpha** determines the **emission (glow)** of the particle, the higher it is the ‘brighter’ the particle becomes, inversely setting it to 0 will make the particle effect have no emission and the effect will most likely appear as a ‘flat’ model.

Particle Effects have a ‘cooldown’ that can be circumvented by checking the box for **Play Number**.

Setting the **Attach Effect Type** from **Loop End** to **Fade Out** will immediately destroy the Particle Effect upon the animation finishing or being interrupted.

Some effects have a **Group ID** assigned such as the **Dark Form**/ **Light Form** particle effects, this is because they are handled both by one animation file and therefore it is needed to be known by the game on which of those two to call. If you are creating a Base Form animation and want to utilize the particle effect you do **NOT** want to replicate this Group IDs as it will then only play the effect when in the respective form.

You can fill whatever you want into the **description field**, I call them by a name that reminds me what the particle effect is for.

I have not encountered any negative consequences from using a different **Guid number** than the one shown in the original effect, so you may leave them be.

My personal recommendation at which particle effects to look at would be the Dark/Light Form dodge, Rage Form Dodge and any of the Re:Mind Abilities.

## Play Voice

The same process as for the Attack Notify State can also be applied for Play Voice Notifies.

![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/9a0781ed-8d54-45d5-aa99-8e964b348e03)

While the pictures haven’t been updated, you need to use a special sound class for sounds to work correctly, [courtesy of YuriLewd](https://discord.com/channels/409140906625728532/828067806284611615/865971359582388244). Use the “ja” path, not “en” as depicted.

![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/69f33f91-fcd8-42fd-b9cd-1c77b6143533)

![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/1f8dac31-dcf1-46b9-9cc8-6831832b7e09)

In the Notify Details tab of the Play Voice Notify, add however many shouts/grunts you want to play by clicking on the \[+\] plus symbol. Choose which sound is supposed to play and assign it a random weight (probability how likely it is to be played) the sum of all weights should total 100.

![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/fb2a8feb-e07e-4617-8cca-4711912bad3b)

# Notify/Notify State Setup Examples

A simple move might look something like this once finished, note however that TresFaceAt is only used for demonstration purposes and is mostly used in animations that are combos themselves (similar to the automatic combo beginning of Ars Arcanum).

![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/e64c7fca-20f1-401e-854d-6ea46b3a64f0)

An animation with multiple attacks every 4-5 frames.

![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/7223f6c9-923e-4522-9a93-99730600ca73)

# Cooking and Packing
> Todo: Create dedicate packing tutorial.

Once you’re done with the animation you want to click on **Save All** and cook the animation.

![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/38e0d4cf-7201-4f13-87b1-f58db118db23)

(If you see an asterix (*) on the animation means there are unsaved changes)

Either of these options work.

<insert image>

After saving it go to the left upper corner and click on **File** and select **Cook Content for Windows**

![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/0c32fc31-2678-4727-a324-dcd93891c2ba)

In the bottom right corner a notification should appear

![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/8ef9973c-fff5-4cb8-91a5-8cbd2f3dcb6d)

Which should turn to this after a few seconds (there’s always a weird sound when it finishes cooking.)

![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/d41a962e-a2a2-43fb-8ee9-e0f369703811)

You will find your cooked files in  
**\\Documents\\Unreal Projects\\TresGame-main\\Saved\\Cooked\\WindowsNoEditor\\TresGame\\Content\\Character\\pc\\p_ex001\\anm\\rt\\body**

![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/e68cca2f-e13d-48ad-aa46-165e7daf311f)

Those are the files you want to package, **NOT** the ones in the **mdl** folder

![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/bf484181-c5c3-4385-b9c6-4695377dcc29)

I use UnrealPak to package my files

![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/40925a50-0cee-40ac-957c-24d30271cafd)

Drag and drop the folder with your animation files onto the batch file

![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/9640f0d5-4134-4af9-a2e7-1b326f10ecfa)

And a new .pak file should be generated.

![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/0c0609d8-288c-48de-b55b-27221ad5aff7)

Place it in your **~mods** folder located in your **Paks folder** (if you don’t have one create it now)

![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/39d4c028-4579-48b5-8508-ed2fe812820c)

Start the game and test your animation, if the effect isn’t playing you might have forgotten to put the dummy reference in the par folder. If the effect is at ground level, adjust the coordinates for it.

This is a process that’s going to be repeated numerous times until everything looks d e c e n t  e n o u g h.

![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/4939a432-a573-4c1b-b60e-deea500ecff1)

# Special Thanks
- To **Luseu** for teaching me how to use in-game animations and make attack animations possible.
- To **Aproydtix** for creating the 3ds max scripts and coding some of the now often used Notifies.
- To **Truebladeseeker**, **Nozai**, **Millioti/Jeff**, **YuriLewd**, and various other people of the openKH community I haven’t mentioned for their ideas, support, and help.

# Additional Pictures

![image](https://github.com/KH3-Modding-Org/OpenKH3Modding/assets/6775975/70d73d5f-eeed-4ae8-a031-669ed6c81b63)

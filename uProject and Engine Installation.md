# uProject and Engine Installation Instructions

### See [option 1](/uProject%20and%20Engine%20Installation.md#1-standard-install---no-easy-updating) for standard install, or [option 2](/uProject%20and%20Engine%20Installation.md#2-github-clone-install---update-with-the-click-of-a-button) for install along with Github desktop to allow for easy updates.  Be sure to install any missing [prerequisites](/uProject%20and%20Engine%20Installation.md#prerequisites) first.  See [section 3](/uProject%20and%20Engine%20Installation.md#3-troubleshooting) for troubleshooting.

I highly recommend following option 2, as you can update with the click of a button and updates will only download changed files.  Further, you can even backup your project to a private branch of the uproject.  Only you and those you add as collaborators can access a private branch, and if your harddrive is ever lost, or you lose/break a file, you can always revert to an old commit and restore it!


## Prerequisites

### Link Epic and Github Accounts

If you have not done so already, follow the instructions here to create and link a Github account to an Epic Games account: https://www.unrealengine.com/en-US/ue-on-github


### Install Visual Studio 2017

Download and install Visual Studio 2017.  It can be found here (https://my.visualstudio.com/Downloads?q=visual%20studio%202017&wt.mc_id=o~msft~vscom~older-downloads), and you should download the "Community" version (Visual Studio Community 2017 (version 15.9)).  You may need to log in to a Microsoft account to access this link.

If you are installing for the first time, be sure to include the below options.

### VS - C++ Tools

To add C++ tools to your VS installation, make sure you select Game development with C++ under Workloads, as well as these additional options.


    C++ profiling tools


    C++ AddressSanitizer (optional)


    Windows 10 SDK (10.0.18362 or Newer) 

### VS - Include the UE Installer
To include the UE installer when installing VS, locate the Summary sidebar on the right, expand Game Development with C++, and under Optional, make sure the checkbox for Unreal Engine installer is checked to enable it. 

![image](https://user-images.githubusercontent.com/73571427/176460487-8654e419-2dc4-4cb3-8e67-314c558492b5.png)



# 1. Standard Install - No easy updating


Proceed to the links https://github.com/narknon/TresGame/tree/TresGame-Built and https://github.com/narknon/UnrealEngine-CEEnd/tree/KHEngineBuilt.  The branch selection should say the following for each: ![image](https://user-images.githubusercontent.com/73571427/176455859-17346cd2-4cfb-4c6d-8c7d-dfbb8bec563e.png)
and ![image](https://user-images.githubusercontent.com/73571427/176455900-35dcc82f-81b4-43cd-b888-24e5185f959a.png), respectively.


Click on the green arrow to the right, and select download zip.

![image](https://user-images.githubusercontent.com/73571427/176456031-7dd76359-dce9-4ac4-9a10-616bae4552e4.png)


Once the downloads are complete, extract each to separate folders (I personally prefer not to use Desktop or Documents for Unreal installs, and instead install on root of my drive, or close to root).

### Engine

Once extracted, rename the engine folder (KHEngineBuilt) to whatever you would like just to ensure that the path to the files is not gigantic.


Inside the engine root folder (not the /Engine/ folder within the downloaded folders), double click the file named Setup.bat.  Wait for this to complete.  At the very end of its process, it will pop-up a Windows Elevated rights request in the background, so be sure to check your taskbar and select and allow the elevation.


Following that, run GenerateProjectFiles.bat.  This should finish much quicker, and exit without prompting once it is complete.

Finally, navigate to find the UnrealVersionSelector-Win64-Shipping.exe at the following path: \Engine\Binaries\Win64\UnrealVersionSelector-Win64-Shipping.exe.  Double click this file. It will then ask if you wish to register the directory as an Unreal installation.  Select yes.  It should then say registration succesful.

![image](https://user-images.githubusercontent.com/73571427/176457712-115965b1-d260-4845-83c9-d77dcf127e10.png)


### uProject

Inside the folder to which you extracted the project, find the TresGame.uproject file.  Right click on this file, and select "Switch Unreal Engine Version".  If you correctly registered the engine directory as an Unreal directory, it should simply appear in the dropdown.  If it does not appear automatically, click the three dots to the right of the path. Navigate to the folder to which you extracted the engine, and select the root folder (i.e., the folder that contains the setup.bat file).

![image](https://user-images.githubusercontent.com/73571427/176458008-307cc67f-0122-4a1b-9025-964c3592c8c1.png)


![image](https://user-images.githubusercontent.com/73571427/176459346-7e40b7bd-ab8d-4e81-8866-e6acc9394b79.png)



Following this, the uproject should generate a .sln file.  If this file does not generate, something went wrong.  Try right clicking on the TresGame.uproject again, and this time select "Generate Project Files."  If the .sln still does not generate, something else is happening.  Navigate to your Saved/Logs folder to find a file titled unrealversionselector-2022.06.29-09.16.08.log (the date will be the current date/time), and check to see what the error was, or post the file in the #kh3-modding channel on the discord for help. 


If the .sln did generate, you're done!  Double click on the TresGame.uproject to launch the project!

### Done!




# 2. Github Clone Install - Update with the click of a button


### Additional Prerequisites

Github Desktop: https://desktop.github.com/ (install with defaults, being sure to include any options relating to adding GIT as an environmental variable/path.)
Git CLI: https://git-scm.com/downloads (install with defaults, being sure to include any options relating to adding GIT as an environmental variable/path.)


### Engine

Create a folder in which you would like to install the engine (I personally prefer not to use Desktop or Documents for Unreal installs, and instead install on root of my drive, or close to root).

Open the folder, hold Shift, and Right Click.  The Right Click context menu should include the option "Open Powershell Window Here".  Select this option.

![image](https://user-images.githubusercontent.com/73571427/176466757-96a88aaa-bd02-4248-b0be-9a1072472ee2.png)


A new console window should then open. 

Copy/paste the below command into the console window.

    git clone --branch KHEngineBuilt --single-branch https://github.com/narknon/UnrealEngine-CEEnd.git
    
    
Wait for the download to complete based on the output in the console window.

![image](https://user-images.githubusercontent.com/73571427/176467360-19c69562-6564-48e1-aa7a-8c3d21324c1a.png)


Once completed, rename the engine folder (KHEngineBuilt) to whatever you would like just to ensure that the path to the files is not gigantic.


Inside the engine root folder (not the /Engine/ folder within the downloaded folders), double click the file named Setup.bat.  Wait for this to complete.  At the very end of its process, it will pop-up a Windows Elevated rights request in the background, so be sure to check your taskbar and select and allow the elevation.


Following that, run GenerateProjectFiles.bat.  This should finish much quicker, and exit without prompting once it is complete.

Finally, navigate to find the UnrealVersionSelector-Win64-Shipping.exe at the following path: \Engine\Binaries\Win64\UnrealVersionSelector-Win64-Shipping.exe.  Double click this file. It will then ask if you wish to register the directory as an Unreal installation.  Select yes.  It should then say registration succesful.

![image](https://user-images.githubusercontent.com/73571427/176457712-115965b1-d260-4845-83c9-d77dcf127e10.png)


### uProject

Create a new folder that is not within the engine folder to which you would like to install the uProject.

Open a new powershell window from within this new folder.  Paste the below command into the powershell window

    git clone --branch TresGame-Built --single-branch https://github.com/narknon/TresGame.git\
    
    
Wait for the download to complete based on the output in the console window.  This should be much quicker than the engine download.

Once complete, find the TresGame.uproject file in this folder.  Right click on this file, and select "Switch Unreal Engine Version".  If you correctly registered the engine directory as an Unreal directory, it should simply appear in the dropdown.  If it does not appear automatically, click the three dots to the right of the path. Navigate to the folder to which you extracted the engine, and select the root folder (i.e., the folder that contains the setup.bat file).


![image](https://user-images.githubusercontent.com/73571427/176458008-307cc67f-0122-4a1b-9025-964c3592c8c1.png)


![image](https://user-images.githubusercontent.com/73571427/176459346-7e40b7bd-ab8d-4e81-8866-e6acc9394b79.png)


Following this, the uproject should generate a .sln file.  If this file does not generate, something went wrong.  Try right clicking on the TresGame.uproject again, and this time select "Generate Project Files."  If the .sln still does not generate, something else is happening.  Navigate to your Saved/Logs folder to find a file titled unrealversionselector-2022.06.29-09.16.08.log (the date will be the current date/time), and check to see what the error was, or post the file in the #kh3-modding channel on the discord for help. 


If the .sln did generate, you're done!  Double click on the TresGame.uproject to launch the project!

### Done!


# 3. Troubleshooting

If your problem is not solved by the below, then navigate to Saved/Logs for both your uProject folder, your engine folder, and the automation tool (see below paths), and request help in the server by sending the relevant logs from each.

{EngineFolderRoot}\Engine\Saved\Logs

{EngineFolderRoot}\Engine\Programs\AutomationTool\Saved\Logs

{EngineFolderRoot}\Engine\Programs\UnrealHeaderTool\Saved\Logs

{ProjectFolderRoot}\Saved\Logs


### Installation was succesful and .sln generates, but project won't launch.

The most common reason for this issue is that Unreal Engine has a bugged interaction with ssl services and may not be properly find the path to the prerequisites for http.  To fix this, we will add the path as an environment variable manually.  If you do not know how to add an environment variable to your OS, see [here](https://www.twilio.com/blog/2017/01/how-to-set-environment-variables.html).

Create an environment variable with the name “OPENSSL_ia32cap” and the value “:~0x20000000d” (both without quotes).  Try launching again.



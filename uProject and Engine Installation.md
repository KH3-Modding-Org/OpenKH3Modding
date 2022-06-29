# uProject and Engine Installation Instructions

### See 1 for standard install, 2 for install along with Github desktop to allow for easy updates.  See 3 for troubleshooting.

## Prerequisites


If you have not done so already, follow the instructions here to create and link a Github account to an Epic Games account: https://www.unrealengine.com/en-US/ue-on-github


Download and install Visual Studio 2017.  If you are installing for the first time, be sure to include the below options.

### C++ Tools
To add C++ tools to your VS installation, make sure you select Game development with C++ under Workloads, as well as these additional options.


    C++ profiling tools


    C++ AddressSanitizer (optional)


    Windows 10 SDK (10.0.18362 or Newer) 

### Include the UE Installer
To include the UE installer when installing VS, locate the Summary sidebar on the right, expand Game Development with C++, and under Optional, make sure the checkbox for Unreal Engine installer is checked to enable it. 

## 1. Standard Install - No easy updating


Proceed to the links https://github.com/narknon/TresGame/tree/TresGame-Built and https://github.com/narknon/UnrealEngine-CEEnd/tree/KHEngineBuilt.  The branch selection should say the following for each: ![image](https://user-images.githubusercontent.com/73571427/176455859-17346cd2-4cfb-4c6d-8c7d-dfbb8bec563e.png)
and ![image](https://user-images.githubusercontent.com/73571427/176455900-35dcc82f-81b4-43cd-b888-24e5185f959a.png), respectively.


Click on the green arrow to the right, and select download zip.
![image](https://user-images.githubusercontent.com/73571427/176456031-7dd76359-dce9-4ac4-9a10-616bae4552e4.png)


Once the downloads are complete, extract each to separate folders (I personally prefer not to use Desktop or Documents for Unreal installs, and instead install on root of my drive, or close to root.

### Engine

Once extracted, rename the engine folder (KHEngineBuilt) to whatever you would like just to ensure that the path to the files is not gigantic.


Inside the engine folder, double click the file named Setup.bat.  Wait for this to complete.  At the very end of its process, it will pop-up a Windows Elevated rights request in the background, so be sure to check your taskbar and select and allow the elevation.


Following that, run GenerateProjectFiles.bat.  This should finish much quicker, and exit without prompting once it is complete.

Finally, navigate to find the UnrealVersionSelector-Win64-Shipping.exe at the following path: \Engine\Binaries\Win64\UnrealVersionSelector-Win64-Shipping.exe.  Double click this file. It will then ask if you wish to register the directory as an Unreal installation.  Select yes.  It should then say registration succesful.
![image](https://user-images.githubusercontent.com/73571427/176457712-115965b1-d260-4845-83c9-d77dcf127e10.png)


### uProject

Inside the folder to which you extracted the project, find the TresGame.uproject file.  Right click on this file, and select "Switch Unreal Engine Version".  If you correctly registered the engine directory as an Unreal directory, it should simply appear in the dropdown.  If it does not appear automatically, click the three dots to the right of the path. Navigate to the folder to which you extracted the engine, and select the root folder (i.e., the folder that contains the setup.bat file).

![image](https://user-images.githubusercontent.com/73571427/176459346-7e40b7bd-ab8d-4e81-8866-e6acc9394b79.png)


![image](https://user-images.githubusercontent.com/73571427/176458008-307cc67f-0122-4a1b-9025-964c3592c8c1.png)


Following this, the uproject should generate a .sln file.  If this file does not generate, something went wrong.  Try right clicking on the TresGame.uproject again, and this time select "Generate Project Files."  If the .sln still does not generate, something else is happening.  Navigate to your Saved/Logs folder to find a file titled unrealversionselector-2022.06.29-09.16.08.log (the date will be the current date/time), and check to see what the error was, or post the file in the #kh3-modding channel on the discord for help. 


If the .sln did generate, you're done!  Double click on the TresGame.uproject to launch the project!


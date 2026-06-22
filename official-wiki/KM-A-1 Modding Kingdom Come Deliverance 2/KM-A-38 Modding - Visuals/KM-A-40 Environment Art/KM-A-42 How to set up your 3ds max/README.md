# How to set up your 3ds max
In effort to make the modding as accessible as possible we are publishing the rools required for example to export an asset or to create it. Here is step-by-step guide how to **enable** and/or **disable** our tools in 3ds Max installation.

## **First find these folders on your machine**

`{max installation}` = `c:/program files/autodesk/3ds max/3ds max 20??`

`{local max files}` = `c:/users/your.name/appdata/local/autodesk/3dsmax/20?? - {32|64}bit/enu`

`{path to installation}` = `Path to where Steam installed your modding tools.`

You may need to do a little bit searching for these folders if you have installed your 3ds Max into a non-standard location.

## **How to enable our tools**

1. Update to **3ds Max 2021.1** if you have not done so already.

2. Open 3ds Max and go to **Customize/Configure User and System Paths** and under **3rd Party Plug-Ins** click **Add** and find your plugin folder. The location will look like this: `{path to installation}/Tools/`**`enviro`**`/3dsmax/v23/native_plugins`

3. Click **Use Path**.

4. Quit 3ds Max.

5. Copy `{path to installation}/Tools/modding/3dsmax/scripts/LoadWHMaxTools.ms` to `{max installation}/scripts/startup`.

6. Copy `{path to installation}/Tools/modding/3dsmax/v23/libs/libgmp-10.dll`
   and `{path to installation}/Tools/modding/3dsmax/v23/libs/gmp-10.dll` to `{max installation}`.

7. Run `{path to installation}/Tools/SettingsMgr.exe` to setup CryEngine Exporter path.

8. Run 3ds Max and the tools should be working properly.

   (if max still have problem find plugins, copy files **gmp-10.dll** and **libgmp-10.dll** from folder ***{path to installation}\Tools\modding\3dsmax\v23\libs*** to folder **C:\Windows\System32**. It should work now.)

## **How to disable our tools**

If our tools cause problems for you, you can disable them.

1. Open 3ds Max and go to **Customize/Configure User and System Paths** and under **3rd Party Plug-Ins** click **Delete** for any item that points to our WH files (`{path to installation}`)
2. Delete `{max installation}/scripts/startup/LoadWHMaxTools.ms`.
3. Also delete the local files in `{local max files}/temp/wh`. Delete the whole folder.
4. Delete`{max installation}/gmp-10.dll` and `{max installation}/libgmp-10.dll`.
5. Now your 3ds Max should be WH-free.
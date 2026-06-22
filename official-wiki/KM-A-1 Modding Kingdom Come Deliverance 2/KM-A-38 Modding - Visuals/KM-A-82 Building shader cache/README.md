# Building shader cache
Shader source code is located in Engine/Shaders.pak. If you want to modify these shaders, the game will need to recompile all of them on start. KCD2 does not include a shader compilation step, as all the shaders are shipped precompiled. You also can precompile your shaders, if you choose to change them.
This requires several steps:
1. Copy **Tools\modding\USER_ShaderCacheGen** and  to modding tools root
Your folders should look like this:
```
KCD2Mod
├ Bin
├ Data
├ Editor
├ Engine
├ ...
└ USER_ShaderCacheGen
│ ├ ...
│ ├ Shaders
│ │  ├ cache
│ │  │  └ D3D12
│ │  │    ├  PipelineStateBinCache.txt
│ │  │    ├  RenderPassBinCache.txt
│ │  │    ├  ResourceLayoutBinCache.txt
│ │  │    └  VertexFormatBinCache.txt
│ │  └ ShaderList.txt
│ └ ...
├ ...
└ system.cfg
```
2. Replace *system.cfg* with following settings:
```
sys_no_crash_dialog=1
log_IncludeTime=3
log_Verbosity=3
log_FileVerbosity=3
r_driver=DX12
sys_game_folder=Data
r_ShadersAsyncCompiling=0
r_ShadersAsyncMaxThreads=16
r_multithreaded=0
r_ShadersSubmitRequestline=0
r_PipelineStatePrecacheMode=3
sys_intromoviesduringinit=0
```
3. Temporarily rename *Bin/Win64ReleaseSteamLTO_DLL* to *Bin/Win64ReleaseAssertLTO_DLL* (this step is no longer needed since 1.3)
4. Run 
```
Tools\ShaderCacheGen\ShaderCacheGen.exe /PrecacheShaderList -remoteShaderCompilerIp 127.0.0.1
```
(the IP after -remoteShaderCompilerIp doesn't matter, it is not used, the parameter is needed. Since 1.3, it is no longer needed)
The program runs in the background, with no indication of progress. It generates shadercachegen.log, so watch that to see the progress
5. Make sure your engine folder either doesn't contain Shaders/ folder, or contains ALL shaders (if you only include those that you have changed, step 5 will fail - it needs all of it's files in PAK, or all of them unpacked)
6. Run the Resource Compiler to create shader paks:
```
Tools\rc\rc.exe /jobtarget=ShadersAll /OutputPath=.\EngineMod /CryPakPlatform=D3D12 /crashOnAssert /zip_encrypt=0 /Streaming=1 /IsShaderDebug=0 /p=pc /job=Tools\rc\RcJob_WH.xml
```
This will create ShaderCache.pak, ShaderCacheStartup.pak, Shaders.pak and ShadersBin.pak in EngineMod folder

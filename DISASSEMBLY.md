[中文](#中文)
# How to Find the Address of gEnv
Open WHGame.dll with IDA, using the format `Portable executable for AMD64(PE) [pe.dll]`
IDA will analyze the file. If the following steps cannot proceed, you may need to wait for the analysis to complete (it could take several hours)
1. Search for the string `'exec autoexec.cfg'` in the .rdata section or press `G` to jump to `aExecAutoexecCf`
2. Click to select `aExecAutoexecCf`, right-click and choose `jump to xref to operand...` or press `x` to jump to the reference
3. There should be only one reference. Above the reference line, there should be `mov     rcx, cs:qword_1848A7C68` or similar code
4. `qword_1848A7C68` is the offset address of `gEnv->pConsole`. The base address for x64 Windows DLL is `0x180000000`, so the address offset of `gEnv->pConsole` is `0x48A7C68`
5. After knowing the address of pConsole, we can calculate the address of `gEnv` through the offset of pConsole in `gEnv`, thereby finding the addresses of all associated components
6. However, `0x48A7C68` is not fixed and may change after game updates, so we need to find the address of `gEnv->pConsole` through byte pattern search
7. By analyzing the hexadecimal and assembly code of the line `mov     rcx, cs:qword_1848A7C68` and subsequent lines (you can throw it to AI to help find the SIG), we can get `SIG = "48 8B 0D ?? ?? ?? ?? 48 8D 15 ?? ?? ?? ?? 45 33 C9 45 33 C0 4C 8B 11"`
8. During game runtime, find the actual value of `qword_1848A7C68` through byte pattern search targeting `WHGame.dll`, and use RIP relative addressing to find the address of `pConsole`
9. pConsole is the 22nd member of gEnv, with an offset of 21 pointers forward, 21 * 8 = 168 = 0xA8. Subtract 0xA8 from the address of `pConsole` to get the address of `gEnv`, and then find the addresses of all associated components by adding the offset to the address of `gEnv`

You can refer to my other project [kcd2db](https://github.com/muyuanjin/kcd2db)

# Verified Offsets (Game Version V1.2.2)
1. `gEnv->pScriptSystem`: Most offsets of gEnv are consistent with [ISystem.h](CryEngine/Code/CryEngine/CryCommon/CrySystem/ISystem.h#L781), it is the 6th member, offset 5x8 bytes = 0x28
2. `gEnv->pGame`: Same as above, it is the 19th member, offset 18x8 bytes = 0x90
3. `gEnv->pConsole`: Same as above, it is the 22nd member, offset 21x8 bytes = 0xA8
4. `gEnv->pScriptSystem->CreateTable()`: Inconsistent with the source code [IScriptSystem.h](CryEngine/Code/CryEngine/CryCommon/CryScriptSystem/IScriptSystem.h#L283), CreateTable is the 14th virtual function of `IScriptSystem`, not the 13th, there is an unknown virtual function, so the offset is 13x8 = 0x68
5. `gEnv->pScriptSystem->CreateTable()->AddFunction()` Inconsistent with the source code [IScriptSystem.h](CryEngine/Code/CryEngine/CryCommon/CryScriptSystem/IScriptSystem.h#L616), AddFunction is the 23rd virtual function of `IScriptTable`, not the 22nd, there is an unknown virtual function, so the offset is 22x8 = 0xB0
6. `gEnv->pGame->GetLongName()` Inconsistent with the source code [IGame.h](CryEngine/Code/CryEngine/CryCommon/CryGame/IGame.h#L112), it is the 13th virtual function, offset is 12x8 = 0x60
7. `gEnv->pGame->GetName()`  Inconsistent with the source code [IGame.h](CryEngine/Code/CryEngine/CryCommon/CryGame/IGame.h#L115), it is the 14th virtual function, offset is 13x8 = 0x68
8. `gEnv->pGame->GetIGameFramework()` Inconsistent with the source code [IGame.h](CryEngine/Code/CryEngine/CryCommon/CryGame/IGame.h#L128), it is the 17th virtual function, offset is 16x8 = 0x80
9. `gEnv->pGame->GetIGameFramework()->RegisterListener()` Inconsistent with the source code [IGameFramework.h](CryEngine/Code/CryEngine/CryCommon/CryGame/IGameFramework.h#L108), it is the 101st virtual function, offset is 100x8 = 0x320

<a name="中文"></a>
# 如何找到gEnv的地址
使用IDA打开WHGame.dll, 以`Portable executable for AMD64(PE) [pe.dll]`格式打开
IDA会分析文件, 如果如下步骤无法进行,可以尝试等待分析完成(时间或许需要数个小时)
1. 在.rdata段搜索字符串`'exec autoexec.cfg'` 或按`G`跳转到`aExecAutoexecCf`
2. 单击选中`aExecAutoexecCf`右键选择`jimp to xref to operand...`或按`x`跳转到引用
3. 引用应该只有一个,在引用行上方应该有`mov     rcx, cs:qword_1848A7C68`或类似的代码
4. 而`qword_1848A7C68`就是 `gEnv->pConsole` 的偏移地址,x64 windows dll 基址为 `0x180000000`,所以`gEnv->pConsole`的地址偏移就是`0x48A7C68`
5. 知道pConsole的地址后,我们可以通过 pConsole 在`gEnv`中的偏移来计算`gEnv`的地址,从而找到所有关联组件的地址
6. 但是`0x48A7C68`并不是固定的,游戏更新后可能会变化,所以我们需要通过字节模式搜索来找到`gEnv->pConsole`的地址
7. 通过对`mov     rcx, cs:qword_1848A7C68`行以及之后行的16进制分析+汇编分析(你可以扔给AI让它帮你找出SIG), 我们可以得到`SIG = "48 8B 0D ?? ?? ?? ?? 48 8D 15 ?? ?? ?? ?? 45 33 C9 45 33 C0 4C 8B 11"`
8. 在游戏运行时通过针对`WHGame.dll`的字节模式搜索找到`qword_1848A7C68`的实际值,使用RIP相对寻址找到`pConsole`的地址
9. pConsole 是 gEnv 的第 22 个成员，往前偏移21个指针，21 * 8 = 168 = 0xA8 ,通过`pConsole`的地址 - 0xA8 得到`gEnv`的地址,然后通过`gEnv`的地址 + 偏移找到所有关联组件的地址

可以参考我的另外一个项目 [kcd2db](https://github.com/muyuanjin/kcd2db)

# 已验证的偏移(游戏版本V1.2.2)
1. `gEnv->pScriptSystem`: gEnv的大部分偏移都和[ISystem.h](CryEngine/Code/CryEngine/CryCommon/CrySystem/ISystem.h#L781)一致,是第六个成员,偏移5x8字节 = 0x28
2. `gEnv->pGame`: 同上,是第19个成员,偏移18x8字节 = 0x90
3. `gEnv->pConsole`: 同上,是第22个成员,偏移21x8字节 = 0xA8
4. `gEnv->pScriptSystem->CreateTable()`: 和源码[IScriptSystem.h](CryEngine/Code/CryEngine/CryCommon/CryScriptSystem/IScriptSystem.h#L283)中不一致,CreateTable 是`IScriptSystem`第 14 个虚函数,而不是第13个,存在一个未知虚函数,所以偏移是 13x8 = 0x68
5. `gEnv->pScriptSystem->CreateTable()->AddFunction()` 和源码[IScriptSystem.h](CryEngine/Code/CryEngine/CryCommon/CryScriptSystem/IScriptSystem.h#L616)中不一致,AddFunction 是`IScriptTable`第 23 个虚函数,而不是第22个,存在一个未知虚函数,所以偏移是 22x8 = 0xB0
6. `gEnv->pGame->GetLongName()` 和源码[IGame.h](CryEngine/Code/CryEngine/CryCommon/CryGame/IGame.h#L112)中不一致,是第 13 个虚函数,偏移是 12x8 = 0x60
7. `gEnv->pGame->GetName()`  和源码[IGame.h](CryEngine/Code/CryEngine/CryCommon/CryGame/IGame.h#L115)中不一致,是第 14 个虚函数,偏移是 13x8 = 0x68
8. `gEnv->pGame->GetIGameFramework()` 和源码[IGame.h](CryEngine/Code/CryEngine/CryCommon/CryGame/IGame.h#L128)中不一致,是第 17 个虚函数,偏移是 16x8 = 0x80
9. `gEnv->pGame->GetIGameFramework()->RegisterListener()` 和源码[IGameFramework.h](CryEngine/Code/CryEngine/CryCommon/CryGame/IGameFramework.h#L108)中不一致,是第 101 个虚函数,偏移是 100x8 = 0x320
# Repository Guidelines

## Project Structure & Module Organization

This repository is a reference and documentation archive for Kingdom Come: Deliverance 2 modding. Root Markdown files are curated guides: `README.md`, `MODDING_STACK.md`, `MODDING_EXPERIENCE.md`, `DISASSEMBLY.md`, `CONSOLE.md`, and `LINKS.md`.

- `official-wiki/` mirrors the official KM wiki as Markdown plus images.
- `Scripts/` contains extracted `Data/Scripts.pak` content, including `Scripts/AI/`, `Scripts/Entities/`, `Scripts/Quests/`, and Lua under `Scripts/Scripts/`.
- `Libs/Tables/` contains extracted `Data/Tables.pak` XML/TBL data.
- `script_bind_2025_01_14/` stores official modding-tool Lua binding HTML.
- `DLL/` stores versioned `WHGame.dll` snapshots for offline disassembly.
- `CryEngine/` is a submodule/reference tree, not the authoritative KCD2 engine source.

## Build, Test, and Development Commands

There is no top-level build system or package manager for this repository. Use targeted validation:

- `git submodule update --init --recursive` initializes the `CryEngine` reference submodule.
- `rg "term" Scripts Libs official-wiki` searches extracted data and docs quickly.
- `git status --short` checks pending changes before committing.
- `git diff --stat` reviews the size and scope of documentation or snapshot updates.

When re-extracting game data, use the Python one-liners documented in `Scripts/README.md` and `Libs/Tables/README.md`, then update the source build, branch, timestamp, and file counts in the related README.

## Coding Style & Naming Conventions

Write repository documentation in clear Markdown with short sections, backticked paths, and relative links. Preserve bilingual structure where it already exists. Do not reformat generated or extracted game data unless the change is part of a refreshed snapshot.

Use existing naming patterns for versioned assets, such as `WHGame_release_1_5.dll`, `WHGame_V1.2.2.dll`, and date-stamped snapshot directories like `script_bind_2025_01_14/`.

## Testing Guidelines

No automated test framework is configured. Validate changes by checking links, searching for renamed paths with `rg`, and spot-checking extracted files against their source pak or tool output. Treat `Scripts/AI/test/` and `script_bind_2025_01_14/wh_tests/` as upstream/reference content unless intentionally refreshing those snapshots.

## Commit & Pull Request Guidelines

Recent history is mostly short `update` commits, with at least one conventional commit (`feat(docs): ...`). Prefer concise imperative messages, and use a scope when helpful, for example `docs: refresh table snapshot notes` or `feat(docs): add release_1_5 script data`.

Pull requests should describe what changed, identify the game/tool version used for extracted data, link related issues or sources, and call out large binary or snapshot changes explicitly.

## Security & Configuration Tips

Do not commit local tool state from `.idea/`, `mcps/`, or `agent-tools/`. Keep DLL additions limited to documented offline analysis snapshots and include the game build they came from.

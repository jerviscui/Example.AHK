# Repository Guidelines

## Project Structure & Module Organization
This repository is a small AutoHotkey v2 workspace. Top-level `*.ahk` files are the main scripts, with `Index.ahk` acting as the combined launcher through `#Include` statements. Reusable helpers live in `lib/` (for example, `lib/IsCnIME.ahk`). The `no_english_mode/` folder contains a bundled third-party helper executable and its notes, not active AHK source. Editor settings and the shared debugger launch profile are under `.vscode/`.

## Build, Test, and Development Commands
Use AutoHotkey v2 directly to run scripts locally:

```powershell
"C:\Program Files\AutoHotkey\v2\AutoHotkey.exe" .\Index.ahk
"C:\Program Files\AutoHotkey\v2\AutoHotkey.exe" .\CnToEn.ahk
"C:\Program Files\AutoHotkey\v2\AutoHotkey.exe" .\test.ahk
```

Run `Index.ahk` for the normal combined workflow, or launch a single script while developing one feature. In VS Code, use the `AHKDebug` configuration from `.vscode/launch.json` to debug the current file.

## Coding Style & Naming Conventions
Target AutoHotkey v2 syntax and keep `#Requires AutoHotkey v2.0` at the top of entry scripts. Follow the existing style: 4-space indentation, opening braces on the same line, and `;` comments for short notes or section markers. Keep script filenames descriptive (`QmkStatus.ahk`, `DirectionKey.ahk`) and put shared utilities in `lib/`. Prefer PascalCase for function names such as `MainLoop()` and `GetSize()`. No formatter or linter is configured, so match nearby code carefully.

## Testing Guidelines
There is no automated test framework in this repo. Validate changes by running the affected `.ahk` file and manually exercising the hotkeys, hotstrings, tray behavior, or GUI overlay involved. Use `test.ahk` only for isolated experiments or debugging. Document manual verification steps in your PR when behavior is not obvious.

## Commit & Pull Request Guidelines
Recent history uses short, imperative commit subjects, in either English or concise Chinese, for example `Add js hotkey`, `Fix 1dd`, and `增加 !4`. Keep each commit scoped to one script or behavior change. PRs should include: a short summary, the files changed, manual test steps, and screenshots or GIFs for visible UI changes such as `QmkStatus.ahk`.

## Configuration Tips
`.vscode/launch.json` assumes AutoHotkey is installed at `C:\Program Files\AutoHotkey\v2\AutoHotkey.exe`. Keep machine-specific paths out of shared scripts unless they are already editor-only settings.

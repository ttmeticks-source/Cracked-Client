# Cracked Client — macOS companion app

A native SwiftUI companion interface with Java/Bedrock profiles, saved HUD preferences, and local practice notes.

**Made by c0oled!**

## One-command install

After the first successful GitHub Actions build, run this in macOS Terminal:

```sh
curl -fL --progress-bar https://raw.githubusercontent.com/ttmeticks-source/Cracked-Client/main/install.sh | bash
```

The installer downloads the latest published app ZIP, automatically extracts it, installs `CrackedClient.app` into `~/Applications`, and opens it. It does not require Xcode.

If no release build exists yet, check [GitHub Actions](https://github.com/ttmeticks-source/Cracked-Client/actions), wait for **Build Cracked Client for macOS** to finish successfully, and run the command again.

## Current features
- macOS desktop GUI with Home, HUD, Practice, and Settings tabs
- Java Edition / Bedrock Edition profile selector
- Preferences saved locally using AppStorage
- Practice notes saved locally

This is a companion utility, not an injector, exploit, or multiplayer cheat. It does not read or modify Minecraft processes, bypass account checks, or change game files. The HUD options are app-side preferences, not live in-game telemetry.

## Requirements
- macOS 13 or later

## Build locally
```sh
swift build -c release
swift run
```

## Manual download
Open the [latest GitHub Release](https://github.com/ttmeticks-source/Cracked-Client/releases/latest) and download `CrackedClient-macOS.zip`.

The app is not code-signed or notarized. macOS may show a first-launch security warning.

# Cracked Client — macOS companion and free-trial launcher

A native SwiftUI launcher shell for the official Minecraft free trials, plus saved HUD preferences and local practice notes.

**Made by c0oled!**

## Install on macOS

Run this in Terminal:

```sh
curl -fL --progress-bar https://raw.githubusercontent.com/ttmeticks-source/Cracked-Client/main/install.sh | bash
```

The installer downloads the latest app ZIP, extracts it, installs `CrackedClient.app` into `~/Applications`, and opens it. It does not put the app on your Desktop and does not require Xcode.

## Free game launch options

### Java Edition — official free demo

1. Select **Java Edition** in the app.
2. The app opens the official Minecraft Launcher. If it is missing, the official Minecraft download page opens.
3. Sign in with a Microsoft account that does not own Java Edition.
4. Select **Play Demo** in the launcher.

The official demo is limited to about 100 minutes of in-game time (five in-game days), and demo accounts cannot join multiplayer servers. See the [official Java demo instructions](https://help.minecraft.net/hc/en-us/articles/4408948974989-Minecraft-Java-Edition-Demo-Mode-).

### Bedrock Edition — official Android free trial through an emulator

Bedrock has no official native macOS release. The app can start an Android virtual device and open Mojang's official **Minecraft Trial** listing in Google Play.

One-time setup:
1. Install [Android Studio](https://developer.android.com/studio).
2. Open **Device Manager** and create a phone virtual device.
3. Choose a system image labelled **Google Play** (not only Google APIs).
4. Finish setup and close the emulator.

After setup:
1. Select **Bedrock Edition** in this app.
2. The app detects the Android SDK and starts the Google Play virtual device.
3. Sign in to Google Play inside the emulator, install **Minecraft Trial** by Mojang, and open it there.

This is the official free Android trial running inside an emulator, not a native macOS Bedrock build. It is time-limited and may be slower than a physical Android device. The Google Play listing is [Minecraft Trial by Mojang](https://play.google.com/store/apps/details?id=com.mojang.minecrafttrialpe). Android Emulator is a tool supplied with Android Studio; see [Android's emulator guide](https://developer.android.com/studio/run/emulator).

## App features

- Java demo and Bedrock Android-trial launch buttons
- Home, HUD, Practice, and Settings tabs
- Saved local preferences and practice notes
- App installs to `~/Applications`; Android SDK and virtual-device data stay in the user's Library folders

This app does not unlock paid editions, bypass account checks, modify Minecraft files, or inject into game processes. The HUD options are companion-app preferences, not a live in-game overlay.

## Requirements

- macOS 13 or later
- For Java: official Minecraft Launcher and a Microsoft account
- For Bedrock trial: Android Studio, Android SDK Emulator, Platform-Tools, and a Google Play-enabled virtual device

## Build locally

```sh
swift build -c release
swift run
```

## Manual download

Open the [latest GitHub Release](https://github.com/ttmeticks-source/Cracked-Client/releases/latest) and download `CrackedClient-macOS.zip`.

The app is not code-signed or notarized. macOS may show a first-launch security warning.

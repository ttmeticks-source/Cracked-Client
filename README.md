# Cracked Client — macOS companion app

A native SwiftUI companion interface with Java/Bedrock profiles, saved HUD preferences, and local practice notes.

**Made by c0oled!**

## Current features
- macOS desktop GUI with Home, HUD, Practice, and Settings tabs
- Java Edition / Bedrock Edition profile selector
- Preferences saved locally using AppStorage
- Practice notes saved locally
- GitHub Actions workflow that builds a downloadable `.app` ZIP

This is a companion utility, not an injector, exploit, or multiplayer cheat. It does not read or modify Minecraft processes, bypass account checks, or change game files. The HUD options are app-side preferences, not live in-game telemetry. Java and Bedrock have separate extension ecosystems.

## Requirements
- macOS 13 or later to run the app
- Swift 5.9+ to build locally

## Build locally
```sh
swift build -c release
swift run
```

## Download the macOS app
1. Open the repository's **Actions** tab.
2. Select **Build Cracked Client for macOS** and click **Run workflow**.
3. When it completes, download `CrackedClient-macOS.zip` from the run's Artifacts.
4. Unzip it and move `CrackedClient.app` into Applications.

Pushing a version tag such as `v1.0.0` also attaches the ZIP to a GitHub Release.

The app is not code-signed or notarized. macOS may show a first-launch security warning.

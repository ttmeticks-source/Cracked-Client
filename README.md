# Cracked Client

A small macOS Minecraft companion UI with a Java Edition / Bedrock Edition selector, configurable HUD preview toggles, and practice notes.

**Made by c0oled!**

## What it currently does

- Native SwiftUI macOS app
- Switches between Java Edition and Bedrock Edition views
- HUD preview toggles for coordinates, FPS placeholder, and clock placeholder
- Local practice notes

The current version is a companion interface and preview. It does not inject into Minecraft, modify game memory, bypass account or server rules, or provide multiplayer exploits. The displayed HUD values are placeholders, not live game telemetry.

Java and Bedrock have different extension ecosystems; selecting an edition in this app does not install or activate mods for either game.

## Requirements

- macOS 13 or later
- Xcode Command Line Tools / Swift 5.9 or later

## Build

```sh
swift build -c release
```

Run from the project directory:

```sh
swift run
```

## Install a packaged release

After a GitHub Release has been published, run:

```sh
curl -fsSL https://raw.githubusercontent.com/ttmeticks-source/Cracked-Client/main/install.sh | bash
```

Review the installer before running it if you prefer to inspect scripts first.

## License

MIT

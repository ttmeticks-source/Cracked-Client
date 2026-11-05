# Cooled AI — macOS generation and research app

A native SwiftUI AI app for prompt-based writing, brainstorming, explanations, planning, and code generation. Optional Research mode uses the OpenAI Responses API web-search tool and displays source links.

**Made by c0oled!**

## Install on macOS

Run this in Terminal:

```sh
curl -fL --progress-bar https://raw.githubusercontent.com/ttmeticks-source/Cracked-Client/main/install.sh | bash
```

The installer downloads the latest release, automatically extracts it, installs `CooledAI.app` into `~/Applications`, and opens it. It does not put the app on your Desktop and does not require Xcode.

## First setup

1. Open Cooled AI and press the gear button.
2. Enter an OpenAI API key managed by a parent or guardian.
3. Keep the default model name unless the connected API project uses a different supported model.
4. Save the key. Cooled AI stores it in macOS Keychain.

Never paste the key into a prompt, screenshot, or message. The app sends prompts to the OpenAI API over HTTPS. The key stays in Keychain and is not written into the repository or app bundle.

## Generate

Write a prompt in the box and press **Generate**. Cooled AI keeps a short recent conversation context and supports writing, ideas, explanations, planning, and code.

## Research

Switch **Research** on to require the Responses API web-search tool for that turn. The response shows clickable source links from URL-citation annotations and the returned web-search sources.

OpenAI's current documentation recommends the Responses API `web_search` tool for new integrations. See the [web-search guide](https://developers.openai.com/api/docs/guides/tools-web-search) and [Responses API documentation](https://developers.openai.com/api/docs/guides/responses).

## Costs and account setup

This app is not a free AI service and does not include an API key. API usage is billed separately from a ChatGPT subscription. Model input/output and web-search calls may cost money. Use an API project managed by a parent or guardian, and set a spending limit before use. Check [current API pricing](https://openai.com/api/pricing/).

## Requirements

- macOS 13 or later
- Internet connection
- An OpenAI API key with access to the selected model and Responses API

## Build locally

```sh
swift build -c release
swift run
```

## Manual download

Open the [latest GitHub Release](https://github.com/ttmeticks-source/Cracked-Client/releases/latest) and download `CooledAI-macOS.zip`.

The app is not code-signed or notarized. macOS may show a first-launch security warning.

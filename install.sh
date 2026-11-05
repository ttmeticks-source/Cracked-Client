#!/bin/bash
set -euo pipefail

REPO="ttmeticks-source/Cracked-Client"
APP_NAME="CrackedClient"
ASSET_NAME="CrackedClient-macos.zip"
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "This installer is for macOS only."
  exit 1
fi

GREEN='\033[0;32m'
CYAN='\033[0;36m'
RESET='\033[0m'

printf "${CYAN}"
cat <<'BANNER'
   ____ ____      _    ____ _  _______ ____  
  / ___|  _ \    / \  / ___| |/ / ____|  _ \ 
 | |   | |_) |  / _ \| |   | ' /|  _| | | | |
 | |___|  _ <  / ___ \ |___| . \| |___| |_| |
  \____|_| \_\/_/   \_\____|_|\_\_____|____/ 
BANNER
printf "${RESET}"
printf "${GREEN}Made by c0oled!\n${RESET}"
echo "Fetching the latest Cracked Client release..."

API_URL="https://api.github.com/repos/${REPO}/releases/latest"
DOWNLOAD_URL="$(curl -fsSL "$API_URL" | python3 -c '
import json, sys
data = json.load(sys.stdin)
for asset in data.get("assets", []):
    if asset.get("name") == "CrackedClient-macos.zip":
        print(asset.get("browser_download_url", ""))
        break
')"

if [[ -z "$DOWNLOAD_URL" ]]; then
  echo "No packaged release was found yet."
  echo "Build locally with: swift build -c release"
  exit 1
fi

curl -fL "$DOWNLOAD_URL" -o "$TMP_DIR/$ASSET_NAME"
ditto -x -k "$TMP_DIR/$ASSET_NAME" "$TMP_DIR"

APP_PATH="$TMP_DIR/CrackedClient.app"
if [[ ! -d "$APP_PATH" ]]; then
  echo "The release archive did not contain CrackedClient.app"
  exit 1
fi

DEST="/Applications/CrackedClient.app"
if [[ -w /Applications ]]; then
  rm -rf "$DEST"
  cp -R "$APP_PATH" "$DEST"
else
  echo "Installing to ~/Applications (no administrator permission needed)."
  mkdir -p "$HOME/Applications"
  rm -rf "$HOME/Applications/CrackedClient.app"
  cp -R "$APP_PATH" "$HOME/Applications/CrackedClient.app"
  DEST="$HOME/Applications/CrackedClient.app"
fi

echo "Installed to: $DEST"
echo "Open it from Applications or Spotlight."

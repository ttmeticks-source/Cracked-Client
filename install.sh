#!/usr/bin/env bash
set -euo pipefail

if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "This installer is for macOS only."
  exit 1
fi

REPO="ttmeticks-source/Cracked-Client"
ASSET_URL="https://github.com/${REPO}/releases/latest/download/CrackedClient-macOS.zip"
WORK_DIR="$(mktemp -d)"
trap 'rm -rf "$WORK_DIR"' EXIT

CYAN='\033[0;36m'
GREEN='\033[0;32m'
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
echo "Downloading the latest Cracked Client..."

if ! curl -fL --retry 3 --retry-delay 2 "$ASSET_URL" -o "$WORK_DIR/CrackedClient-macOS.zip"; then
  echo "No published app build was found yet."
  echo "Check the build at: https://github.com/${REPO}/actions"
  exit 1
fi

echo "Extracting app..."
ditto -x -k "$WORK_DIR/CrackedClient-macOS.zip" "$WORK_DIR"
APP_SOURCE="$WORK_DIR/CrackedClient.app"
if [[ ! -d "$APP_SOURCE" ]]; then
  echo "The ZIP did not contain CrackedClient.app."
  exit 1
fi

DEST_DIR="$HOME/Applications"
DEST_APP="$DEST_DIR/CrackedClient.app"
mkdir -p "$DEST_DIR"
rm -rf "$DEST_APP"
ditto "$APP_SOURCE" "$DEST_APP"

echo "Installed: $DEST_APP"
echo "Launching Cracked Client..."
open "$DEST_APP"

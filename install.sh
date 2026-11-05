#!/usr/bin/env bash
set -euo pipefail

if [[ "$(uname -s)" != "Darwin" ]]; then
  printf '\033[1;31m✖ This installer is for macOS only.\033[0m\n'
  exit 1
fi

REPO="ttmeticks-source/Cracked-Client"
ASSET_URL="https://github.com/${REPO}/releases/latest/download/CrackedClient-macOS.zip"
WORK_DIR="$(mktemp -d)"
trap 'rm -rf "$WORK_DIR"' EXIT

CYAN='\033[1;36m'
BLUE='\033[1;34m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
RED='\033[1;31m'
DIM='\033[2m'
RESET='\033[0m'

clear
printf "${CYAN}"
cat <<'BANNER'
   ____ ____      _    ____ _  _______ ____  
  / ___|  _ \    / \  / ___| |/ / ____|  _ \ 
 | |   | |_) |  / _ \| |   | ' /|  _| | | | |
 | |___|  _ <  / ___ \ |___| . \| |___| |_| |
  \____|_| \_\/_/   \_\____|_|\_\_____|____/ 
BANNER
printf "${RESET}"
printf "${BLUE}                 macOS installer${RESET}\n"
printf "${GREEN}                    Made by c0oled!\n${RESET}\n"

printf "${YELLOW}[1/3]${RESET} Downloading the latest release...\n"
if ! curl -fL --progress-bar --retry 3 --retry-delay 2 "$ASSET_URL" -o "$WORK_DIR/CrackedClient-macOS.zip"; then
  printf "${RED}✖ Download failed. No published build may exist yet.\n${RESET}"
  printf "Check: https://github.com/${REPO}/actions\n"
  exit 1
fi

printf "\n${YELLOW}[2/3]${RESET} Extracting the app automatically...\n"
ditto -x -k "$WORK_DIR/CrackedClient-macOS.zip" "$WORK_DIR"
APP_SOURCE="$WORK_DIR/CrackedClient.app"
if [[ ! -d "$APP_SOURCE" ]]; then
  printf "${RED}✖ The ZIP did not contain CrackedClient.app.\n${RESET}"
  exit 1
fi

printf "${YELLOW}[3/3]${RESET} Installing to ~/Applications...\n"
DEST_DIR="$HOME/Applications"
DEST_APP="$DEST_DIR/CrackedClient.app"
mkdir -p "$DEST_DIR"
rm -rf "$DEST_APP"
ditto "$APP_SOURCE" "$DEST_APP"

printf "\n${GREEN}✔ Installation complete!\n${RESET}"
printf "${DIM}Location: $DEST_APP${RESET}\n"
printf "${GREEN}Launching Cracked Client...\n${RESET}"
open "$DEST_APP"
printf "${CYAN}Enjoy! — Made by c0oled!\n${RESET}"

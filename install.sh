#!/bin/bash
# 0hex01 apt repos - one-line setup: installs BOTH stable and unstable repos
#   curl -fsSL https://0hex01.github.io/0hex01-apt-repo/install.sh | sudo bash
set -euo pipefail

[ "$(id -u)" -eq 0 ] || { echo "run as root: curl ... | sudo bash" >&2; exit 1; }

BASE="https://0hex01.github.io/0hex01-apt-repo"
BASEU="https://0hex01.github.io/0hex01-apt-repo-unstable"
KEYRING="/usr/share/keyrings/0hex01.gpg"
LIST="/etc/apt/sources.list.d/0hex01.list"
LISTU="/etc/apt/sources.list.d/0hex01-unstable.list"

curl -fsSL "$BASE/0hex01.gpg" -o "$KEYRING.tmp"
mv "$KEYRING.tmp" "$KEYRING"
chmod 644 "$KEYRING"

echo "deb [arch=amd64 signed-by=$KEYRING] $BASE stable main" > "$LIST"
echo "deb [arch=amd64 signed-by=$KEYRING] $BASEU unstable main" > "$LISTU"

apt update
echo "0hex01 stable + unstable repos added - try: apt search 0hex01"

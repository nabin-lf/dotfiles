#!/usr/bin/env bash
set -euo pipefail

sudo apt-get update
sudo apt-get install -y \
  autoconf automake gcc make pkg-config git curl wget \
  libpam0g-dev libcairo2-dev libfontconfig1-dev \
  libxcb-composite0-dev libev-dev libx11-xcb-dev libxcb-xkb-dev \
  libxcb-xinerama0-dev libxcb-randr0-dev libxcb-image0-dev \
  libxcb-util0-dev libxcb-xrm-dev libxkbcommon-dev \
  libxkbcommon-x11-dev libjpeg-dev libgif-dev imagemagick feh

build_dir="$(mktemp -d)"
trap 'rm -rf "$build_dir"' EXIT
git clone --depth 1 https://github.com/Raymo111/i3lock-color.git "$build_dir/i3lock-color"
cd "$build_dir/i3lock-color"
./build.sh

# Keep Ubuntu's /usr/bin/i3lock intact; ~/.local/bin takes precedence for this user.
install -Dm755 build/i3lock "$HOME/.local/bin/i3lock"

# Install betterlockscreen for this user (no system-wide overwrite).
curl -fsSL https://raw.githubusercontent.com/betterlockscreen/betterlockscreen/main/install.sh \
  | bash -s user

echo
echo "Installed i3lock-color and betterlockscreen in ~/.local/bin."
echo "Test with: betterlockscreen -l dimblur"

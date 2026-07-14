#!/bin/bash

set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== Dotfiles Installer ==="
echo ""

# SSH Key
echo "[1/7] Setting up SSH key..."
if [ ! -f ~/.ssh/id_rsa ]; then
    ssh-keygen -t rsa -b 4096 -C "nabin-lf" -f ~/.ssh/id_rsa -N ""
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_rsa
    cat > ~/.ssh/config << 'EOF'
Host github.com
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_rsa
  AddKeysToAgent yes
EOF
    chmod 600 ~/.ssh/config
    echo "Add this key to GitHub:"
    cat ~/.ssh/id_rsa.pub
    echo ""
    read -p "Press enter after adding the key to GitHub..."
else
    echo "SSH key already exists"
fi

# Alacritty
echo "[2/7] Installing Alacritty configs..."
mkdir -p ~/.config/alacritty
cp "$DOTFILES_DIR/alacritty/"*.toml ~/.config/alacritty/

# Ghostty
echo "[3/7] Installing Ghostty configs..."
mkdir -p ~/.config/ghostty
cp "$DOTFILES_DIR/ghostty/config" ~/.config/ghostty/

# Tmux
echo "[4/7] Installing Tmux configs..."
cp "$DOTFILES_DIR/tmux/.tmux.conf" ~/

# Zsh
echo "[5/7] Installing Zsh configs..."
cp "$DOTFILES_DIR/zsh/.zshrc" ~/

# Neovim (LazyVim)
echo "[6/7] Installing Neovim (LazyVim) configs..."
mkdir -p ~/.config/nvim
cp "$DOTFILES_DIR/nvim/init.lua" ~/.config/nvim/
cp "$DOTFILES_DIR/nvim/lazyvim.json" ~/.config/nvim/
cp "$DOTFILES_DIR/nvim/lazy-lock.json" ~/.config/nvim/
cp -r "$DOTFILES_DIR/nvim/lua" ~/.config/nvim/
cp -r "$DOTFILES_DIR/nvim/plugin" ~/.config/nvim/ 2>/dev/null || true

# Clipboard Manager (GPaste)
echo "[7/7] Installing clipboard manager (GPaste)..."
sudo apt update -qq
sudo apt install -y gpaste gnome-shell-extension-gpaste 2>/dev/null || true
gnome-extensions enable gpaste@gnome-shell-extensions.gnome.org 2>/dev/null || true
gsettings set org.gnome.GPaste max-history-size 50
gsettings set org.gnome.GPaste track-changes true
gsettings set org.gnome.GPaste trim-whitespace true
dconf write /org/gnome/GPaste/show-ui "'<Super>v'"

# GNOME keybindings
echo ""
echo "[+] Setting up GNOME keybindings..."
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/ name 'Alacritty'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/ command 'wmctrl -a Alacritty || alacritty'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/ binding '<Alt>i'

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom7/ name 'Brave Browser'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom7/ command 'wmctrl -a Brave || brave-browser'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom7/ binding '<Alt>b'

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom8/ name 'Slack'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom8/ command 'wmctrl -a Slack || slack'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom8/ binding '<Alt>s'

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom9/ name 'Spotify'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom9/ command 'wmctrl -a Spotify || spotify'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom9/ binding '<Alt>x'

echo ""
echo "=== Done ==="
echo "GPaste: Super+V to open clipboard history"
echo "Restart your terminal or run: source ~/.zshrc"

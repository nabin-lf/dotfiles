# Neovim
echo "[7/8] Installing Neovim configs..."
copy_config_dir nvim#!/bin/bash

set -e
copy_config_dir() {
local name="$1"
[ -d "$DOTFILES_DIR/$name" ] || return
mkdir -p "$HOME/.config/$name"
cp -a "$DOTFILES_DIR/$name/." "$HOME/.config/$name/"
}

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== Dotfiles Installer ==="
echo ""

# SSH Key
echo "[1/8] Setting up SSH key..."
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
echo "[2/8] Installing Alacritty configs..."
copy_config_dir alacritty

# Ghostty
echo "[3/8] Installing Ghostty configs..."
copy_config_dir ghostty

echo "[4/8] Installing terminal tool configs..."
for config in kitty wezterm starship btop cava fastfetch htop lazydocker lazygit pgcli yazi; do
    copy_config_dir "$config"
done

# Tmux
echo "[5/8] Installing Tmux configs..."
cp "$DOTFILES_DIR/tmux/.tmux.conf" ~/

# Zsh
echo "[6/8] Installing Zsh configs..."
cp "$DOTFILES_DIR/zsh/.zshrc" ~/

# Neovim
echo "[7/8] Installing Neovim configs..."
copy_config_dir nvim

# Clipboard Manager (GPaste)
echo "[8/8] Installing clipboard manager (GPaste)..."
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

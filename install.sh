#!/bin/bash

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
echo "[1/9] Setting up SSH key..."
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
echo "[2/9] Installing Alacritty configs..."
copy_config_dir alacritty

# Ghostty
echo "[3/9] Installing Ghostty configs..."
copy_config_dir ghostty

echo "[4/9] Installing terminal tool configs..."
for config in kitty wezterm starship btop cava fastfetch htop lazydocker lazygit pgcli yazi; do
    copy_config_dir "$config"
done

# Tmux
echo "[5/9] Installing Tmux configs..."
cp "$DOTFILES_DIR/tmux/.tmux.conf" ~/

# Zsh
echo "[6/9] Installing Zsh configs..."
cp "$DOTFILES_DIR/zsh/.zshrc" ~/

# Neovim
echo "[7/9] Installing Neovim configs..."
copy_config_dir nvim

# i3 window manager
echo "[8/9] Installing i3 configs..."
copy_config_dir i3

# Touchpad settings need the system Xorg configuration directory.
echo "[9/9] Installing touchpad preferences..."
sudo install -Dm644 "$DOTFILES_DIR/xorg/90-touchpad-preferences.conf" \
    /etc/X11/xorg.conf.d/90-touchpad-preferences.conf

echo ""
echo "=== Done ==="
echo "Restart your terminal or run: source ~/.zshrc"

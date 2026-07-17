#!/bin/bash
# Font Fix Script for Ubuntu + GNOME
# Run: chmod +x fix-fonts.sh && ./fix-fonts.sh

echo "=== Fixing Font Rendering ==="

# 1. Install Ubuntu UI font
echo "[1/4] Installing Ubuntu UI font..."
sudo apt install -y fonts-ubuntu 2>/dev/null || true

# 2. Install JetBrains Mono Nerd Font (for terminal/editors only)
echo "[2/4] Installing JetBrains Mono Nerd Font..."
mkdir -p ~/.local/share/fonts/JetBrainsMonoNerd
cd /tmp
curl -sL "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz" -o JetBrainsMono.tar.xz
tar xf JetBrainsMono.tar.xz -C ~/.local/share/fonts/JetBrainsMonoNerd/
# Keep only standard weights
cd ~/.local/share/fonts/JetBrainsMonoNerd
for f in JetBrainsMonoNerdFont-{Thin,ExtraLight,ExtraBold,Black}*.ttf; do
  rm -f "$f" 2>/dev/null
done
cd /tmp && rm -f JetBrainsMono.tar.xz

# 3. Remove conflicting system JetBrains Mono (non-Nerd)
echo "[3/4] Removing conflicting system fonts..."
sudo apt remove -y fonts-jetbrains-mono 2>/dev/null || true

# 4. Set proper GNOME font settings
echo "[4/4] Configuring GNOME fonts..."
# UI = sans-serif (NOT monospace!)
gsettings set org.gnome.desktop.interface font-name 'Ubuntu 11'
gsettings set org.gnome.desktop.interface document-font-name 'Ubuntu 11'
# Monospace = only for editors/terminals
gsettings set org.gnome.desktop.interface monospace-font-name 'JetBrainsMono Nerd Font 13'
# Rendering
gsettings set org.gnome.desktop.interface font-antialiasing 'rgba'
gsettings set org.gnome.desktop.interface font-hinting 'full'

# Rebuild font cache
fc-cache -fv 2>/dev/null

echo ""
echo "=== Done ==="
echo "UI Font: $(gsettings get org.gnome.desktop.interface font-name)"
echo "Monospace: $(gsettings get org.gnome.desktop.interface monospace-font-name)"
echo "Antialiasing: $(gsettings get org.gnome.desktop.interface font-antialiasing)"
echo "Hinting: $(gsettings get org.gnome.desktop.interface font-hinting)"
echo ""
echo "IMPORTANT: UI font must be sans-serif (Ubuntu/Cantarell/DejaVu Sans)"
echo "Monospace fonts should only be used in terminals and code editors."

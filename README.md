# dotfiles

Personal config files for Ubuntu + GNOME/i3 setup.

## What's included

| Directory | What it configures |
|-----------|-------------------|
| `alacritty/` | Alacritty terminal (font, theme, padding) |
| `i3/` | i3 window manager (gaps, shortcuts, bar, screenshots, network and power) |
| `xorg/` | Touchpad preferences (tap-to-click and scrolling direction) |
| `ghostty/` | Ghostty terminal |
| `nvim/` | Neovim (NvChad + plugins) |
| `tmux/` | tmux (prefix, status bar, plugins) |
| `zsh/` | zsh (plugins, aliases, fzf, starship) |

## Install

Clone and run the install script:

```bash
git clone git@github.com:nabin-lf/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x install.sh
./install.sh
```

This will:

1. Set up SSH key (if not already configured)
2. Copy Alacritty, i3, Ghostty, tmux, zsh, and Neovim configs to the correct locations
3. Enable tap-to-click and the configured touchpad scrolling direction
3. Install GPaste clipboard manager
4. Set up GNOME keybindings for app launchers

## Manual install (without script)

Copy individual configs as needed:

```bash
# Alacritty
cp alacritty/*.toml ~/.config/alacritty/

# i3
cp -r i3 ~/.config/

# Neovim
cp -r nvim/* ~/.config/nvim/

# Tmux
cp tmux/.tmux.conf ~/

# Zsh
cp zsh/.zshrc ~/
```

## Keybindings (i3 / GNOME)

| Key | Action |
|-----|--------|
| `Alt+i` | Open Alacritty |
| `Alt+b` | Open Brave |
| `Alt+s` | Open Slack |
| `Alt+x` | Open Spotify |
| `Super+Space` | Search and launch applications |
| `Print` | Area screenshot, copied to clipboard |
| `Super+Print` | Full-screen screenshot, copied to clipboard |
| `Super+n` | Network settings GUI |
| `Super+Shift+b` | Bluetooth settings GUI |
| `Super+Esc` | Lock screen |
| `Super+Shift+p` | Power mode: `l` lock, `s` suspend, `r` reboot, `p` power off |

## Touchpad

Tap anywhere on the touchpad for a normal left click. Two-finger taps are right clicks. The setting is installed system-wide in `/etc/X11/xorg.conf.d/` and also takes effect after your next login.

For Wi-Fi, press `Super+n` for the graphical NetworkManager window. From a terminal, use `nmcli device wifi list`, then `nmcli device wifi connect "NETWORK_NAME" --ask`.

For Bluetooth, press `Super+Shift+b` for Blueman. From a terminal, use `bluetoothctl`, then `power on`, `agent on`, `default-agent`, `scan on`, `pair MAC`, `trust MAC`, and `connect MAC`.

## Fonts

This setup uses **JetBrainsMono Nerd Font** (v3.4.0). Install it from [Nerd Fonts](https://www.nerdfonts.com/font-downloads) if missing:

```bash
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip
unzip JetBrainsMono.zip
rm JetBrainsMono.zip
fc-cache -fv
```

## Requirements

- [Alacritty](https://github.com/alacritty/alacritty)
- [Neovim](https://neovim.io/) (v0.10+)
- [tmux](https://github.com/tmux/tmux)
- [fzf](https://github.com/junegunn/fzf)
- [eza](https://github.com/eza-community/eza)
- [bat](https://github.com/sharkdp/bat)
- [starship](https://starship.rs/)
- [zoxide](https://github.com/ajeetdsouza/zoxide)
- [Nerd Fonts](https://www.nerdfonts.com/)
- [oh-my-zsh](https://ohmyz.sh/) with plugins: zsh-syntax-highlighting, zsh-autosuggestions, zsh-completions, fzf-tab

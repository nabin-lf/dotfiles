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
3. Install the i3 touchpad preference and native i3 startup services

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

### i3 quick reference

`Super` is the Windows/Meta key.

Keyboard repeat is tuned to 250ms before repeat and 40 repeats/second, so holding Backspace or `h/j/k/l` responds quickly.

| Key | Action |
|-----|--------|
| `Super+w` | Close the focused application |
| `Super+Shift+q` | Also close the focused application |
| `Super+h/j/k/l` | Focus left/down/up/right |
| `Super+Shift+h/j/k/l` | Move the focused window |
| `Super+v` | Split left/right; the next window opens beside it |
| `Super+d` | Split top/bottom; the next window opens below it |
| `Super+f` | Toggle fullscreen |
| `Super+1…9` | Switch workspace |
| `Super+Shift+1…9` | Move the focused window to a workspace |
| `Super+r`, then `h/j/k/l` | Resize a window; `Esc` exits resize mode |
| `Super+t` | Tabbed layout |
| `Super+Shift+c` | Reload i3 after editing config |
| `Super+Shift+r` | Restart i3 |

To arrange Gmail on the left with terminals stacked on the right: focus the right terminal, press `Super+d`, then focus the middle terminal and press `Super+Shift+l`.

### Wi‑Fi and Bluetooth

Wi‑Fi GUI: press `Super+n`. Select a network and enter its password.

Wi‑Fi terminal:

```bash
nmcli device wifi list
nmcli device wifi connect "NETWORK_NAME" --ask
nmcli connection show
nmcli connection down "CONNECTION_NAME"
nmcli connection up "CONNECTION_NAME"
```

Bluetooth GUI: press `Super+Shift+b`, choose a device, pair it, trust it, and connect it.

Bluetooth terminal:

```text
bluetoothctl
power on
agent on
default-agent
scan on
pair AA:BB:CC:DD:EE:FF
trust AA:BB:CC:DD:EE:FF
connect AA:BB:CC:DD:EE:FF
```

Replace the example MAC address with the device address shown by `scan on`. Type `quit` to leave `bluetoothctl`.

## Touchpad

Tap anywhere on the touchpad for a normal left click. Two-finger taps are right clicks. The setting is installed system-wide in `/etc/X11/xorg.conf.d/` and also takes effect after your next login.

For Wi-Fi, press `Super+n` for the graphical NetworkManager window. From a terminal, use `nmcli device wifi list`, then `nmcli device wifi connect "NETWORK_NAME" --ask`.

For Bluetooth, press `Super+Shift+b` for Blueman. From a terminal, use `bluetoothctl`, then `power on`, `agent on`, `default-agent`, `scan on`, `pair MAC`, `trust MAC`, and `connect MAC`.

## Fonts

This setup uses **JetBrainsMono Nerd Font** (v3.4.0) and a Catppuccin Mocha purple i3 palette. Install the font from [Nerd Fonts](https://www.nerdfonts.com/font-downloads) if missing:

The i3 background uses `Pictures/wallpapers/Catppuccin-pond-bridge.jpg` through lightweight `feh`; empty workspaces no longer show a black root background. Text-file MIME defaults and `$EDITOR`/`$VISUAL` point to Neovim. Yazi is not installed or configured by the installer.

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

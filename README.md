# Dotfiles

My personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Contents

- **nvim** - Neovim configuration (LazyVim-based)
- **tmux** - Tmux configuration with seamless Neovim integration
- **fish** - Fish shell configuration
- **omarchy** - Omarchy/Hyprland desktop environment (Hyprland, Waybar, terminals, etc.)
- **misc** - Additional tools and utilities (yazi, lazygit, btop, fastfetch, starship, etc.)
- **opencode** - Portable OpenCode personal-assistant runtime configuration and Linux timers
- **opencode-vault** - Durable OpenCode vault content in `~/Documents/OpenCode-Vault`

## Installation

### Prerequisites

```bash
# Install stow (if not already installed)
# On Arch/Manjaro:
sudo pacman -S stow

# On Ubuntu/Debian:
sudo apt install stow

# On macOS:
brew install stow
```

### Setup

1. Clone this repository:
```bash
git clone https://github.com/USERNAME/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

2. Run stow to create symlinks:
```bash
# Stow individual packages
stow nvim
stow tmux
stow fish
stow omarchy
stow misc
stow opencode
stow opencode-vault

# Or stow all packages at once
stow */
```

3. Install plugin managers if needed:
   - **Neovim**: [lazy.nvim](https://github.com/folke/lazy.nvim) (auto-installs)
   - **Tmux**: [tpm](https://github.com/tmux-plugins/tpm)
   - **Fish**: Built-in plugin manager
   - **Omarchy** (if on Arch Linux): Install [Omarchy](https://omarchy.org/) first

## Configuration Details

### Neovim
- Based on [LazyVim](https://www.lazyvim.org/)
- Custom plugins configured in `lua/plugins/`
- Keybindings in `lua/config/keymaps.lua`

### Tmux
- Seamless navigation with Neovim using `vim-tmux-navigator`
- Ctrl+h/j/k/l for pane navigation (both tmux and Neovim)
- Mouse support enabled
- Plugin manager: [tpm](https://github.com/tmux-plugins/tpm)

### Fish
- Custom aliases and functions
- Starship prompt integration

### Omarchy (Hyprland)
- **Hyprland** - Wayland compositor with custom window rules, keybindings, and animations
- **Waybar** - Custom status bar configuration
- **Terminals** - Alacritty, Kitty, and Ghostty configurations
- **Walker** - App launcher configuration
- **Mako** - Notification daemon configuration
- Theme management and customizations

### Miscellaneous Tools
- **Yazi** - Terminal file manager configuration and plugins
- **Lazygit** - Git client configuration
- **Btop** - System monitor configuration
- **Fastfetch** - System information display
- **Git** - Git configuration
- **GitHub CLI** - GitHub CLI configuration
- **Starship** - Shell prompt configuration
- **Mise** - Runtime version manager
- **UV** - Python package manager
- **Glow** - Markdown pager
- **Imv** - Image viewer
- **Nautilus** - File manager preferences
- **Lazydocker** - Docker client configuration
- **QAlculate** - Calculator configuration

## Usage

After stowing, you can update these configs directly in `~/dotfiles` and they'll automatically reflect in your home directory via symlinks.

To unstow (remove symlinks):
```bash
cd ~/dotfiles
stow -D nvim  # Remove nvim package
stow -D */    # Remove all packages
```

## System Requirements

- Linux/macOS (primarily tested on Arch Linux)
- Neovim 0.9+
- Tmux 3.0+
- Fish shell 3.0+
- **Omarchy** package (if using desktop environment configs): Requires Arch Linux with [Omarchy](https://omarchy.org/)
- **OpenCode automation timers**: Linux-only (`systemd --user`)

## Notes

- The `lazy-lock.json` file is gitignored and regenerated per system
- Tmux plugins are managed by tpm and not included in the repo
- Some theme/appearance settings may depend on system-specific configuration
- Machine-local secrets/session state for OpenCode are intentionally not tracked in git

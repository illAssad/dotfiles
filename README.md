# Basil's Dotfiles 🏠

A carefully curated collection of configuration files for a modern, productive Linux development environment featuring i3 window manager, Fish shell, and a cohesive Nord/Catppuccin theme.

## 🎨 Theme & Aesthetics

- **Window Manager**: i3 with Nord color scheme
- **Terminal**: Ghostty with Catppuccin Mocha theme
- **Shell**: Fish with Catppuccin Mocha theme
- **Compositor**: Picom with blur effects and animations
- **Launcher**: Rofi with multiple themes by adi1090x
- **Font**: JetBrains Mono Nerd Font

## 📦 What's Included

### Core Configuration
- **i3**: Highly customized window manager with Nord theme, multi-monitor support, and custom keybindings
- **i3status**: Status bar with Nord colors and system monitoring
- **Fish**: Modern shell with vi mode, custom aliases, and zoxide integration
- **Ghostty**: Terminal emulator with Catppuccin theme
- **Neovim**: NvChad-based configuration with modern plugins
- **Rofi**: Beautiful launcher with multiple themes and styles

### Additional Tools
- **Picom**: Compositor with blur effects, shadows, and animations
- **Alacritty**: Alternative terminal emulator configuration
- **Dunst**: Notification daemon with custom styling
- **Ranger**: File manager with custom colors and settings
- **Flameshot**: Screenshot tool configuration
- **Cmus**: Music player with custom colors
- **Sway**: Wayland compositor configuration (i3 alternative)
- **Neofetch**: System information display

### System Files
- **Bash**: Custom .bashrc with zoxide integration
- **Git**: User configuration with ghq settings
- **Fonts**: JetBrains Mono Nerd Font included

## 🚀 Quick Start

### Prerequisites

Before installing, ensure you have the following packages installed:

```bash
# Ubuntu/Debian
sudo apt update
sudo apt install i3 fish ghostty rofi picom i3status neovim git curl fontconfig

# Arch Linux
sudo pacman -S i3 fish ghostty rofi picom i3status neovim git curl fontconfig

# Fedora
sudo dnf install i3 fish ghostty rofi picom i3status neovim git curl fontconfig
```

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ```

2. **Run the installation script:**
   ```bash
   ./install.sh
   ```

3. **Reload configurations:**
   ```bash
   # For i3
   i3-msg reload
   
   # For Fish shell
   source ~/.config/fish/config.fish
   
   # Or simply log out and back in
   ```

## 🛠️ Manual Installation

If you prefer to install manually or selectively:

```bash
# Home directory files
ln -sf ~/dotfiles/home/.bashrc ~/.bashrc
ln -sf ~/dotfiles/home/.profile ~/.profile
ln -sf ~/dotfiles/home/.gitconfig ~/.gitconfig

# Configuration files
ln -sf ~/dotfiles/config/i3 ~/.config/i3
ln -sf ~/dotfiles/config/fish ~/.config/fish
ln -sf ~/dotfiles/config/ghostty ~/.config/ghostty
ln -sf ~/dotfiles/config/rofi ~/.config/rofi
ln -sf ~/dotfiles/config/picom ~/.config/picom
ln -sf ~/dotfiles/config/i3status ~/.config/i3status
ln -sf ~/dotfiles/config/nvim ~/.config/nvim

# Install fonts
cp -r ~/dotfiles/fonts/* ~/.local/share/fonts/
fc-cache -fv
```

## 📁 Directory Structure

```
dotfiles/
├── config/
│   ├── i3/                 # i3 window manager configuration
│   ├── fish/               # Fish shell configuration
│   ├── ghostty/            # Ghostty terminal configuration
│   ├── rofi/               # Rofi launcher themes and configuration
│   ├── picom/              # Picom compositor configuration
│   ├── i3status/           # i3status bar configuration
│   ├── nvim/               # Neovim configuration (NvChad)
│   ├── neofetch/           # System information display
│   ├── alacritty/          # Alternative terminal configuration
│   ├── dunst/              # Notification daemon
│   ├── ranger/             # File manager
│   ├── flameshot/          # Screenshot tool
│   ├── cmus/               # Music player
│   └── sway/               # Wayland compositor (i3 alternative)
├── home/
│   ├── .bashrc             # Bash configuration
│   ├── .profile            # Shell profile
│   └── .gitconfig          # Git configuration
├── fonts/                  # Font files
├── install.sh              # Installation script
├── uninstall.sh            # Uninstallation script
└── README.md               # This file
```

## ⚙️ Key Features

### i3 Window Manager
- **Nord Color Scheme**: Beautiful, eye-friendly colors
- **Multi-Monitor Support**: Configured for multiple displays
- **Custom Keybindings**: Vim-style navigation and efficient workflows
- **Workspace Management**: Organized workspaces for different tasks
- **Tmux Integration**: Custom tmux session selector with fzf

### Fish Shell
- **Catppuccin Mocha Theme**: Consistent with terminal theme
- **Vi Mode**: Vim-like editing in the shell
- **Custom Aliases**: Productivity-focused shortcuts
- **Plugin Support**: fisher, z, fzf, bass, pisces, tide, fish-exa
- **Zoxide Integration**: Smart directory jumping

### Rofi Launcher
- **Multiple Themes**: 16 different color schemes
- **Various Styles**: 7 launcher types, 6 power menu types
- **Custom Scripts**: Specialized menus and applets
- **Beautiful Icons**: Consistent iconography

### Terminal Setup
- **Ghostty**: Modern terminal with GPU acceleration
- **Catppuccin Theme**: Consistent color scheme
- **JetBrains Mono Nerd Font**: Programming-focused font with icons
- **Tmux Integration**: Session management and productivity

## 🔧 Customization

### Changing Themes
- **i3 Colors**: Edit `config/i3/config` and modify the color variables
- **Terminal Theme**: Modify `config/ghostty/config` theme settings
- **Rofi Theme**: Switch between themes in `config/rofi/colors/`

### Adding New Configurations
1. Add your config files to the appropriate directory in `config/`
2. Update `install.sh` to include the new symbolic links
3. Update `uninstall.sh` to handle removal
4. Update this README with the new configuration

### Multi-Monitor Setup
The i3 configuration includes multi-monitor support. Edit the monitor assignments in `config/i3/config`:

```bash
# Monitor assignments
set $left_monitor DP-0.8
set $right_monitor HDMI-0
set $top_monitor DP-4
set $middle_monitor DP-2.8
```

## 📋 Dependencies

### Required Packages
- `i3` - Window manager
- `fish` - Shell
- `ghostty` - Terminal emulator
- `rofi` - Application launcher
- `picom` - Compositor
- `i3status` - Status bar
- `neovim` - Text editor
- `git` - Version control
- `curl` - HTTP client
- `fontconfig` - Font management

### Optional Packages
- `alacritty` - Alternative terminal
- `dunst` - Notification daemon
- `ranger` - File manager
- `flameshot` - Screenshot tool
- `cmus` - Music player
- `fzf` - Fuzzy finder
- `zoxide` - Smart directory jumping

### Fish Plugins
The Fish configuration includes several plugins managed by `fisher`:
- `z` - Directory jumping
- `fzf` - Fuzzy finder integration
- `bass` - Bash command compatibility
- `pisces` - Auto-closing brackets
- `tide` - Modern prompt
- `fish-exa` - Enhanced ls with exa

## 🔄 Updating

To update your dotfiles:

```bash
cd ~/dotfiles
git pull origin main
./install.sh
```

## 🗑️ Uninstallation

To remove the dotfiles and restore backups:

```bash
cd ~/dotfiles
./uninstall.sh
```

This will:
- Remove all symbolic links
- Offer to restore backed-up original files
- Leave fonts installed (remove manually if needed)

## 📸 Screenshots

*Add screenshots of your setup here*

## 🤝 Contributing

Feel free to fork this repository and customize it for your own needs. If you have improvements or fixes, pull requests are welcome!

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **adi1090x** for the beautiful Rofi themes
- **NvChad** for the excellent Neovim configuration
- **Catppuccin** for the beautiful color scheme
- **Nord** for the elegant color palette
- **JetBrains** for the excellent Mono font
- The entire open-source community for the amazing tools

## 📞 Support

If you encounter any issues or have questions:
1. Check the installation prerequisites
2. Ensure all dependencies are installed
3. Check the logs for any error messages
4. Open an issue on GitHub

---

*Happy coding! 🚀*
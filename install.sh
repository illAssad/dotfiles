#!/bin/bash

# Basil's Dotfiles Installation Script
# This script sets up symbolic links for all configuration files

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Function to print colored output
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to create symbolic link with backup
create_symlink() {
    local source="$1"
    local target="$2"
    
    # Create target directory if it doesn't exist
    mkdir -p "$(dirname "$target")"
    
    # If target exists and is not a symlink, back it up
    if [ -e "$target" ] && [ ! -L "$target" ]; then
        backup_file="${target}.backup.$(date +%Y%m%d_%H%M%S)"
        print_warning "Backing up existing file: $target -> $backup_file"
        mv "$target" "$backup_file"
    fi
    
    # Remove existing symlink if it exists
    if [ -L "$target" ]; then
        rm "$target"
    fi
    
    # Create the symlink
    ln -sf "$source" "$target"
    print_success "Linked: $source -> $target"
}

# Function to install fonts
install_fonts() {
    print_info "Installing fonts..."
    
    # Create fonts directory
    mkdir -p "$HOME/.local/share/fonts"
    
    # Copy fonts
    if [ -d "$DOTFILES_DIR/fonts" ]; then
        cp -r "$DOTFILES_DIR/fonts"/* "$HOME/.local/share/fonts/"
        
        # Update font cache
        if command -v fc-cache >/dev/null 2>&1; then
            fc-cache -fv
            print_success "Fonts installed and cache updated"
        else
            print_warning "fc-cache not found, fonts copied but cache not updated"
        fi
    else
        print_warning "No fonts directory found"
    fi
}

# Main installation function
main() {
    print_info "Starting Basil's Dotfiles Installation"
    print_info "Dotfiles directory: $DOTFILES_DIR"
    
    # Install home directory dotfiles
    print_info "Installing home directory dotfiles..."
    create_symlink "$DOTFILES_DIR/home/.bashrc" "$HOME/.bashrc"
    create_symlink "$DOTFILES_DIR/home/.profile" "$HOME/.profile"
    create_symlink "$DOTFILES_DIR/home/.gitconfig" "$HOME/.gitconfig"
    
    # Install .config files
    print_info "Installing .config files..."
    
    # i3 window manager
    create_symlink "$DOTFILES_DIR/config/i3" "$HOME/.config/i3"
    
    # Fish shell
    create_symlink "$DOTFILES_DIR/config/fish" "$HOME/.config/fish"
    
    # Ghostty terminal
    create_symlink "$DOTFILES_DIR/config/ghostty" "$HOME/.config/ghostty"
    
    # Rofi launcher
    create_symlink "$DOTFILES_DIR/config/rofi" "$HOME/.config/rofi"
    
    # Picom compositor
    create_symlink "$DOTFILES_DIR/config/picom" "$HOME/.config/picom"
    
    # i3status bar
    create_symlink "$DOTFILES_DIR/config/i3status" "$HOME/.config/i3status"
    
    # Neovim
    create_symlink "$DOTFILES_DIR/config/nvim" "$HOME/.config/nvim"
    
    # Neofetch
    create_symlink "$DOTFILES_DIR/config/neofetch" "$HOME/.config/neofetch"
    
    # Optional configurations (may not exist)
    if [ -d "$DOTFILES_DIR/config/alacritty" ]; then
        create_symlink "$DOTFILES_DIR/config/alacritty" "$HOME/.config/alacritty"
    fi
    
    if [ -d "$DOTFILES_DIR/config/dunst" ]; then
        create_symlink "$DOTFILES_DIR/config/dunst" "$HOME/.config/dunst"
    fi
    
    if [ -d "$DOTFILES_DIR/config/ranger" ]; then
        create_symlink "$DOTFILES_DIR/config/ranger" "$HOME/.config/ranger"
    fi
    
    if [ -d "$DOTFILES_DIR/config/flameshot" ]; then
        create_symlink "$DOTFILES_DIR/config/flameshot" "$HOME/.config/flameshot"
    fi
    
    if [ -d "$DOTFILES_DIR/config/cmus" ]; then
        create_symlink "$DOTFILES_DIR/config/cmus" "$HOME/.config/cmus"
    fi
    
    if [ -d "$DOTFILES_DIR/config/sway" ]; then
        create_symlink "$DOTFILES_DIR/config/sway" "$HOME/.config/sway"
    fi
    
    if [ -d "$DOTFILES_DIR/config/fontconfig" ]; then
        create_symlink "$DOTFILES_DIR/config/fontconfig" "$HOME/.config/fontconfig"
    fi
    
    # Install fonts
    install_fonts
    
    print_success "Dotfiles installation completed!"
    print_info "You may need to restart your shell or log out and back in for all changes to take effect."
    print_info "For i3 changes, reload with: i3-msg reload"
    print_info "For fish shell changes, run: source ~/.config/fish/config.fish"
}

# Check if script is being run directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
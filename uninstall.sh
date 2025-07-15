#!/bin/bash

# Basil's Dotfiles Uninstallation Script
# This script removes symbolic links created by the install script

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

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

# Function to remove symlink
remove_symlink() {
    local target="$1"
    
    if [ -L "$target" ]; then
        rm "$target"
        print_success "Removed symlink: $target"
    elif [ -e "$target" ]; then
        print_warning "File exists but is not a symlink, skipping: $target"
    else
        print_info "File does not exist, skipping: $target"
    fi
}

# Function to restore backup if exists
restore_backup() {
    local target="$1"
    
    # Find the most recent backup
    local backup_file
    backup_file=$(find "$(dirname "$target")" -name "$(basename "$target").backup.*" -type f 2>/dev/null | sort -r | head -n 1)
    
    if [ -n "$backup_file" ]; then
        print_info "Found backup: $backup_file"
        read -p "Do you want to restore this backup? (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            mv "$backup_file" "$target"
            print_success "Restored backup: $backup_file -> $target"
        fi
    fi
}

# Main uninstallation function
main() {
    print_info "Starting Basil's Dotfiles Uninstallation"
    
    # Remove home directory dotfiles
    print_info "Removing home directory dotfiles..."
    remove_symlink "$HOME/.bashrc"
    restore_backup "$HOME/.bashrc"
    
    remove_symlink "$HOME/.profile"
    restore_backup "$HOME/.profile"
    
    remove_symlink "$HOME/.gitconfig"
    restore_backup "$HOME/.gitconfig"
    
    # Remove .config files
    print_info "Removing .config files..."
    
    # List of config directories to remove
    config_dirs=(
        "i3"
        "fish"
        "ghostty"
        "rofi"
        "picom"
        "i3status"
        "nvim"
        "neofetch"
        "alacritty"
        "dunst"
        "ranger"
        "flameshot"
        "cmus"
        "sway"
        "fontconfig"
    )
    
    for dir in "${config_dirs[@]}"; do
        target="$HOME/.config/$dir"
        remove_symlink "$target"
        restore_backup "$target"
    done
    
    print_success "Dotfiles uninstallation completed!"
    print_info "Fonts were not removed. To remove them manually, check ~/.local/share/fonts/"
    print_info "You may need to restart your shell or log out and back in for all changes to take effect."
}

# Check if script is being run directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
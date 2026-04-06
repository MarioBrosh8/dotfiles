#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup"

echo "========================================"
echo "  Dotfiles Installation Script"
echo "========================================"

# Parse arguments
LINK_ONLY=false
if [[ "$1" == "--link-only" ]]; then
    LINK_ONLY=true
fi

# Create backup directory
mkdir -p "$BACKUP_DIR"

# Function to backup and link
link_file() {
    local src="$1"
    local dest="$2"
    local dir=$(dirname "$dest")
    
    mkdir -p "$dir"
    
    # Backup existing file
    if [[ -e "$dest" ]]; then
        if [[ -L "$dest" ]]; then
            echo "Skipping (already symlink): $dest"
        else
            echo "Backing up: $dest"
            cp -r "$dest" "$BACKUP_DIR/"
            rm -rf "$dest"
        fi
    fi
    
    # Check if source exists
    if [[ ! -e "$src" ]]; then
        echo "Warning: Source does not exist, skipping: $src"
        return 1
    fi
    
    # Create symlink
    echo "Linking: $dest -> $src"
    ln -s "$src" "$dest"
}

# Link zsh configs
link_file "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
link_file "$DOTFILES_DIR/zsh/.zshenv" "$HOME/.zshenv"
link_file "$DOTFILES_DIR/zsh/.zprofile" "$HOME/.zprofile"
link_file "$DOTFILES_DIR/zsh/.oh-my-zsh" "$HOME/.oh-my-zsh"

# Link tmux
link_file "$DOTFILES_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"

# Link config directories
link_file "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"
link_file "$DOTFILES_DIR/ghostty" "$HOME/.config/ghostty"
link_file "$DOTFILES_DIR/fastfetch" "$HOME/.config/fastfetch"

# Link misc
mkdir -p "$HOME/.misc"
link_file "$DOTFILES_DIR/misc/asciiart.txt" "$HOME/.misc/asciiart.txt"

# Link gitconfig
mkdir -p "$HOME/.config/git"
link_file "$DOTFILES_DIR/git/.gitconfig" "$HOME/.config/git/config"

if [[ "$LINK_ONLY" == true ]]; then
    exit 0
fi

# Initialize git submodules
echo ""
echo "Initializing git submodules..."
cd "$DOTFILES_DIR"
git submodule update --init --recursive 2>/dev/null || echo "(No submodules to init)"

echo ""
echo "========================================"
echo "  Installation Complete!"
echo "========================================"
echo ""
echo "Next steps:"
echo "  1. Restart your terminal or run: source ~/.zshrc"
echo "  2. In tmux, press Prefix + I to install plugins"
echo "  3. Open nvim and wait for plugins to install"

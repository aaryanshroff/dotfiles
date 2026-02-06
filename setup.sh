#!/bin/bash

# --- Configuration ---
DOTFILES_DIR="$HOME/dotfiles"
BACKUP_DIR="$HOME/dotfiles_old"
FILES=".zshrc .bashrc .gitconfig .shell_common"

# --- 1. Create Backup Directory ---
echo "Creating backup directory at $BACKUP_DIR"
mkdir -p "$BACKUP_DIR"

# --- 2. Loop Through Files ---
for file in $FILES; do
    echo "Processing $file..."

    # If the file exists in Home, move it to backup
    if [ -f "$HOME/$file" ] && [ ! -L "$HOME/$file" ]; then
        echo "  Backing up existing $file"
        mv "$HOME/$file" "$BACKUP_DIR/"
    fi

    # If it's already a symlink, delete it (to update link)
    if [ -L "$HOME/$file" ]; then
        echo "  Removing old symlink for $file"
        rm "$HOME/$file"
    fi

    # Create the new Symlink
    echo "  Linking $DOTFILES_DIR/$file -> $HOME/$file"
    ln -s "$DOTFILES_DIR/$file" "$HOME/$file"
done

# --- 3. VS Code Setup ---
echo "Setting up VS Code..."

# 1. Determine the correct settings folder based on OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS Path
    VSCODE_USER_DIR="$HOME/Library/Application Support/Code/User"
else
    # Linux Path (Standard)
    VSCODE_USER_DIR="$HOME/.config/Code/User"
fi

# 2. Check if VS Code folder exists (skip if VS Code isn't installed)
if [ -d "$VSCODE_USER_DIR" ]; then
    echo "  VS Code detected at $VSCODE_USER_DIR"
    
    KEYBINDINGS_SOURCE="$DOTFILES_DIR/vscode/keybindings.json"
    KEYBINDINGS_DEST="$VSCODE_USER_DIR/keybindings.json"

    # Backup existing keybindings if they exist and aren't already symlinked
    if [ -f "$KEYBINDINGS_DEST" ] && [ ! -L "$KEYBINDINGS_DEST" ]; then
        echo "  Backing up existing keybindings..."
        mv "$KEYBINDINGS_DEST" "$BACKUP_DIR/keybindings.json.bak"
    fi

    # Remove old symlink if it exists
    if [ -L "$KEYBINDINGS_DEST" ]; then
        rm "$KEYBINDINGS_DEST"
    fi

    # Create the Symlink
    echo "  Linking keybindings.json..."
    ln -s "$KEYBINDINGS_SOURCE" "$KEYBINDINGS_DEST"
else
    echo "  VS Code directory not found. Skipping VS Code setup."
fi
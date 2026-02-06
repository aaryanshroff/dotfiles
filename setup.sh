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
    VSCODE_USER_DIR="$HOME/Library/Application Support/Code/User"
else
    VSCODE_USER_DIR="$HOME/.config/Code/User"
fi

# 2. Check if VS Code folder exists
if [ -d "$VSCODE_USER_DIR" ]; then
    echo "  VS Code detected at $VSCODE_USER_DIR"
    
    # List of files to sync
    VS_FILES="keybindings.json settings.json"

    for file in $VS_FILES; do
        SOURCE="$DOTFILES_DIR/vscode/$file"
        DEST="$VSCODE_USER_DIR/$file"

        # Backup existing file if it's a real file (not a symlink)
        if [ -f "$DEST" ] && [ ! -L "$DEST" ]; then
            echo "  Backing up existing $file..."
            mv "$DEST" "$BACKUP_DIR/${file}.bak"
        fi

        # Remove old symlink if it exists
        if [ -L "$DEST" ]; then
            rm "$DEST"
        fi

        # Create the new Symlink
        echo "  Linking $file..."
        ln -s "$SOURCE" "$DEST"
    done
else
    echo "  VS Code directory not found. Skipping VS Code setup."
fi
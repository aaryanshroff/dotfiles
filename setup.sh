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

#!/bin/bash
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' 

DOTFILES_DIR="$HOME/dotfiles"
BACKUP_DIR="$HOME/dotfiles_backup"

FILES=(".gitconfig" ".bashrc" ".tmux.conf" ".muttrc" ".vimrc" ".viminfo" )
for file in "${FILES[*]}"; do echo -e "${GREEN} $file"; done

mkdir -p "$BACKUP_DIR"
#MAKING SYMLINK

for file in "${FILES[@]}"; do
	SOURCE="$DOTFILES_DIR/$file"
	TARGET="$HOME/$file"
	#skip if file non existant
	if [ ! -f "$SOURCE" ]; then
		echo -e "${RED}skipping $file, not found."
		continue
	fi
	#backing up the file
	if [ -f "$TARGET" ] || [ -L "$TARGET" ]; then
		echo -e "${YELLOW} backing up $file."
		cp -p "$TARGET" "$BACKUP_DIR/$file"
	fi
		echo -e "${YELLOW}creating symlink for $file."
		ln -sf "$SOURCE" "$TARGET"

done
echo -e "${GREEN} Script done. Backup files located at $BACKUP_DIR"



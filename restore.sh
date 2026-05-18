#!/usr/bin/env bash
set -euo pipefail

DOTDIR="$(cd "$(dirname "$0")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"

link() {
  local src="$1"
  local dest="$2"

  if [ -L "$dest" ]; then
    echo "Symlink exists: $dest"
    return
  fi

  if [ -e "$dest" ]; then
    echo "Backing up: $dest"
    mkdir -p "$BACKUP_DIR"
    cp -r "$dest" "$BACKUP_DIR/"
  fi

  echo "Linking: $dest -> $src"
  ln -sfn "$src" "$dest"
}

echo "=== Dotfiles Restore ==="
echo "Dotdir: $DOTDIR"
echo "Backup: $BACKUP_DIR"
echo ""

link "$DOTDIR/hypr"                "$HOME/.config/hypr"
link "$DOTDIR/kitty/kitty.conf"    "$HOME/.config/kitty/kitty.conf"
link "$DOTDIR/nvim"                "$HOME/.config/nvim"
link "$DOTDIR/rofi"                "$HOME/.config/rofi"
link "$DOTDIR/swaync"              "$HOME/.config/swaync"
link "$DOTDIR/waybar"              "$HOME/.config/waybar"

echo ""
echo "=== Restore Complete ==="

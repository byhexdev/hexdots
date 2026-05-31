#!/usr/bin/env bash
set -euo pipefail

DOTDIR="$(cd "$(dirname "$0")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"

install_pacman_packages() {
  local file="$DOTDIR/pkg.txt"
  if [ ! -f "$file" ]; then
    echo "pkg.txt not found, skipping pacman packages"
    return
  fi

  local packages=()
  while IFS= read -r line || [ -n "$line" ]; do
    line="$(echo "$line" | xargs)"
    [ -z "$line" ] || [[ "$line" == \#* ]] && continue
    packages+=("$line")
  done < "$file"

  if [ ${#packages[@]} -eq 0 ]; then
    echo "No pacman packages to install"
    return
  fi

  echo "Installing pacman packages: ${packages[*]}"
  sudo pacman -S --needed --noconfirm "${packages[@]}"
}

install_aur_packages() {
  local file="$DOTDIR/aur.txt"
  if [ ! -f "$file" ]; then
    echo "aur.txt not found, skipping AUR packages"
    return
  fi

  local packages=()
  while IFS= read -r line || [ -n "$line" ]; do
    line="$(echo "$line" | xargs)"
    [ -z "$line" ] || [[ "$line" == \#* ]] && continue
    packages+=("$line")
  done < "$file"

  if [ ${#packages[@]} -eq 0 ]; then
    echo "No AUR packages to install"
    return
  fi

  local aur_helper=""
  if command -v yay &>/dev/null; then
    aur_helper="yay"
  elif command -v paru &>/dev/null; then
    aur_helper="paru"
  else
    echo "No AUR helper found (yay or paru). Installing yay..."
    sudo pacman -S --needed --noconfirm git base-devel
    tmpdir=$(mktemp -d)
    git clone https://aur.archlinux.org/yay.git "$tmpdir/yay"
    makepkg -si --noconfirm --needed "$tmpdir/yay/PKGBUILD"
    rm -rf "$tmpdir"
    aur_helper="yay"
  fi

  echo "Installing AUR packages: ${packages[*]}"
  $aur_helper -S --needed --noconfirm "${packages[@]}"
}

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

echo "--- Installing Packages ---"
install_pacman_packages
install_aur_packages
echo ""

echo "--- Linking Configs ---"
mkdir -p "$HOME/.config/hypr"
for f in "$DOTDIR"/hypr/*; do
  link "$f" "$HOME/.config/hypr/$(basename "$f")"
done
link "$DOTDIR/kitty/kitty.conf"    "$HOME/.config/kitty/kitty.conf"
link "$DOTDIR/nvim"                "$HOME/.config/nvim"
link "$DOTDIR/rofi"                "$HOME/.config/rofi"
link "$DOTDIR/swaync"              "$HOME/.config/swaync"
link "$DOTDIR/waybar"              "$HOME/.config/waybar"

echo ""
echo "--- Proxy Setup ---"
autostart="$HOME/.config/hypr/hyprland/autostart.conf"
read -rp "Enable proxy (http://127.0.0.1:2080)? [Y/n] " ans
case "${ans,,}" in
  n|no)
    echo "Disabling proxy in $autostart"
    sed -i '/^# PROXIES/,/^$/ s/^[^#]/#&/' "$autostart"
    ;;
  *)
    echo "Proxy enabled"
    ;;
esac

echo ""
echo "=== Restore Complete ==="

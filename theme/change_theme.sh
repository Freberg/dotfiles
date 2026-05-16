#!/usr/bin/env bash

ENV_DIR="$HOME/.config/theme/env"

change_theme () {
  if [ "$1" == "wallpaper" ]; then
    app_dir="$HOME/.config/$1"
  else
    app_dir="${0%/*}/$1"
  fi
  find "$app_dir" -maxdepth 1 \( -name "$theme" -o -name "$theme.*" \) -print0 | \
    xargs -0 -I {} ln -rsf {} "$app_dir/current" || exit 1
}

list_themes() {
  if [ -d "$ENV_DIR" ]; then
    find "$ENV_DIR" -maxdepth 1 -type f ! -name "current" -printf "%f\n" | sed 's/\.[^.]*$//' | sort -u
  fi
}

theme=$1

if [ -z "$theme" ]; then
  echo "Usage: $(basename "$0") <theme_name>"
  echo "Available themes:"
  list_themes
  exit 0
fi

if ! list_themes | grep -qw "$theme"; then
  echo "Error: Theme '$theme' not found."
  echo "Available themes:"
  list_themes
  exit 1
fi

change_theme "env"
change_theme "css"
change_theme "hypr"
change_theme "kitty"
change_theme "wallpaper"

source "$HOME/.config/theme/env.sh"

killall -r -SIGUSR2 ".*waybar.*"
killall -USR1 kitty .kitty-wrapped 2>/dev/null
touch "$HOME/.config/wezterm/wezterm.lua"

if command -v swaync-client >/dev/null 2>&1; then
  swaync-client -rs
fi

if command -v swww >/dev/null 2>&1; then
  if [ -f "$HOME/.config/wallpaper/current" ]; then
    swww img "$HOME/.config/wallpaper/current" \
      --transition-type left \
      --transition-duration 1
  fi
fi

if command -v gsettings >/dev/null 2>&1; then
  gsettings set org.gnome.desktop.interface gtk-theme "$GTK_THEME"
  if [ "$IS_LIGHT_THEME" == "true" ]; then
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
  else
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
  fi
fi

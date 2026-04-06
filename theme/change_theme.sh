#!/usr/bin/env bash

change_theme () {
  if [ "$1" == "wallpaper" ]; then
    app_dir="$HOME/.config/$1"
  else
    app_dir="$( dirname -- "$0"; )/$1"
  fi
  ln -rsf "$app_dir/$theme"* "$app_dir/current" || exit 1
}

theme=$1

change_theme "env"
change_theme "css"
change_theme "hypr"
change_theme "kitty"
change_theme "wallpaper"

unset IS_LIGHT_THEME
source "$HOME/.config/theme/env/current"

killall -r -SIGUSR2 ".*waybar.*"
killall -USR1 kitty .kitty-wrapped 2>/dev/null
touch "$HOME/.config/wezterm/wezterm.lua"

if command -v swaync-client >/dev/null 2>&1; then
  swaync-client -rs
fi

if command -v swww >/dev/null 2>&1; then
  swww img "$HOME/.config/wallpaper/current" \
    --transition-type left \
    --transition-duration 1
fi

if command -v gsettings >/dev/null 2>&1; then
  gsettings set org.gnome.desktop.interface gtk-theme "$GTK_THEME"
  if [ "$IS_LIGHT_THEME" == "true" ]; then
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
  else
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
  fi
fi

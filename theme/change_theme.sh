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

change_theme "dunst"
change_theme "env"
change_theme "hypr"
change_theme "kitty"
change_theme "wallpaper"
change_theme "waybar"
change_theme "wofi"

killall -r -SIGUSR2 ".*waybar.*"
dunstctl reload
swww img "$HOME/.config/wallpaper/current" \
  --transition-type left \
  --transition-duration 1

#!/usr/bin/env bash

change_theme () {
  app_dir=$1
  ln -rsf "$( dirname -- "$0"; )/$app_dir/$theme"* "$( dirname -- "$0"; )/$app_dir/current" || exit 1
}

theme=$1

change_theme "alacritty"
change_theme "dircolors"
change_theme "dunst"
change_theme "hypr"
change_theme "kitty"
change_theme "wallpaper"
change_theme "waybar"
change_theme "wofi"

killall -r -SIGUSR2 ".*waybar.*"
killall -r ".*dunst.*"
nohup dunst -conf "~/.config/theme/dunst/current" >/dev/null 2>&1 &

sed -i "s/wallpaper = .*/wallpaper = ,~\/.config\/wallpaper\/${theme}.png/g" ~/.config/hypr/hyprpaper.conf
hyprctl monitors | grep 'Monitor' | awk '{ print $2 }' | xargs -I {} hyprctl hyprpaper wallpaper "{},~/.config/wallpaper/$theme.png"

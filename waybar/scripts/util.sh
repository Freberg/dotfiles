#!/usr/bin/env bash

function action_menu() {
    title="$1"
    actions="$2"
    height=$(($(echo -e "$actions" | wc -l) + 2))
    width=$(($(echo -e "$actions" | wc -L) * 10))

    selection="$(echo -e "$actions" | wofi -bdi -p "$title" -L $height -W $width -k /dev/null)"
    echo "$selection"
}

function launch_terminal() {
  source "$HOME/.config/theme/env/current"
  wezterm start "$@"
}

function update_waybar() {
    pkill -SIGRTMIN+8 waybar
}

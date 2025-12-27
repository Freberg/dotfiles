#!/usr/bin/env bash

function action_menu() {
  local title="$1"
  local actions="$2"
  local input_tmp
  local result_tmp
  result_tmp=$(mktemp)
  input_tmp=$(mktemp)

  echo -e "$actions" > "$input_tmp"

  kitten quick-access-terminal \
    --instance-group="action_menu" \
    sh -c "fzf --header='$title' --border < '$input_tmp' > '$result_tmp'"

  selection=$(cat "$result_tmp")
  rm "$input_tmp" "$result_tmp"
  echo "$selection"
}

function launch_terminal() {
  source "$HOME/.config/theme/env/current"
  wezterm start "$@"
}

function update_waybar() {
  pkill -SIGRTMIN+8 waybar
}

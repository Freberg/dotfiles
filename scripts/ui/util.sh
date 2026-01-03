#!/usr/bin/env bash

function action_menu() {
  local title="$1"
  local actions="$2"
  if [ -t 0 ]; then
    selection=$(echo -e "$actions" | fzf --header="$title" --border)
  else
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
  fi
  echo "$selection"
}

function launch_terminal() {
  source "$HOME/.config/theme/env/current"
  wezterm start "$@"
}

function launch_temp_terminal() {
  source "$HOME/.config/theme/env/current"
  kitten quick-access-terminal \
    --instance-group="temp" \
    "$@"
  }

function update_waybar() {
  pkill -SIGRTMIN+8 waybar
}

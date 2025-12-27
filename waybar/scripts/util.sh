#!/usr/bin/env bash

function action_menu() {
  local title="$1"
  local actions="$2"
  local result_tmp
  result_tmp=$(mktemp)

  kitten quick-access-terminal \
    --instance-group="action_menu" \
    sh -c "echo -e '$actions' | fzf --header='$title' --border > '$result_tmp'"

  selection=$(cat "$result_tmp")
  rm "$result_tmp"
  echo "$selection"
}

function launch_terminal() {
  source "$HOME/.config/theme/env/current"
  wezterm start "$@"
}

function update_waybar() {
  pkill -SIGRTMIN+8 waybar
}

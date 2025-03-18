#!/usr/bin/env bash

source "$(dirname "$0")/util.sh"

entries="$(hyprctl -j clients | jq -r '.[] | [.workspace.id, .class, .title] | @csv' | column -t -s '","')"

selected=$(action_menu "windows" "$entries" | awk '{print $1}')

[ -z "$selected" ] && exit 0

hyprctl dispatch workspace "$selected"

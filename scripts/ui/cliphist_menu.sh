#! /usr/bin/env bash

source "$(dirname "$0")/util.sh"

list=$(cliphist list)

if [[ -n "$list" ]]; then
  selected=$(action_menu "cliphist" "$list")
  if [[ -n "$selected" ]]; then
    echo "$selected" | cliphist decode | wl-copy && wtype -M ctrl -M shift v
  fi
fi

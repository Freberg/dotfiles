#!/usr/bin/env bash

source "$(dirname "$0")/util.sh"

SESSION_DIR="$HOME/.config/kitty/sessions"
mkdir -p "$SESSION_DIR"

list_sessions() {
  find "$SESSION_DIR" -name "*.kitty-session" -o -name "*.session" 2>/dev/null | while read -r file; do
  [ -z "$file" ] && continue
  name=$(basename "$file" | sed -E 's/\.(kitty-session|session)$//')
  echo "$name  →  $file"
done
}

sessions=$(list_sessions)

if [ -z "$sessions" ]; then
  echo "No sessions found in $SESSION_DIR" >&2
  exit 1
fi

selection=$(action_menu "Kitty Sessions" "$sessions")

if [ -n "$selection" ]; then
  SESSION_PATH=$(echo "$selection" | awk -F ' →  ' '{print $2}')
  if [ -n "$SESSION_PATH" ] && [ -f "$SESSION_PATH" ]; then
    kitten @ action goto_session "$SESSION_PATH"
  fi
fi


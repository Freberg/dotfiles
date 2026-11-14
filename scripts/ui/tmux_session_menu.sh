#!/usr/bin/env bash

source "$(dirname "$0")/util.sh"

list_sessions() {
  tmux list-panes -a -F '#{session_name}|#{pane_current_path}|#{session_windows}' 2>/dev/null \
    | awk -F'|' '!seen[$1]++' \
    | while IFS='|' read -r name cwd win_count; do
  [ -z "$name" ] && continue
  display_cwd="${cwd/#$HOME/~}"
  echo "$name ($win_count win, $display_cwd)  →  $name"
done
}

sessions=$(list_sessions)

if [ -z "$sessions" ]; then
  echo "No active Tmux sessions found." >&2
  exit 1
fi

selection=$(action_menu "Tmux Sessions" "$sessions")

if [ -n "$selection" ]; then
  SESSION_NAME=$(echo "$selection" | awk -F '  →  ' '{print $2}')
  if [ -n "$SESSION_NAME" ]; then
    if [ -n "${TMUX:-}" ]; then
      tmux switch-client -t "$SESSION_NAME"
    else
      tmux attach-session -t "$SESSION_NAME"
    fi
  fi
fi

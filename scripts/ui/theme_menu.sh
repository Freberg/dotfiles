#!/usr/bin/env bash

source "$HOME/.config/scripts/ui/util.sh"

THEME_DIR="$HOME/.config/theme/env"
CHANGE_SCRIPT="$HOME/.config/theme/change_theme.sh"

read -r -d '' PREVIEW_CMD << 'EOF'
printf "theme: {}\n\n";
for i in $(seq 0 7); do printf "\e[48;5;%dm  " $i; done; printf "\e[0m\n";
for i in $(seq 8 15); do printf "\e[48;5;%dm  " $i; done; printf "\e[0m\n\n";
EOF

if [ -L "$THEME_DIR/current" ]; then
  ORIGINAL_THEME=$(readlink "$THEME_DIR/current" | xargs basename | sed 's/\.[^.]*$//')
else
  ORIGINAL_THEME=""
fi

list_themes() {
  local others
  others=$(find "$THEME_DIR" -maxdepth 1 -type f ! -name "current" -printf "%f\n" | sed 's/\.[^.]*$//' | \
    grep -v "^${ORIGINAL_THEME}$" | sort -u)

  if [ -n "$ORIGINAL_THEME" ]; then
    echo "$ORIGINAL_THEME"
  fi
  echo "$others"
}

themes=$(list_themes)

fzf_flags="--bind 'focus:execute-silent($CHANGE_SCRIPT {})' --preview '$PREVIEW_CMD'"

selection=$(action_menu "themes" "$themes" "$fzf_flags")

if [ -n "$selection" ]; then
  "$CHANGE_SCRIPT" "$selection"
else
  if [ -n "$ORIGINAL_THEME" ]; then
    "$CHANGE_SCRIPT" "$ORIGINAL_THEME"
  fi
fi

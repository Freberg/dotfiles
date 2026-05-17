#!/usr/bin/env bash

ENV_DIR="$HOME/.config/theme/env"

change_theme () {
  if [ "$1" == "wallpaper" ]; then
    app_dir="$HOME/.config/$1"
  else
    app_dir="${0%/*}/$1"
  fi
  find "$app_dir" -maxdepth 1 \( -name "$theme" -o -name "$theme.*" \) -print0 | \
    xargs -0 -I {} ln -rsf {} "$app_dir/current" || exit 1
}

create_theme_files() {
  GTK_CSS="$HOME/.themes/$GTK_THEME/gtk-4.0/gtk.css"

  ACTIVE=$(grep -oP '@define-color theme_selected_bg_color \K[^;]+' "$GTK_CSS")
  INACTIVE=$(grep -oP '@define-color theme_bg_color \K[^;]+' "$GTK_CSS")

  mkdir -p "$HOME/.config/theme/niri" "$HOME/.config/theme/hypr"
  cat << EOF > "$HOME/.config/theme/niri/current.kdl"
layout {
  border {
    active-color "$(echo "$ACTIVE" | sed -E 's/#([0-9a-fA-F]{6})/#\1ff/')"
    inactive-color "$(echo "$INACTIVE" | sed -E 's/#([0-9a-fA-F]{6})/#\1ff/')"
  }
}
EOF
cat << EOF > "$HOME/.config/theme/hypr/current.lua"
return {
  active_border = "$(echo "$ACTIVE" | sed -E 's/#([0-9a-fA-F]{6})/rgb(\1)/')",
  inactive_border = "$(echo "$INACTIVE" | sed -E 's/#([0-9a-fA-F]{6})/rgb(\1)/')"
}
EOF
}

list_themes() {
  if [ -d "$ENV_DIR" ]; then
    find "$ENV_DIR" -maxdepth 1 -type f ! -name "current" -printf "%f\n" | sed 's/\.[^.]*$//' | sort -u
  fi
}

theme=$1

if [ -z "$theme" ]; then
  echo "Usage: $(basename "$0") <theme_name>"
  echo "Available themes:"
  list_themes
  exit 0
fi

if ! list_themes | grep -qw "$theme"; then
  echo "Error: Theme '$theme' not found."
  echo "Available themes:"
  list_themes
  exit 1
fi

change_theme "env"
change_theme "css"
change_theme "kitty"
change_theme "wallpaper"

source "$HOME/.config/theme/env.sh"
create_theme_files

killall -r -SIGUSR2 ".*waybar.*"
killall -USR1 kitty .kitty-wrapped 2>/dev/null
touch "$HOME/.config/wezterm/wezterm.lua"

if command -v swaync-client >/dev/null 2>&1; then
  swaync-client -rs
fi

if command -v swww >/dev/null 2>&1; then
  if [ -f "$HOME/.config/wallpaper/current" ]; then
    swww img "$HOME/.config/wallpaper/current" \
      --transition-type left \
      --transition-duration 1
  fi
fi

if command -v gsettings >/dev/null 2>&1; then
  gsettings set org.gnome.desktop.interface gtk-theme "$GTK_THEME"
  if [ "$IS_LIGHT_THEME" == "true" ]; then
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
  else
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
  fi
fi

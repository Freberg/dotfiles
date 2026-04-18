#!/usr/bin/env bash

source "$HOME/.config/theme/env.sh"

case "$1" in
    left)       echo "$SEPARATOR_LEFT" ;;
    right)      echo "$SEPARATOR_RIGHT" ;;
    left-thin)  echo "$SEPARATOR_LEFT_THIN" ;;
    right-thin) echo "$SEPARATOR_RIGHT_THIN" ;;
    *)          exit 1 ;;
esac

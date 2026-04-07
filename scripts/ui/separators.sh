#!/usr/bin/env bash

source "$HOME/.config/theme/env.sh"

case "$1" in
    left)
        echo "$SEPARATOR_LEFT"
        ;;
    right)
        echo "$SEPARATOR_RIGHT"
        ;;
    *)
        exit 1
        ;;
esac

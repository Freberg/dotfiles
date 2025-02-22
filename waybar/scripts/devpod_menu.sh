#!/usr/bin/env bash

source /etc/profile
source "$(dirname "$0")/util.sh"

entries="$(devpod ls | grep -v 'NAME\|+' | tr -d ' ' | column -s '|' -t)"

sleep 0.1

selected=$(action_menu "devpods" "$entries" | cut -d ' ' -f 1)

[ -z "$selected" ] && exit 0

actions=" up\n stop\n󰆴 delete"

selected_action=$(action_menu "devpod actions" "$actions" | cut -d ' ' -f 2)

case $selected_action in
    up)
        notify-send "devpod" "up ${selected}..."
        alacritty -e devpod up "${selected}"
        ;;
    stop)
        notify-send "devpod" "stopping ${selected}..."
        devpod stop ${selected}
        ;;
    delete)
        notify-send "devpod" "deleting ${selected}..."
        devpod delete ${selected}
        ;;
esac

update_waybar


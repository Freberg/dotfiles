#!/usr/bin/env bash

source "$(dirname "$0")/util.sh"

ENGINE="${1:-podman}"
if [[ "$ENGINE" != "docker" && "$ENGINE" != "podman" ]]; then
    notify-send "Container Error" "Invalid engine specified: $ENGINE (use 'docker' or 'podman')"
    exit 1
fi

entries="$($ENGINE ps -a --format 'table {{.ID}}\t{{.Image}}\t{{.Status}}' | tail -n +2)"

sleep 0.1

selected=$(action_menu "$ENGINE containers" "$entries" | cut -d ' ' -f 1)

[ -z "$selected" ] && exit 0

[ -z "$($ENGINE ps | grep $selected)" ] && actions=" start\n󰆴 delete" || actions=" stop\n󰜉 restart\n󰆴 delete\n󰿄 exec"

selected_action=$(action_menu "$ENGINE container actions" "$actions" | cut -d ' ' -f 2)

case $selected_action in
    stop)
        notify-send "$ENGINE" "stopping $selected..."
        $ENGINE stop "$selected"
        ;;
    start)
        notify-send "$ENGINE" "starting $selected..."
        $ENGINE start "$selected"
        ;;
    restart)
        notify-send "$ENGINE" "restarting $selected..."
        $ENGINE restart "$selected"
        ;;
    delete)
        notify-send "$ENGINE" "deleting $selected..."
        $ENGINE stop "$selected"; $ENGINE rm "$selected"
        ;;
    exec)
        notify-send "$ENGINE" "exec $selected..."
        launch_terminal $ENGINE exec -it -e TERM="$TERM" "$selected" bash
        ;;
esac

update_waybar


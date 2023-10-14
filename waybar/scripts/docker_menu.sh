#!/usr/bin/env bash

source "$(dirname "$0")/util.sh"

entries="$(docker ps -a --format 'table {{.ID}}\t{{.Image}}\t{{.Status}}')"

sleep 0.1

selected=$(action_menu "docker containers" "$entries" | cut -d ' ' -f 1) 

[ -z "$selected" ] && exit 0

[ -z "$(docker ps | grep $selected)" ] && actions=" start\n󰆴 delete" || actions=" stop\n󰜉 restart\n󰆴 delete\n󰿄 exec"

selected_action=$(action_menu "docker container actions" "$actions" | cut -d ' ' -f 2)

case $selected_action in
    stop)
        notify-send "docker" "stopping ${selected}..."
        docker stop $selected
        ;;
    start)
        notify-send "docker" "starting ${selected}..."
        docker start $selected
        ;;
    restart)
        notify-send "docker" "restarting ${selected}..."
        docker restart $selected
        ;;
    delete)
        notify-send "docker" "deleting ${selected}..."
        docker stop $selected; docker rm $selected
        ;;
    exec)
        notify-send "docker" "exec ${selected}..."
        kitty docker exec -it $selected sh
        ;;
esac


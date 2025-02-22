#!/usr/bin/env bash

source "$(dirname "$0")/util.sh"

function wifi_menu() {
    wifis="$(nmcli -f "SSID,BARS,IN-USE" dev wifi | tail -n +2)"
    selected_wifi=$(action_menu "wifis" "$wifis" | cut -d ' ' -f 1)
    connected_wifis=($(nmcli con show --active | grep wifi | awk '{print $1}'))
    
    if [[ ${connected_wifis[@]} =~ $selected_wifi ]]
    then
        notify-send "wifi" "diconnecting from $selected_wifi"
        nmcli con down "$selected_wifi"
    else
        notify-send "wifi" "connecting to $selected_wifi"
        nmcli con up "$selected_wifi" || alacritty -e nmcli dev wifi con "$selected_wifi" --ask
    fi
}

sleep 0.1

actions="󰖩 wifi\n info"
selected_action=$(action_menu "network actions" "$actions" | cut -d ' ' -f 2) 

case $selected_action in
    wifi)
        wifi_menu
        ;;
    info)
        action_menu "network info" "$(nmcli con show --active)"
esac

update_waybar

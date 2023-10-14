#!/usr/bin/env bash

source "$(dirname "$0")/util.sh"

function connect_vpn() {
    vpns=$(nmcli connection show | grep vpn | awk '{print $1}')
    selected_vpn=$(action_menu "vpns" $vpns)
    [ -z "$selected_vpn" ] && exit 0
    notify-send "vpn" "connecting to $selected_vpn"
    kitty nmcli connection up $selected_vpn --ask 
}

active_vpn=$(nmcli connection show --active | grep vpn | awk '{print $1}')
[ -n "$active_vpn" ] && actions=" disconnect" || actions="󱘖 connect"

sleep 0.1

selected_action=$(action_menu "vpn actions" "$actions" | cut -d ' ' -f 2) 
case $selected_action in
    disconnect)
        notify-send "vpn" "disconnecting from $active_vpn"
        nmcli connection down $active_vpn
        ;;
    connect)
        connect_vpn
        ;;
esac


    

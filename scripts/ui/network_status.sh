#!/usr/bin/env bash

active_connections=$(nmcli connection show --active);
network_status=$(nmcli connection show --active | grep "wifi" | awk '{print $1}')

if [ -n "$(echo -n "$active_connections" | grep "wifi" )" ]
then
    network_status="󰖩 $network_status" 
    network_details=$(nmcli dev wifi | grep '^*' |  awk -F '[[:space:]][[:space:]]+' '{print $6 " " $8}')
elif [ -n "$(echo -n "$active_connections" | grep "ethernet" )" ]
then
    network_status="󰈀 $network_status" 
    network_details="TODO"
else
    network_status="󰌙"
    network_details="no connections"
fi

echo "{\"text\":\"$network_status\", \"tooltip\":\"$network_details\"}"

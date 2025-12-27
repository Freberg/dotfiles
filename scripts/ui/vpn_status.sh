#!/usr/bin/env bash
vpn_status=$(nmcli connection show --active | grep vpn | awk '{print $1}')
if [ -n "$vpn_status" ]
then
    vpn_status=" $vpn_status" 
    vpn_details="connected to vpn"
else
    vpn_status=""
    vpn_details="no vpn connection"
fi
echo "{\"text\":\"$vpn_status\", \"tooltip\":\"$vpn_details\"}"

#!/usr/bin/env bash

ENGINE="${1:-podman}"
if [[ "$ENGINE" != "docker" && "$ENGINE" != "podman" ]]; then
    notify-send "Container Error" "Invalid engine specified: $ENGINE (use 'docker' or 'podman')"
    exit 1
fi

text=$($ENGINE ps -q | wc -l)
tooltip=$($ENGINE ps --format '{{println .Names }}' | awk NF | paste -sd "," -)
echo "{\"text\":\"$text\", \"tooltip\":\"$tooltip\"}"

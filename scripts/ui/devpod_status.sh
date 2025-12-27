#!/usr/bin/env bash
data=$(devpod ls | grep -v 'NAME\|+' | awk NF)
text=$(echo "$data" | awk NF | wc -l)
tooltip=$(echo "$data" | cut -d '|' -f 1 | tr -d ' ' | paste -sd ',' -)
echo "{\"text\":\"$text\", \"tooltip\":\"$tooltip\"}"

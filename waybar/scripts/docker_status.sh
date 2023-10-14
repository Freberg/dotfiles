#!/usr/bin/env bash
text=$(docker ps -q | wc -l)
tooltip=$(docker ps --format '{{println .Names }}' | awk NF | paste -sd "," -)
echo "{\"text\":\"$text\", \"tooltip\":\"$tooltip\"}"

#!/usr/bin/env bash

TICKER_LOGIC="$HOME/.config/scripts/ui/news_ticker.sh"
UNIT_NAME="newsboat-reload"

cleanup() {
  pkill -f "kitten panel.*news_ticker.sh"
  exit 0
}
trap cleanup SIGTERM SIGINT

if ! systemctl --user list-timers | grep -q "$UNIT_NAME.timer"; then
  systemd-run --user \
    --unit="$UNIT_NAME" \
    --on-calendar="*:0/30" \
    --description="Reload Newsboat RSS feeds every 30 minutes" \
    --setenv=PATH="/run/current-system/sw/bin:/etc/profiles/per-user/$USER/bin" \
    newsboat -x reload
fi

if hyprctl monitors >/dev/null 2>&1; then
    mapfile -t MONITORS < <(hyprctl monitors -j | jq -r '.[].name')
else
    mapfile -t MONITORS < <(niri msg -j outputs | jq -r 'keys[]')
fi

for MONITOR in "${MONITORS[@]}"; do
  pgrep -f "kitten panel.*--output-name=$MONITOR.*news_ticker.sh" > /dev/null && continue

  kitten panel \
    --output-name="$MONITOR" \
    --lines=20px \
    --override-exclusive-zone \
    --exclusive-zone=-1 \
    --edge=top \
    --layer=bottom \
    -o "background_opacity=1.0" \
    bash "$TICKER_LOGIC" &
done

wait

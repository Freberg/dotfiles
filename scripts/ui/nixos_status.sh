#!/usr/bin/env bash

FLAKE_DIR="$(git rev-parse --show-toplevel 2>/dev/null || echo "$HOME/dotfiles")/flake"
CONFIG_NAME="$(hostname | sed -E 's/-([a-z])/\U\1/g')"
OUTPUT_FILE="/tmp/nixos-update-diff.txt"
UNIT_NAME="nixos-update-check"

if ! systemctl --user list-timers | grep -q "$UNIT_NAME.timer"; then
  systemd-run --user \
    --unit="$UNIT_NAME" \
    --on-calendar="12:00" \
    --description="Daily NixOS Update Check" \
    bash -c "nix build '$FLAKE_DIR#nixosConfigurations.$CONFIG_NAME.config.system.build.toplevel' \
      --refresh \
      --no-write-lock-file \
      --print-out-paths \
      --no-link > /dev/null && \
      nvd diff /run/current-system \$(nix build '$FLAKE_DIR#nixosConfigurations.$CONFIG_NAME.config.system.build.toplevel' \
      --no-write-lock-file \
      --print-out-paths \
      --no-link) > $OUTPUT_FILE && \
      notify-send 'NixOS' 'Update check complete'"
fi

if [ -f "$OUTPUT_FILE" ]; then
  count=$(grep -cE '^(\[|\+|-)' "$OUTPUT_FILE")
  nix_tooltip=$(cat "$OUTPUT_FILE" | tail +3 | tr '\n' '\r')
else
  count="0"
  nix_tooltip="No update data available. Run check script."
fi

jq -nc --unbuffered --arg status "󱄅 $count" --arg tooltip "$nix_tooltip" '{"text": $status, "tooltip": $tooltip}'

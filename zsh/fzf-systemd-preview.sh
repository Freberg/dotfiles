#!/bin/sh

UNIT=$(echo "$1" | awk '{print $1}')
SCOPE_VAL=$(echo "$1" | awk '{print $2}')

SCOPE_FLAG=""
if [ "$SCOPE_VAL" = "user" ]; then
    SCOPE_FLAG="--user"
else
    SCOPE_FLAG="--system"
fi

if [ "$UNIT" = "UNIT" ] || [ -z "$UNIT" ]; then
    exit 0
fi

export SYSTEMD_COLORS=1

echo "--- Status: $UNIT ($SCOPE_VAL) ---"
systemctl $SCOPE_FLAG status "$UNIT" --no-pager

echo "--- Recent Logs ---"
journalctl $SCOPE_FLAG -u "$UNIT" -n 30 --no-pager

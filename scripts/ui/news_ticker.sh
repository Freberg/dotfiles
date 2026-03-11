#!/usr/bin/env bash

DB_FILE="$HOME/.local/share/newsboat/cache.db"
DELIMITER=" 󰇙 "
NEWS_COUNT=15

while true; do
  NEWS=$(sqlite3 "$DB_FILE" "SELECT title FROM rss_item ORDER BY pubDate DESC LIMIT $NEWS_COUNT;" \
    | awk -v d="$DELIMITER" '{printf "%s%s", $0, d}' | sed "s/$DELIMITER$//")

  WIDTH=$(tput cols)
  ITER_STRING="$NEWS$NEWS"

  for (( i=0; i<${#NEWS}; i++ )); do
    printf "\r%-${WIDTH}.${WIDTH}s" "${ITER_STRING:$i}"
    sleep 0.2
  done
done

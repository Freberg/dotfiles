#!/usr/bin/env bash

source "$(dirname "$0")/util.sh"

IFS=':' read -ra ADDR <<< "$XDG_DATA_DIRS"
APP_PATHS=()
for dir in "${ADDR[@]}"; do
  if [[ -d "$dir/applications" ]]; then
    APP_PATHS+=("$dir/applications")
  fi
done

list=$(find -L "${APP_PATHS[@]}" -name "*.desktop" -print0 2>/dev/null | \
  xargs -0 grep -HE "^\[|^Name=|^Exec=|^Terminal=|^NoDisplay=" 2>/dev/null | awk -F: '
$1 != last_file {
  in_main = 1
  last_file = $1
}

BEGINFILE {
  in_main = 1
}

/:\[/ && !/:\[Desktop Entry\]/ {
  in_main = 0
}

in_main == 1 {
  file=$1; line=$2;
  split(line, a, "=");
  key=a[1]; val=a[2];

  if (key=="NoDisplay" && val=="true") { skip[file]=1 }
  if (key=="Name") { name[file]=val }
  if (key=="Exec") { gsub(/%[a-zA-Z]/, "", val); exec[file]=val }
  if (key=="Terminal") { term[file]=val }
}
END {
  for (f in name) {
    if (!skip[f] && name[f] != "" && exec[f] != "") {
       printf "%s|\t|%s|\t|%s\n", name[f], exec[f], (term[f]=="true"?"terminal":"gui")
    }
  }
}' |\
  sort -u | column -t -s '|')

selected=$(action_menu "apps" "$list")

if [[ -n "$selected" ]]; then
  cmd=$(echo "$selected" | cut -f2 | xargs)
  term=$(echo "$selected" | cut -f3 | xargs)

  if [[ "$term" == "terminal" ]]; then
    kitty --detach sh -c "$cmd"
  else
    systemd-run --user --scope --collect \
      --unit="app-fzf-$(date +%s)" \
      bash -c "exec $cmd" >/dev/null 2>&1 &
  fi
fi

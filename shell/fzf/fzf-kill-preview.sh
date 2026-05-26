echo "$1" | awk '{print $2}' | xargs -I PID nu -c 'ps -l | where pid == PID | to json' | bat -pl json --color always

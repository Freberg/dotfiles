echo "$1" | awk '{print $2}' | xargs -I PID witr --pid PID

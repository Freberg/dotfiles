echo "$1" | awk '{print $1}' | xargs git log --color=always

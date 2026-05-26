echo "$1" | awk '{print $1}' | xargs docker inspect | bat -pl json --color always

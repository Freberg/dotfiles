model=$(echo "$1" | awk '{print $1}')
ollama show "$model" | bat -pl conf --color always


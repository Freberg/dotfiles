#!/bin/sh
line="$1"
num_fields=$(echo "$line" | awk '{print NF}')

if [ "$num_fields" -ge 5 ]; then
    # Resource type completion
    type=$(echo "$line" | awk '{print $1}')
    kubectl explain "$type"
elif [ "$num_fields" -eq 3 ]; then
    # Resource name completion
    type=$(echo "$line" | awk '{print $1}')
    name=$(echo "$line" | awk '{print $2}')
    namespace=$(echo "$line" | awk '{print $3}')
    kubectl describe "$type" "$name" -n "$namespace"
fi

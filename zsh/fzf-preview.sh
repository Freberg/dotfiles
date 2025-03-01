if [ -d $1 ]; then
    eza --tree --color=always "$1" -L 5 | head -200
    exit 0
fi
type=$(file --brief --dereference --mime -- "$1")
if [[ ! $type =~ image/ ]]; then
    bat --color=always --line-range :500 "$1";
else
    dim=${FZF_PREVIEW_COLUMNS}x${FZF_PREVIEW_LINES}
    #imgcat --width "${dim%%x*}" --half-height "$1"
    chafa -s "$dim" "$1"
fi

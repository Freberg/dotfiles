export ZSH_FZF_HISTORY_SEARCH_EVENT_NUMBERS=0
export ZSH_FZF_HISTORY_SEARCH_DATES_IN_SEARCH=0
export ZSH_FZF_HISTORY_SEARCH_REMOVE_DUPLICATES=1

show_file_or_dir_preview="$HOME/.config/shell/fzf/fzf-preview.sh {}"
export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview '$show_file_or_dir_preview'"

typeset -A FZF_CMD_MAP
FZF_CMD_MAP=(
  [journalctl]=systemctl
  [mvnd]=mvn
  [mvnw]=mvn
)

FZF_SUPPORTED_COMMANDS=(
  kubectl gradle mvn systemctl docker git glab ps kill ssh ollama
)

for cmd in "${FZF_SUPPORTED_COMMANDS[@]}"; do
  # shellcheck source=/dev/null
  [ -f "$HOME/.config/shell/fzf/fzf-$cmd.sh" ] && source "$HOME/.config/shell/fzf/fzf-$cmd.sh"
  [ -n "$BASH" ] && complete -F "_fzf_complete_$cmd" -o default -o bashdefault "$cmd" 
done

# util function to make fzf functions behave similarly in bash and zsh
_fzf_normalize_completion_context() {
  if [ -n "$BASH_VERSION" ]; then
    __CMD="$1"
    __CURR_WORD="$2"
    __PREV_WORD="$3"
  fi
  if [ -n "$ZSH_VERSION" ]; then
    __CURR_WORD="${prefix:-}"
    local lbuf="$1"
    lbuf="${lbuf%\*\*}"
    lbuf="${lbuf%"${lbuf##*[![:space:]]}"}"
    __PREV_WORD="${lbuf##* }"
    __CMD="${lbuf%% *}"
  fi
}

_fzf_comprun() {
  local command=$1
  shift

  local resolved_cmd=${FZF_CMD_MAP[$command]:-$command}
  local preview_script="$HOME/.config/shell/fzf/fzf-$resolved_cmd-preview.sh"

  if [ -f "$preview_script" ]; then
    fzf "$@" --preview "sh $preview_script {}"
  else
    case "$command" in
      export|unset) fzf "$@" --preview "eval 'echo \${}' | bat -pl sh --color always" ;;
      *) fzf "$@" --preview "$show_file_or_dir_preview" ;;
    esac
  fi
}


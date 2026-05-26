_fzf_complete_git() {
  _fzf_normalize_completion_context "$@"

  if [ "$__CMD" != "git" ]; then
    return 0
  fi

  case "$__PREV_WORD" in
    "checkout"|"diff"|"branch"|"switch"|"rebase"|"merge") _fzf_complete "--multi" "$@" < <(
      git for-each-ref --sort=-committerdate refs/heads/ \
        --format='%(refname:short)|%(committerdate:short)|%(contents:subject)' | column -t -s '|'
      )
      return 0
      ;;
  esac
}

_fzf_complete_git_post() {
  awk '{print $1}'
}

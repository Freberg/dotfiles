_fzf_complete_glab() {
  _fzf_normalize_completion_context "$@"

  if [ "$__CMD" != "glab" ]; then
    return 0
  fi

  if [ "$__PREV_WORD" = "mr" ]; then
    _fzf_complete "--multi --header-lines=1" "$@" < <(
      glab mr list 2>/dev/null | grep -ve '^$'
    )
    return 0
  fi
}

_fzf_complete_glab_post() {
  awk '{print $1}' | sed 's/!//'
}

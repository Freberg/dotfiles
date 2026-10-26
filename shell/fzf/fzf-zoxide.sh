_fzf_complete_z() {
  _fzf_complete_zoxide "$@"
}

_fzf_complete_zoxide() {
  _fzf_normalize_completion_context "$@"
  _fzf_complete "--header-lines=0 " "$@" < <(
    zoxide query -l "$__CURR_WORD"
  )
}

_fzf_complete_ps() {
  _fzf_complete "--multi --header-lines=1 " "$@" < <(
    ps -ef --sort -time
  )
}

_fzf_complete_ps_post() {
  awk '{print $2}'
}

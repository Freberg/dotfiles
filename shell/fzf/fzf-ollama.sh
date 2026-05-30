_fzf_complete_ollama() {
  _fzf_complete "--multi --prompt='select model' --header-lines=1" "$@" < <(
    ollama ls 2>/dev/null
  )
}

_fzf_complete_ollama_post() {
  awk '{print $1}'
}

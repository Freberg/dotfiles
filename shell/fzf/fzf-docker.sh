_fzf_complete_docker() {
  _fzf_normalize_completion_context "$@"

  if [ "$__CMD" != "docker" ]; then
    return 0
  fi

  if [ "$__PREV_WORD" = "image" ]; then
    _fzf_complete "--multi --header-lines=1" "$@" < <(
      docker image ls --format "table {{.ID}}\t{{.Repository}}\t{{.Tag}}\t{{.Size}}" 2>/dev/null
    )
    return 0
  fi

  _fzf_complete "--multi --header-lines=1" "$@" < <(
    docker ps -a 2>/dev/null
  )
}

_fzf_complete_docker_post() {
  awk '{print $1}'
}


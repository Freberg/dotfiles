_fzf_complete_systemctl() {
  _fzf_normalize_completion_context "$@"

  _fzf_complete "--header-lines=1 --multi --prompt='systemctl > '" "$@" < <(
    _fzf_systemd_list_units "$__CURR_WORD"
  )
}

_fzf_complete_journalctl() {
  _fzf_normalize_completion_context "$@"

  case "$__PREV_WORD" in
    "-u"|"--unit")
      _fzf_complete "--header-lines=1 --prompt='journalctl -u > '" "$@" < <(
        _fzf_systemd_list_units "$__CURR_WORD"
      )
      ;;
    *)
      _fzf_path_completion "$@"
      ;;
  esac
}

_fzf_systemd_list_units() {
  local lbuf="$1"
  echo "UNIT SCOPE SUB ACTIVE"

  if [ "${lbuf#*--user}" != "$lbuf" ]; then
    systemctl --user list-units --all --no-legend | awk '{print $1, "user", $3, $4}'
  elif [ "${lbuf#*--system}" != "$lbuf" ]; then
    systemctl --system list-units --all --no-legend | awk '{print $1, "system", $3, $4}'
  else
    systemctl --system list-units --all --no-legend | awk '{print $1, "system", $3, $4}'
    systemctl --user list-units --all --no-legend | awk '{print $1, "user", $3, $4}'
    fi | column -t
}

_fzf_complete_systemctl_post() {
  awk '{print $1}'
}

_fzf_complete_journalctl_post() {
  awk '{print $1}'
}

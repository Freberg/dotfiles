_fzf_systemd_list_units() {
    local ARGS="$1"
    echo "UNIT SCOPE SUB ACTIVE"
    {
        if [[ $ARGS != *"--user"* ]]; then
            systemctl --system list-units --all --no-legend | awk '{print $1, "system", $3, $4}'
        fi
        if [[ $ARGS == *"--user"* ]] || [[ $ARGS != *"--system"* ]]; then
            systemctl --user list-units --all --no-legend | awk '{print $1, "user", $3, $4}'
        fi
    } | column -t
}

_fzf_complete_systemctl() {
    local ARGS="$@"
    _fzf_complete "--header-lines=1 --multi --prompt='systemctl > '" "$@" < <(
        _fzf_systemd_list_units "$ARGS"
    )
}

_fzf_complete_journalctl() {
    local ARGS="$@"
    if [[ $ARGS == *" -u"* || $ARGS == *" --unit"* ]]; then
        _fzf_complete "--header-lines=1 --prompt='journalctl -u > '" "$@" < <(
            _fzf_systemd_list_units "$ARGS"
        )
    else
        _fzf_path_completion "$@"
    fi
}

_fzf_complete_systemctl_post() {
    awk '{print $1}'
}

_fzf_complete_journalctl_post() {
    awk '{print $1}'
}

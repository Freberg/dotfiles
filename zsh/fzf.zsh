export ZSH_FZF_HISTORY_SEARCH_EVENT_NUMBERS=0
export ZSH_FZF_HISTORY_SEARCH_DATES_IN_SEARCH=0
export ZSH_FZF_HISTORY_SEARCH_REMOVE_DUPLICATES=1

source ~/.config/zsh/fzf-kubectl.zsh

show_file_or_dir_preview="~/.config/zsh/fzf-preview.sh {}"
export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview '$show_file_or_dir_preview'"

_fzf_comprun() {
    local command=$1
    shift
    case "$command" in
        export|unset)   fzf --preview "eval 'echo \${}'" "$@" ;;
        ssh)            fzf --preview 'dig {}' "$@" ;;
        ps)             fzf --preview "echo {} | awk '{print \$2}' | xargs -I PID nu -c 'ps -l | where pid == PID | to json' | \
                            bat -pl json --color always" "$@" ;;
        docker)         fzf --preview "echo {} | awk '{print \$1}' | xargs docker inspect | \
                            bat -pl json --color always" "$@" ;;
        kubectl)        fzf --preview "sh ~/.config/zsh/fzf-kubectl-preview.sh {}" "$@" ;;
        git)            fzf --preview "echo {} | awk '{print \$1}' | xargs git log --color=always" "$@" ;;
        glab)           fzf --preview "echo {} | awk '{print \$1}' | xargs glab mr view" "$@" ;;
        *)              fzf --preview "$show_file_or_dir_preview" "$@" ;;
    esac
}

_fzf_complete_docker() {
    ARGS="$@"
    if [[ $ARGS == 'docker image'* ]]; then
        _fzf_complete "--multi --header-lines=1 " "$@" < <(
            docker image ls --format "table {{.ID}}\t{{.Repository}}\t{{.Tag}}\t{{.Size}}"
        )
    else
        _fzf_complete "--multi --header-lines=1 " "$@" < <(
            docker ps -a
        )
    fi
}

_fzf_complete_docker_post() {
    awk '{print $1}'
}

_fzf_complete_git() {
    ARGS="$@"
    if [[ $ARGS == 'git checkout'* || $ARGS == 'git diff'* || $ARGS == 'git branch'* || $ARGS == 'git switch'* || $ARGS == 'git rebase'* || $ARGS == 'git merge'* ]]; then  
        _fzf_complete "--multi " "$@" < <(
            git for-each-ref --sort=-committerdate refs/heads/ \
              --format='%(refname:short)|%(committerdate:short)|%(contents:subject)' | column -t -s '|'
        )
    fi
}

_fzf_complete_git_post() {
    awk '{print $1}'
}

_fzf_complete_glab() {
    ARGS="$@"
    if [[ $ARGS == 'glab mr'* ]]; then
        _fzf_complete "--multi --header-lines=1 " "$@" < <(
            glab mr list | grep -ve '^$'1
        )
    fi
}

_fzf_complete_glab_post() {
    awk '{print $1}' | sed 's/!//'
}

_fzf_complete_ps() {
    _fzf_complete "--multi --header-lines=1 " "$@" < <(
        ps -ef
    )
}

_fzf_complete_ps_post() {
    awk '{print $2}'
} 

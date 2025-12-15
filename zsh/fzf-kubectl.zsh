_fzf_complete_kubectl() {
    local ARGS words resource_type all_resource_names_and_aliases command
    ARGS="$@"
    words=(${(s: :)ARGS})
    command=${words[2]}

    if [[ ${words[1]} != "kubectl" ]]; then
        return
    fi

    if [[ "$command" == "get" || "$command" == "describe" ]]; then
        if [[ -n ${words[3]} ]]; then
            resource_type=${words[3]}
            all_resource_names_and_aliases=$(kubectl api-resources --no-headers | awk '{print $1, $2}' | tr ',' ' ')
            if echo "$all_resource_names_and_aliases" | grep -q -w "$resource_type"; then
                _fzf_complete "--header-lines=1 --prompt=\"select ${resource_type} > \"" "$@" < <(
                    {
                        echo "TYPE NAME NAMESPACE"
                        kubectl get "$resource_type" -A -o=custom-columns=NAME:.metadata.name,NAMESPACE:.metadata.namespace --no-headers | \
                            awk -v type="$resource_type" '{print type, $1, $2}'
                    }
                )
                return
            fi
        fi
        # Fallback for `kubectl get` (complete resource type)
        _fzf_complete "--header-lines=1 --prompt=\"kubectl $command > \"" "$@" < <(
            kubectl api-resources
        )
        return
    fi

    if [[ "$command" == "logs" ]]; then
        _fzf_complete "--header-lines=1 --prompt=\"select pod > \"" "$@" < <(
            {
                echo "TYPE NAME NAMESPACE"
                kubectl get pods -A -o=custom-columns=NAME:.metadata.name,NAMESPACE:.metadata.namespace --no-headers | \
                    awk -v type="pod" '{print type, $1, $2}'
            }
        )
        return
    fi
}

_fzf_complete_kubectl_post() {
    awk '{if (NF==3) print $2; else print $1}'
}

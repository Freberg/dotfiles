_fzf_complete_kubectl() {
  _fzf_normalize_completion_context "$@"

  if [ "$__CMD" != "kubectl" ]; then
    return 0
  fi

  if [ "$__PREV_WORD" = "get" ] || [ "$__PREV_WORD" = "describe" ] || [ -n "$__WORD_3" ]; then
    if [ "$__PREV_WORD" != "kubectl" ] && [ "$__PREV_WORD" != "get" ] && [ "$__PREV_WORD" != "describe" ]; then
      local resource_type="$__PREV_WORD"
      local all_resources

      all_resources=$(kubectl api-resources --no-headers 2>/dev/null | awk '{print $1, $2}' | tr ',' ' ')

      if echo "$all_resources" | grep -q -w "$resource_type"; then
        _fzf_complete "--header-lines=1 --prompt=\"select ${resource_type} > \"" "$@" < <(
          echo "TYPE NAME NAMESPACE"
          kubectl get "$resource_type" -A -o=custom-columns=NAME:.metadata.name,NAMESPACE:.metadata.namespace \
            --no-headers 2>/dev/null | \
            awk -v type="$resource_type" '{print type, $1, $2}'
          )
          return 0
      fi
    fi

    if [ "$__PREV_WORD" = "get" ] || [ "$__PREV_WORD" = "describe" ]; then
      _fzf_complete "--header-lines=1 --prompt=\"kubectl $__PREV_WORD > \"" "$@" < <(
        kubectl api-resources 2>/dev/null
      )
      return 0
    fi
  fi

  if [ "$__PREV_WORD" = "logs" ]; then
    _fzf_complete "--header-lines=1 --prompt=\"select pod > \"" "$@" < <(
      echo "TYPE NAME NAMESPACE"
      kubectl get pods -A -o=custom-columns=NAME:.metadata.name,NAMESPACE:.metadata.namespace --no-headers 2>/dev/null | \
        awk -v type="pod" '{print type, $1, $2}'
      )
      return 0
  fi
}

_fzf_complete_kubectl_post() {
  awk '{if (NF==3) print $2; else print $1}'
}


_fzf_complete_mvnw() {
  _fzf_complete_mvn "$@"
}

_fzf_complete_mvn() {
  local ARGS words command
  ARGS="$@"
  words=(${(s: :)ARGS})
  command=${words[2]}

  if [[ ${words[-1]} == "test" ]]; then
    _fzf_complete "--prompt=\"Select Test Class (for -Dtest=) > \"" "$@" < <(
      _fzf_get_mvn_test_classes | sed 's/^/-Dtest=/'
    )
    return
  fi

  if [[ ${words[-1]} == "dependency:tree" ]]; then
    _fzf_complete "--prompt=\"Select Dependency (Group:Artifact) > \"" "$@" < <(
      _fzf_get_mvn_dependencies | ses 's/^/-Dincludes=/'
    )
    return
  fi

  if [[ ${words[-1]} == "-pl" || ${words[-1]} == "--projects" ]]; then
    _fzf_complete "--prompt=\"Select Module (for -pl) > \"" "$@" < <(
      _fzf_get_mvn_modules
    )
    return
  fi

  if [[ ${#words} -eq 1 ]]; then
    local common_commands
    common_commands=(
      "clean install"
      "clean install -DskipTests"
      "clean test"
      "dependency:tree"
    )
    _fzf_complete "--prompt=\"Select Common Maven Command > \"" "$@" < <(
      echo "${(j:\n:)common_commands}"
    )
    return
  fi

  return $COMP_SKIP_DEFAULT
}

_fzf_get_mvn_modules() {
  find . -name 'pom.xml' -not -path './pom.xml' | sed 's/\.\///' | xargs dirname
}

_fzf_get_mvn_test_classes() {
  find . -type f -name '*Test.java' -not -path '*/\.*' 2>/dev/null | \
    sed 's/\.java$//' | \
    awk '{
      if (match($0, /src\/test\/java\//)) {
        path = substr($0, RSTART + RLENGTH);
        gsub(/\//, ".", path);
        print path
      }
  }'
}

_fzf_get_mvn_dependencies() {
  local tree_output_file=$(mktemp)
  if ! mvn dependency:tree -B -DoutputType=text > "$tree_output_file" 2>/dev/null; then
    rm -f "$tree_output_file"
    return 1
  fi

  grep -E '^[|\s]*[+-]\-' "$tree_output_file" | 
    sed -E 's/^[| \t]*((\+-)|(\\-)) //' | 
    awk -F ':' '{print $1 ":" $2}' | 
    sort -u
  rm -f "$tree_output_file"
}

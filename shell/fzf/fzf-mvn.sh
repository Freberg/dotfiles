_fzf_complete_mvnd() {
  _fzf_complete_mvn "$@"
}

_fzf_complete_mvnw() {
  _fzf_complete_mvn "$@"
}

_fzf_complete_mvn() {
  _fzf_normalize_completion_context "$@"
  case "$__PREV_WORD" in
    "test")
      _fzf_complete "--prompt=\"Select Test Class (for -Dtest=) > \"" "$@" < <(
        _fzf_get_mvn_test_classes | sed 's/^/-Dtest=/'
      )
      return 0
      ;;
    "dependency:tree")
      _fzf_complete "--prompt=\"Select Dependency (Group:Artifact) > \"" "$@" < <(
        _fzf_get_mvn_dependencies | sed 's/^/-Dincludes=/'
      )
      return 0
      ;;
    "-pl"|"--projects")
      _fzf_complete "--prompt=\"Select Module (for -pl) > \"" "$@" < <(
        _fzf_get_mvn_modules
      )
      return 0
      ;;
    "mvn"|"mvnw"|"mvnd")
      _fzf_complete "--prompt=\"Select Common Maven Command > \"" "$@" < <(
        echo "clean install"
        echo "clean install -DskipTests"
        echo "clean test"
        echo "dependency:tree"
      )
      return 0
      ;;
  esac
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
  local tree_output_file
  tree_output_file=$(mktemp)
  if ! mvn dependency:tree -B -DoutputType=text > "$tree_output_file" 2>/dev/null; then
    rm -f "$tree_output_file"
    return 1
  fi

  grep -E '^[|\s]*[+-]\-' "$tree_output_file" | \
    sed -E 's/^[| \t]*((\+-)|(\\-)) //' | \
    awk -F ':' '{print $1 ":" $2}' | \
    sort -u
  rm -f "$tree_output_file"
}

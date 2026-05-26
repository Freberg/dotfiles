_fzf_get_gradle_test_classes() {
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

_fzf_complete_gradle() {
  _fzf_normalize_completion_context "$@"

  case "$__CMD" in
    "./gradlew"|"gradlew"|"gradle") ;;
    *) return ;;
  esac

  if [ "$__PREV_WORD" = "test" ]; then
    _fzf_complete "--prompt=\"Select Test Class (for --tests) > \"" "$@" < <(
      _fzf_get_gradle_test_classes | sed 's/^/--tests /'
    )
    return 0
  fi

  if [ "$__CMD" = "$__PREV_WORD" ]; then
    _fzf_complete "--prompt=\"Select Gradle Task or Module > \"" "$@" < <(
      _fzf_get_gradle_modules_and_tasks
    )
    return 0
  fi
}

_fzf_get_gradle_modules_and_tasks() {
  echo "clean build"
  echo "clean build -x test"
  echo "test"
  echo "dependencies"

  if [ -f "./gradlew" ]; then
    ./gradlew projects -q 2>/dev/null | \
      grep -E '^Project ' | \
      awk '{print $2}' | \
      sed "s/'//g; s/$/:/" | \
      sort -u
  fi
}

_fzf_get_gradle_test_classes() {
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


_fzf_complete_gradle() {
  local ARGS words command
  ARGS="$@"
  words=(${(s: :)ARGS})

  if [[ ${words[1]} != "./gradlew" && ${words[1]} !=  "gradlew" && ${words[1]} != "gradle" ]]; then
    return
  fi


  if [[ ${words[-1]} == "test" ]]; then
    _fzf_complete "--prompt=\"Select Test Class (for --tests) > \"" "$@" < <(
      _fzf_get_gradle_test_classes | sed 's/^/--tests /'
    )
    return
  fi

  if [[ ${#words} -le 2 ]]; then
    _fzf_complete "--prompt=\"Select Gradle Task or Module > \"" "$@" < <(
      _fzf_get_gradle_modules_and_tasks
    )
    return
  fi

  return $COMP_SKIP_DEFAULT
}

_fzf_get_gradle_modules_and_tasks() {
  local common_tasks all_projects

  common_tasks=(
    "clean build"
    "clean build -x test"
    "test"
    "dependencies"
  )

  all_projects=$(
    ./gradlew projects -q 2>/dev/null | 
      grep -E '^Project [^\s]+' | 
      awk '{print $2}' | 
      sed 's/$/:/'
    )

    (
      echo "${(j:\n:)common_tasks}"
      echo "${(j:\n:)all_projects}"
      ) | sort -u
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

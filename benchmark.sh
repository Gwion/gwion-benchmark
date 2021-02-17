#!/bin/bash

language=("gwion" "wren" "lua" "python" "chuck" "ruby" "horse64")
extension=("gw" "wren" "lua" "py" "ck" "rb" "h64")
test_dir="src"
result_dir="results"
plot_script="bench.plot"
: "${repeats:=5}"

# Extract language versions:
lang_versions=""
is_first_lang="yes"
for i in $(seq 0 ${#language[@]})
do
  version="unknown"
  if [ -f "$test_dir/$1.version.txt" ]; then
    version=`cat "$test_dir/$1.version.txt"`
  fi
  if [ "x$is_first_lang" = xyes ]; then
    is_first_lang="no"
  else
    lang_versions="$lang_versions, "
  fi
  lang_versions="$lang_versions$1 $version"
done

run_perf() {
  perf stat -r"$repeats" "$1" "$test_dir/$3.$2" 2>&1 | grep "time elapsed" |
    sed 's/ *\([0-9]*\),\([0-9]*\) .* seconds time elapsed *( +- *\([0-9]*\),\([0-9]*\)% )/\1.\2 \3.\4/'
}

get_list() {
  for file in $test_dir/*.gw
  do basename "$file" .gw
  done
}

get_test() {
  for i in $(seq 0 ${#language[@]})
  do
    if [ -f "$test_dir/$1.${extension[$i]}" ]
    then echo "${language[$i]} $(run_perf "${language[$i]}" "${extension[$i]}" "$1")"
    fi
  done > "$result_dir/$1.dat"
}

plot() {
  gnuplot -e "$1" -e "lang_versions='$lang_versions'" "$plot_script"
}

run_test() {
  echo "running $1 tests"
  get_test "$1"
  plot "bench='$1'"
}

for bench in $(get_list)
do run_test "$bench"
done

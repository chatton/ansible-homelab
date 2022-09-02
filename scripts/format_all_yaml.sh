#!/bin/bash

function format_dir(){
  dir="${1}"
  yaml_files="$(find ${dir} -type f -name "*.yml")"
  for f in $yaml_files
  do
    yamlfmt $f -w
  done
}

format_dir roles
format_dir playbooks
format_dir host_vars
format_dir group_vars
format_dir .github/workflows

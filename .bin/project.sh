#!/usr/bin/env bash
#credit: https://betterdev.blog/minimal-safe-bash-script-template/

#settings safe error exiting 
set -Eeuo pipefail

#trap command to interupt signals, allows for cleanup
trap cleanup SIGINT SIGTERM ERR EXIT

#retrieves the directory of script
script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)


usage() {
  cat << EOF # remove the space between << and EOF, this is due to web plugin issue
Usage: $(basename "${BASH_SOURCE[0]}") [-h] [-v] [-option] -n name

This is a Project / File template creation tool
Example Usage: 
'project -f -H -n html-template-name'    produces a HTML file named 'html-template-name' 
'project -p -j -n java-project'    produces a java project structure with the projects name called 'java-project'


Available options:

-h, --help      	Print this help and exit
-v, --verbose   	Print script debug info

-n, --name		The name of the project / file 
-f --file		This specifies the program to output a file 
-p --project		This specifies the program to output a project

-H, --html
-r, --reactjs
-p, --p5js
-P, --processing
-c, --c
-b, --bash
-e, --expressjs
-j, --java
-cs, --csharp
-f, --flask
-c++, --c++

EOF
exit
}

cleanup() {
  trap - SIGINT SIGTERM ERR EXIT
  # script cleanup here
}

msg() {
  echo >&2 -e "${1-}"
}

die() {
  local msg=$1
  local code=${2-1} # default exit status 1
  msg "$msg"
  exit "$code"
}


html() {
	echo html
}

css() {
	echo css
}

js() {
	echo js
}

reactjs() {
	echo reactjs
}

flask() {
	echo flask
}

expressjs() {
	echo expressjs
}

java() {
	echo java
}

csharp() {
	echo csharp
}

nodejs() {
	echo nodejs
}

p5js() {
	echo p5js
}

processing() {
	echo processing
}

c() {
	echo c
}

cpp() {
	echo cpp
}

bash() {
	echo bash
}

name() {
	echo name
}

file() {
	echo file
}

project() {
	echo project
}

parse_params() {
  # default values of variables set from params
  flag=0
  param=''

  while :; do
    case "${1-}" in
    -h | --help) usage ;;
    -v | --verbose) ;;
    -n | --name) name ;;
    -f |-file) file ;;
    -p |-project) project ;;
    -H | --html) html ;;
    -r | --reactjs) reactjs ;;
    -p | --p5js) p5js ;;
    -P | --processing) processing ;;
    -c | -c) c ;;
    -b | --bash) bash ;;
    -e | --expressjs) express ;;
    -j | --java) java ;;
    -cs | --csharp) csharp ;;
    -f | --flask) flask ;;
    -cp | --cpp) cpp 

      param="${2-}"
      shift
      ;;
    -?*) die "Unknown option: $1" ;;
    *) break ;;
    esac
    shift
  done

  args=("$@")

  # check required params and arguments
  [[ -z "${param-}" ]] && die "Missing required parameter: param"
  [[ ${#args[@]} -eq 0 ]] && die "Missing script arguments"

  return 0
}

parse_params "$@"
msg "Read parameters:"
msg "- html: ${flag}"
msg "- css: ${flag}"
msg "- js: ${flag}"
msg "- reactjs: ${flag}"
msg "- flask: ${flag}"
msg "- expressjs: ${flag}"
msg "- java: ${flag}"
msg "- c#: ${flag}"
    msg "- csharp: ${flag}"
msg "- nodejs: ${flag}"
msg "- p5js: ${flag}"
msg "- processing: ${flag}"
msg "- c: ${flag}"
msg "- c++: ${flag}"
msg "- bash: ${flag}"
msg "- name: ${flag}"
msg "- file: ${flag}"
msg "- project: ${flag}"
msg "- arguments: ${args[*]-}"

# script logic here
# 
# Web Dev:
#
# HTML
# CSS
# JS
#
# Reactjs
# Flask
# Expressjs
#
# High Level:
#
# Java
# Python3
# C#?
# Nodejs
# p5js
# processing 
#
#
# Low Level:
#
# C
# C++
#
# Scripting:
#
# Bash
#
#

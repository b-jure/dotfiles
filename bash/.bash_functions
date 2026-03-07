#!/usr/bin/bash

progName() {
  echo "$(basename "${BASH_SOURCE[-1]}")"
}

callerName() {
  local name="${FUNCNAME[2]}"
  [ -z "${name}" ] && name="${FUNCNAME[1]}"
  [ "${name}" = "main" ] && name="$(progName)"
  echo "${name}"
}

# $1 - output string (can be empty)
echoExitFail_() {
  echo "${1}" >&2
  exit 1
}

# $1 - argument description
# $2 - required function argument
checkFuncArg_() {
  if [ -z "${2}" ]; then
    echoExitFail_ "internal error (missing argument description), " \
      "'$(callerName)' did invalid call to '${FUNCNAME[0]}'"
  elif [ -z "${1}" ]; then
    echoExitFail_ "${FUNCNAME[0]}: invalid call to '$(callerName)', missing ${2}"
  fi
}

# $1 - error message
progErr() {
  checkFuncArg_ "${1}" "error message"
  echoExitFail_ "$(progName): ${1}"
}

# $1 - info message
progInfo() {
  checkFuncArg_ "${1}" "info message"
  echo "$(progName): ${1}"
}

# $1 - default argument
# $2 - provided argument
optArg() {
  checkFuncArg_ "${1}" "default argument"
  if [ -z "${2}" ]; then
    echo "${1}"
  else
    echo "${2}"
  fi
}

# $1 - script/function name
# $2 - argument description (optional)
missingArgName_() {
  local argdesc=$(optArg "argument" "${2}")
  checkFuncArg_ "${1}" "script/function name"
  echoExitFail_ "${1}: missing ${argdesc} ('${1} -h' for usage)"
}

# $1 - required script/function argument
# $2 - argument description (optional)
checkArg() {
  [ -z "${1}" ] && missingArgName_ "$(progName)" "${2}"
}

# $1 - integer
# $2 - integer description (optional)
checkInteger() {
  checkFuncArg_ "${1}" "integer argument"
  local re='^[0-9]+$'
  local argdesc="$(optArg "argument" "${2}")"
  [[ "${1}" =~ ${re} ]] || progErr "${argdesc} not an integer '${1}'"
}

# $1 - integer argument
# $2 - integer argument description (optional)
checkArgInteger() {
  checkArg "${1}" "${2}"
  checkInteger "${1}" "${2}"
}

# $1 - option
# $2 - options
# $3 - values
checkOption() {
  checkFuncArg_ "${1}" "option"
  checkFuncArg_ "${2}" "options"
  checkFuncArg_ "${3}" "values"
  local option="${1}"
  local options_str="${2}"
  local values_str="${3}"
  IFS=';' read -r -a options <<<"${options_str}"
  IFS=';' read -r -a values <<<"${values_str}"
  [ "${#options[@]}" -ne "${#values[@]}" ] && progErr "options and values count mismatch"
  for i in "${!options[@]}"; do
    if [ "${options[$i]}" == "${option}" ]; then
      echo "${values[$i]}"
      return 0
    fi
  done
  progErr "option '${option}' not found"
}

# $1 - option
# $2 - options
# $3 - values
checkArgOption() {
  checkArg "${1}" "option"
  checkArg "${2}" "options"
  checkArg "${3}" "values"
  checkOption "${1}" "${2}" "${3}"
}

# $1 - script/function name
# $2 - filepath
# $3 - argument description (optional)
noFileErr_() {
  checkFuncArg_ "${1}" "script/function name"
  checkFuncArg_ "${2}" "filepath"
  local argdesc="$(optArg "filepath" "${3}")"
  echoExitFail_ "${1}: no such ${argdesc} as '${2}'"
}

# $1 - directory
# $2 - directory description (optional)
checkDir() {
  checkFuncArg_ "${1}" "directory"
  local argdesc="$(optArg "directory" "${2}")"
  [ ! -d "${1}" ] && noFileErr_ "$(progName)" "${1}" "${argdesc}"
}

# $1 - directory argument
# $2 - directory argument description (optional)
checkArgDir() {
  checkArg "${1}" "${2}"
  checkDir "${1}" "${2}"
}

# $1 - name
# $2 - name description (optional)
checkName() {
  checkFuncArg_ "${1}" "name"
  local desc="$(optArg "name" "${2}")"
  [ ! "$(basename "${1}")" = "${1}" ] && progErr "${desc} contains '/' ('${1}')"
}

# $1 - name argument
# $2 - name argument description (optional)
checkArgName() {
  checkArg "${1}" "${2}"
  checkName "${1}" "${2}"
}

# $1 - file
# $2 - filepath description (optional)
checkExist() {
  checkFuncArg_ "${1}" "filepath"
  [ ! -e "${1}" ] && noFileErr_ "$(progName)" "${1}" "${2}"
}

# $1 - script/function name
# $2 - environment variable name
noEnvErr_() {
  checkFuncArg_ "${1}" "script/function name"
  checkFuncArg_ "${2}" "environment variable"
  echoExitFail_ "${1}: missing '${2}' environment variable"
}

# $1 - environment variable
checkEnv() {
  checkFuncArg_ "${1}" "environment variable"
  [ -z "${!1}" ] && noEnvErr_ "$(progName)" "${1}"
}

# $1 - script/function name
# $2 - filepath
# $3 - argument description (optional)
fileExistErr_() {
  checkFuncArg_ "${1}" "script/function name"
  checkFuncArg_ "${2}" "filepath"
  local argdesc=$(optArg "filepath" "${3}")
  echoExitFail_ "${1}: ${argdesc} '${2}' already exists"
}

# $1 - file
# $2 - filepath description (optional)
checkNotExist() {
  checkFuncArg_ "${1}" "filepath"
  [ -e "${1}" ] && fileExistErr_ "$(progName)" "${1}" "${2}"
}

# $1 - filepath
trimSep() {
  checkFuncArg_ "${1}" "filepath"
  if [ "${1: -1}" = "/" ]; then
    echo "${1%?}"
  else
    echo "${1}"
  fi
}

# $1 - script usage string
usageExit() {
  checkFuncArg_ "${1}" "usage"
  echo -e "usage: ${1}"
  exit 0 # ok exit
}

# $1 - usage argument
# $2 - usage string
checkUsage() {
  if [ ! -z "${1}" ]; then
    checkFuncArg_ "${2}" "usage string"
    [ "${1}" = "-h" ] && usageExit "${2}"
  fi
}

# $1 - filepath
getExtension() {
  checkFuncArg_ "${1}" "filepath"
  echo "${1##*.}"
}

isRoot() {
  [ "$EUID" -eq 0 ]
}

checkRoot() {
  isRoot || echoExitFail_ "$(progName): requires root access"
}

getUserHome() {
  if isRoot; then
    echo "$(getent passwd "${SUDO_USER}" | cut -d: -f6)"
  else
    echo "${HOME}"
  fi
}

# $1 - program name
testProg() {
  checkFuncArg_ "${1}" "program name"
  command -v "${1}" >/dev/null 2>&1
}

Status() {
  if [ "${?}" -ne 0 ]; then
    echo "fail"
  else
    echo "ok"
  fi
}

Fail() {
  [ "$(Status)" = "fail" ] && return 0
}

Ok() {
  [ "$(Status)" = "ok" ] && return 0
}

checkStatus() {
  local stat=$(Status)
  checkFuncArg_ "${1}" "error message"
  [ ${stat} = "fail" ] && progErr "${1}"
}

exitIfFail() {
  Fail && exit 1
}

# $1 - program name
checkProg() {
  checkFuncArg_ "${1}" "program name"
  testProg "${1}"
  Fail && progErr "${1} could not be found"
}

# $1 - program name
checkExec() {
  checkProg "${1}"
  "$@" # execute
  Fail && progErr "command failed '$@'"
}

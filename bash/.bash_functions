#!/usr/bin/bash

progName() {
  echo "$(basename "${BASH_SOURCE[-1]}")"
}

callerName() {
  name="${FUNCNAME[2]}"
  [ -z "${name}" ] && name="${FUNCNAME[1]}"
  [ "${name}" = "main" ] && name="$(progName)"
  echo "${name}"
}

# $1 - output string (can be empty)
echoExitFail_() {
  echo "${1}" >&2
  exit 1
}

# $1 - error message
progErr() {
  checkFuncArg_ "error message" "${1}"
  echoExitFail_ "$(progName): ${1}"
}

# $1 - info message
progInfo() {
  checkFuncArg_ "info message" "${1}"
  echo "$(progName): ${1}"
}

# $1 - argument description
# $2 - required function argument
checkFuncArg_() {
  if [ -z "${1}" ]; then
    echoExitFail_ "internal error (missing argument description), " \
      "'$(callerName)' did invalid call to '${FUNCNAME[0]}'"
  elif [ -z "${2}" ]; then
    echoExitFail_ "${FUNCNAME[0]}: invalid call to '$(callerName)', missing ${1}"
  fi
}

# $1 - provided argument
# $2 - default argument
optArg() {
  checkFuncArg_ "default argument" "${2}"
  if [ -z "${1}" ]; then
    echo "${2}"
  else
    echo "${1}"
  fi
}

# $1 - script/function name
# $2 - argument description (optional)
missingArgName_() {
  argdesc=$(optArg "${2}" "argument")
  checkFuncArg_ "script/function name" "${1}"
  echoExitFail_ "${1}: missing ${argdesc} ('${1} -h' for usage)"
}

# $1 - required script/function argument
# $2 - argument description (optional)
checkArg() {
  [ -z "${1}" ] && missingArgName_ "$(progName)" "${2}"
}

# $1 - script/function name
# $2 - filepath
# $3 - argument description (optional)
noFileErr_() {
  checkFuncArg_ "script/function name" "${1}"
  checkFuncArg_ "filepath" "${2}"
  argdesc=$(optArg "${3}" "filepath")
  echoExitFail_ "${1}: no such ${argdesc} as '${2}'"
}

# $1 - directory
# $2 - directory description (optional)
checkDir() {
  checkFuncArg_ "directory" "${1}"
  argdesc="$(optArg "${2}" "directory")"
  [ ! -d "${1}" ] && noFileErr_ "$(progName)" "${1}" "${argdesc}"
}

# $1 - directory
# $2 - directory description (optional)
checkArgDir() {
  checkArg "${1}" "${2}"
  checkDir "${1}" "${2}"
}

# $1 - name
# $2 - name description (optional)
checkName() {
  checkFuncArg_ "name" "${1}"
  desc="$(optArg "${2}" name)"
  [ ! "$(basename "${1}")" = "${1}" ] && progErr "${desc} contains '/' ('${1}')"
}

# $1 - argument
# $2 - argument description (optional)
checkArgName() {
  checkArg "${1}" "${2}"
  checkName "${1}" "${2}"
}

# $1 - file
# $2 - filepath description (optional)
checkExist() {
  checkFuncArg_ "filepath" "${1}"
  [ ! -e "${1}" ] && noFileErr_ "$(progName)" "${1}" "${2}"
}

# $1 - script/function name
# $2 - environment variable name
noEnvErr_() {
  checkFuncArg_ "script/function name" "${1}"
  checkFuncArg_ "environment variable" "${2}"
  echoExitFail_ "${1}: missing '${2}' environment variable"
}

# $1 - environment variable
checkEnv() {
  checkFuncArg_ "environment variable" "${1}"
  [ -z "${!1}" ] && noEnvErr_ "$(progName)" "${1}"
}

# $1 - script/function name
# $2 - filepath
# $3 - argument description (optional)
fileExistErr_() {
  checkFuncArg_ "script/function name" "${1}"
  checkFuncArg_ "filepath" "${2}"
  argdesc=$(optArg "${3}" "filepath")
  echoExitFail_ "${1}: ${argdesc} '${2}' already exists"
}

# $1 - file
# $2 - filepath description (optional)
checkNotExist() {
  checkFuncArg_ "filepath" "${1}"
  [ -e "${1}" ] && fileExistErr_ "$(progName)" "${1}" "${2}"
}

# $1 - filepath
trimSep() {
  checkFuncArg_ "filepath" "${1}"
  if [ "${1: -1}" = "/" ]; then
    echo "${1%?}"
  else
    echo "${1}"
  fi
}

# $1 - script usage string
usageExit() {
  usage="${1}"
  checkFuncArg_ "usage" "${usage}"
  echo -e "usage: ${usage}"
  exit 0 # ok exit
}

# $1 - usage argument
# $2 - usage string
checkUsage() {
  if [ ! -z "${1}" ]; then
    checkFuncArg_ "usage string" "${2}"
    [ "${1}" = "-h" ] && usageExit "${2}"
  fi
}

# $1 - filepath
getExtension() {
  checkFuncArg_ "filepath" "${1}"
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
  checkFuncArg_ "program name" "${1}"
  command -v "${1}" >/dev/null 2>&1
}

execStat() {
  if [ "${?}" -ne 0 ]; then
    echo "fail"
  else
    echo "ok"
  fi
}

checkStat() {
  checkFuncArg_ "error message" "${1}"
  [ "$(execStat)" = "fail" ] && progErr "${1}"
}

# $1 - program name
checkProg() {
  checkFuncArg_ "program name" "${1}"
  testProg "${1}"
  [ "$(execStat)" = "fail" ] && progErr "${1} could not be found"
}

# $1 - program name
checkExec() {
  checkProg "${1}"
  "${@}" # execute
  [ "${?}" -ne 0 ] && progErr "command failed '${@}'"
}

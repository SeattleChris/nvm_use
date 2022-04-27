# shellcheck shell=bash
# vim:ft=zsh ts=2 sw=2 sts=2 et fenc=utf-8
#
# nvm_use
#
# - zsh plugin to call `nvm use` automatically whenever a user enters a
#  directory that has, a a parent directory has, an `.nvmrc` file.
#
# Copyright (c) 2022 Chris Chapman
# Licensed under the MIT License (MIT)
#
# Author : Chris Chapman (https://github.com/seattlechris)
# URL : https://github.com/seattlechris/nvm_use.git
#
# How to set up
#   Make sure this file is sourced by your `zshrc` or appropriate file.
#   It MUST be placed after nvm initialization!

autoload -U add-zsh-hook
nvm_use() {
  typeset -i NVM_ERROR=${NVM_ERROR:-0}
  command -v nvm &>/dev/null && NVM_ERROR=0 || NVM_ERROR=$((NVM_ERROR + $?))
  export NVM_ERROR
  [ "$NVM_ERROR" -eq 1 ] && echo "The 'nvm' command seems missing. "
  [ "$NVM_ERROR" -gt 0 ] && return
  typeset cur="$PWD" NVMRC_PATH="$NVMRC_PATH"

  case "$cur" in
    "") NVMRC_PATH=""; nvm use default; return ;;  # Force assume '.nvmrc' file not at root.
    "$NVMRC_PATH"*) return ;;  # In sub-directory of same NVMRC_PATH. Assume still correctly set.
    *) [ -n "$NVMRC_PATH" ] && NVMRC_PATH="" && nvm use default ;;  # Left NVMRC_PATH sub-directory
  esac
  # check if current or parent directory is a new NVMRC_PATH.
  while [ -n "$cur" ]; do [ -f "${cur}/.nvmrc" ] && break || cur="${cur%/*}"; done
  export NVMRC_PATH="$cur"  # Either "" or a path with an '.nvmrc' file.
  [ -n "$NVMRC_PATH" ] && nvm use | nvm use default
  unset -v cur
  return
}
add-zsh-hook chpwd nvm_use
nvm_use

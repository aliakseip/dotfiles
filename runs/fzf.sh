#!/usr/bin/env zsh 

if command -v fzf >/dev/null 2>&1; then
  INSTALL_STATUS="already"
  return 0
fi

brew install fzf || return 1
INSTALL_STATUS="new"
return 0

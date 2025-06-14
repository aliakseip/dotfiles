#!/usr/bin/env zsh 

if command -v rg >/dev/null 2>&1; then
  INSTALL_STATUS="already"
  return 0
fi

brew install ripgrep || return 1
INSTALL_STATUS="new"
return 0



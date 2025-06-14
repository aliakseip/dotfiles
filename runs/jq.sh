#!/usr/bin/env zsh 

if command -v jq >/dev/null 2>&1; then
  INSTALL_STATUS="already"
  return 0
fi

brew install jq || return 1
INSTALL_STATUS="new"
return 0


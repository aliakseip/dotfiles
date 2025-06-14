#!/usr/bin/env zsh 

if [[ -d "$HOME/.oh-my-zsh" ]]; then
  INSTALL_STATUS="already"
  return 0
fi

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" || return 1
INSTALL_STATUS="new"
return 0


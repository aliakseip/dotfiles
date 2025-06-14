#!/usr/bin/env zsh

TOOLS=("ohmyz" "fd" "jq" "yq" "ripgrep" "tmux" "ghostty" "fzf" "git" "neovim")
# TOOLS=("ohmyz")

for tool in $TOOLS; do
  echo "[....] Installing $tool"
  if source ./runs/${tool}.sh; then
    if [[ $INSTALL_STATUS == "already" ]]; then
      echo "[ OK ] $tool already installed"
    else
      echo "[ OK ] $tool installed"
    fi
  else
    echo "[FAIL] $tool installation failed"
  fi
done

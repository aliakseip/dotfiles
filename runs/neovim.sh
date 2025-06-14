#!/usr/bin/env zsh

mkdir -p $HOME/personal
cd $HOME/personal

if [[ -d "$HOME/personal/neovim" ]] then;
    cd neovim && git pull origin
    INSTALL_STATUS="already"
else
    git clone https://github.com/neovim/neovim && cd neovim
    INSTALL_STATUS="new"
fi

make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install || return 1
return 0


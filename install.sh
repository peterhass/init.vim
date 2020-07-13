#!/bin/bash -e

if command -v neovim > /dev/null 2>&1
then
  echo Neovim already installed
else
  echo Installing neovim ...
  brew install neovim
fi


if command -v vimr> /dev/null 2>&1
then
  echo Vimr already installed
else
  echo Installing vimr ...
  brew cask install vimr 
fi



# deoplete configuration
pip3 install --user pynvim || true
pip2 install --user pynvim || true

# setup vim-plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# clone config
mkdir -p ~/.config/nvim/
if [ -d ~/.config/nvim/.git ]
then
  git -C ~/.config/nvim/ pull
else
  git clone https://github.com/peterhass/init.vim.git ~/.config/nvim/
fi

# update
nvim +UpdateRemotePlugins +PlugInstall +q

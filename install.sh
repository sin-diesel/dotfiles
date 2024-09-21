#!/usr/bin/bash

set -e
set -x

# gogh installation
echo "Setting up terminal theme with gogh..."
if [ -d $HOME/gogh ]; then
  echo "Found existing gogh installation at "$HOME"/gogh. Skipping repo clone..."
else
  git clone https://github.com/Gogh-Co/Gogh.git $HOME/gogh
fi

# necessary in the Gnome terminal on ubuntu
export TERMINAL=gnome-terminal

$HOME/gogh/installs/belafonte-day.sh

# fish installation
echo " Setting up fish shell..."
sudo apt install fish
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish || true

fish -c "omf theme bobthefish"
cp -r fish $HOME/.config/fish/

# set up vim
echo "Setting up vim..."
if [ -d $HOME/.vim/bundle/Vundle.vim ]; then
  echo "Found existing Vundle installation at $HOME/.vim/bundle/Vundle.vim. Skipping Vundle install..."
else
  git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
fi

cp vim/.vimrc $HOME/.vimrc
vim +PluginInstall +qall

# cleanup
rm -rf gogh


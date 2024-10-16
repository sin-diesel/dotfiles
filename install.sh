#!/usr/bin/bash

set -e
set -x

# detect distribution type
distr=$(lsb_release -a | grep Description | sed -nr "s/Description:\s(.+)/\1/p") 
echo "Launching script on: $distr"

# gogh installation
echo "Setting up terminal theme with gogh..."
if [ -d $HOME/gogh ]; then
  echo "Found existing gogh installation at "$HOME"/gogh. Skipping repo clone..."
else
  git clone https://github.com/Gogh-Co/Gogh.git $HOME/gogh
fi

# necessary in the Gnome terminal on ubuntu
if [[ $distr =~ "Ubuntu" ]]; then
  export TERMINAL=gnome-terminal
fi

$HOME/gogh/installs/belafonte-day.sh
$HOME/gogh/installs/aco.sh

# fish installation. Only Ubuntu is supported for now.
echo " Setting up fish shell..."
if [[ $distr =~ "Ubuntu" ]]; then
  sudo apt install fish
  curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish || true
  fish -c "omf theme bobthefish"
  cp -r fish $HOME/.config/fish/
fi

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


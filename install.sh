#!/usr/bin/bash

set -e
set -x

cd $HOME

# gogh installation
echo "Setting up terminal theme with gogh..."
if [ -d "gogh" ]; then
  echo "Found existing gogh installation at "$HOME"/gogh. Skipping repo clone..."
else
  git clone https://github.com/Gogh-Co/Gogh.git gogh
fi

# necessary in the Gnome terminal on ubuntu
export TERMINAL=gnome-terminal

./gogh/installs/belafonte-day.sh

# fish installation
echo " Setting up fish shell..."
sudo apt install fish
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install > install
fish install --offline=omf.tar.gz

omf theme bobthefish

# cleanup
rm -rf gogh


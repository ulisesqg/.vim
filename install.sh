#!/bin/sh
# vimrc install script

#printing a color messages
colormsg() { tput setaf $1; echo -e $2; tput sgr0;  }

colormsg 2 "Getting Vundle..."
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

colormsg 2 "Symlinking vimrc..."
ln -s $PWD/.vimrc ~/.vimrc

colormsg 2 "If you are using youcompleteme plugin, you need to install ncurses5 libraries"

colormsg 2 "For Arch based distros:"
colormsg 3 "\t gpg --keyserver pgp.mit.edu --recv-keys F7E48EDB"
colormsg 3 "\t yaourt ncurses5-compat-libs"

colormsg 2 "Fetching Vundles..."
vim +PluginInstall +qall
sh ./bundle/youcompleteme/install.sh

colormsg 2 "Enjoy!"

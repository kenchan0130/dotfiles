#!/bin/bash

FILES=( .zshrc .zshrc.custom .tmux.conf .vimrc .gitignore_global .gemrc .my.cnf .editorconfig )
DIRECTORIES=( tools )

for file in ${FILES[@]}
do
    ln -fs $HOME/dotfiles/$file $HOME/$file
done

for directory in ${DIRECTORIES[@]}
do
    ln -nfs $HOME/dotfiles/$directory/ $HOME
done

# install oh-my-zsh
[ ! -d $HOME/.oh-my-zsh ] && git clone https://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh

# install Neobundle
[ ! -d $HOME/.vim/bundle/neobundle.vim ] && mkdir -p $HOME/.vim/bundle && git clone https://github.com/Shougo/neobundle.vim $HOME/.vim/bundle/neobundle.vim && echo "you should run following command to setup plugins ->  vim -c ':NeoBundleInstall'"

[ ! `grep 'gitignore_global' $HOME/.gitconfig` ] && git config --global core.excludesfile $HOME/.gitignore_global

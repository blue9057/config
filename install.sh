#!/usr/bin/env bash

function setup_vim()
{
	if [ ! -e "$HOME/.vim" ]; then
		echo "Creating .vim dir"
		mkdir "$HOME/.vim"
	else
		echo "$HOME/.vim exists!"
	fi

	if [ -e "$HOME/.vimrc" ]; then
		echo ".vimrc exists, move it to .vimrc.bak"
		mv "$HOME/.vimrc" "$HOME/.vimrc.bak"
	fi
	
	echo 'symlinking .vimrc'
	ln -s "$PWD/vimrc" "$HOME/.vimrc"

	echo 'setting up autoload for vim'
	if [ ! -e "$HOME/.vim/autoload" ]; then
		mkdir "$HOME/.vim/autoload"
	fi
	ln -s "$PWD/vim/autoload/plug.vim" "$HOME/.vim/autoload/plug.vim"
}


case "$1" in
	vim)
	setup_vim
	;;

	*)
		echo "usage: $(basename $0) <command>"
		echo ''
		echo 'Available commands'
		echo '	vim	Setup vim and its packages'
	;;
esac

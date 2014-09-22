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

function setup_bash()
{
  if [ -e "$HOME/.bashrc" ]; then
    echo ".bashrc exists, move it to .bashrc.bak"
    mv "$HOME/.bashrc" "$HOME/.bashrc.bak"
  fi
  echo 'symlinking .bashrc'
  ln -s "$PWD/bashrc" "$HOME/.bashrc"
}


case "$1" in
  vim)
    setup_vim
    ;;

  bash)
    setup_bash
    ;;

  *)
    echo "usage: $(basename $0) <command>"
    echo ''
    echo 'Available commands'
    echo '  vim	Setup vim and its packages'
    echo '  bash  Setup bashrc'
    ;;
esac

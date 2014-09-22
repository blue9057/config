#!/usr/bin/env bash

function move_bak()
{
  if [ -e "$1" ]; then
    echo "move orignal $1 to $1.bak"
    mv "$1" "$1.bak"
  fi
}

function create_symlink()
{
  if [ -e "$2" ]; then
    move_bak $2
  fi
  ln -s $1 $2
}

function setup_vim()
{
	if [ ! -e "$HOME/.vim" ]; then
		echo "Creating .vim dir"
		mkdir "$HOME/.vim"
	else
		echo "$HOME/.vim exists!"
	fi

	echo 'symlinking .vimrc'
  create_symlink "$PWD/vimrc" "$HOME/.vimrc"

	echo 'setting up autoload for vim'
	if [ ! -e "$HOME/.vim/autoload" ]; then
		mkdir "$HOME/.vim/autoload"
	fi
  create_symlink "$PWD/vim/autoload/plug.vim" "$HOME/.vim/autoload/plug.vim"
}

function setup_bash()
{
  echo 'symlinking .bashrc'
  create_symlink "$PWD/bashrc" "$HOME/.bashrc"
}

function setup_rvm()
{
  echo "installing rvm"
  \curl -sSL https://get.rvm.io | bash
  if !(grep source.*rvm "$HOME/.bashrc") then
    echo "Adding source to bashrc"
    echo "source $HOME/.rvm/scripts/rvm" >> $HOME/.bashrc
  fi
}

function setup_git()
{
  echo "setting-up gitconfig"
  create_symlink "$PWD/gitconfig" "$HOME/.gitconfig"
  echo "writing gitignore_global"
  create_symlink "$PWD/gitignore_global" "$HOME/.gitignore_global"
}

case "$1" in
  vim)
    setup_vim
  ;;

  bash)
    setup_bash
  ;;

  rvm)
    setup_rvm
  ;;

  git)
    setup_git
  ;;

  *)
    echo "usage: $(basename $0) <command>"
    echo ''
    echo 'Available commands'
    echo '  vim	Setup vim and its packages'
    echo '  bash  Setup bashrc'
    echo '  rvm Setup RVM'
    echo '  git Setup git'
    ;;
esac

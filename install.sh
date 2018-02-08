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

function check_dir_and_create()
{
	if [ ! -e "$1" ]; then
		echo "Creating $1 dir"
		mkdir "$1"
	else
		echo "$1 exists!"
	fi

}

function setup_vim()
{
	check_dir_and_create "$HOME/.vim"

	echo 'symlinking .vimrc'
  create_symlink "$PWD/vimrc" "$HOME/.vimrc"

	echo 'setting up autoload for vim'
	if [ ! -e "$HOME/.vim/autoload" ]; then
		mkdir "$HOME/.vim/autoload"
	fi
  create_symlink "$PWD/vim/autoload/plug.vim" "$HOME/.vim/autoload/plug.vim"
  vim +PlugInstall +qall
}

function setup_bash()
{
	echo 'setting-up git-prompt'
	check_dir_and_create "$HOME/.misc"
	create_symlink "$PWD/git-prompt" "$HOME/.misc/git-prompt.sh"
  echo 'symlinking .bashrc'
  create_symlink "$PWD/bashrc" "$HOME/.bashrc"
  create_symlink "$PWD/profile" "$HOME/.profile"
}

function setup_rvm()
{
  echo "installing rvm"
  \curl -sSL https://get.rvm.io | bash
  if !(grep source.*rvm "$HOME/.bashrc" 1>/dev/null) then
    echo "Adding source to bashrc"
    echo "source \$HOME/.rvm/scripts/rvm" >> $HOME/.bashrc
  fi
	create_symlink "$PWD/irbrc" "$HOME/.irbrc"
}

function setup_git()
{
  echo "setting-up gitconfig"
  create_symlink "$PWD/gitconfig" "$HOME/.gitconfig"
  echo "writing gitignore_global"
  create_symlink "$PWD/gitignore_global" "$HOME/.gitignore_global"
}

function setup_bin()
{
  echo "setting-up ~/bin"
  create_symlink "$PWD/bin" "$HOME/bin"
}

function setup_ssh()
{
  echo "setting-up ssh keys"
  mkdir "$HOME/.ssh"
  create_symlink "$PWD/ssh/id_rsa.enc" "$HOME/.ssh/id_rsa"
  chmod "400" "$PWD/ssh/id_rsa.enc"
  cat "$PWD/ssh/authorized_keys" >> "$HOME/.ssh/authorized_keys"
}

function setup_tmux()
{
  echo "Setting-up tmux.conf"
  create_symlink "$PWD/tmux.conf" "$HOME/.tmux.conf"
}

function setup_zsh()
{
  curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
  create_symlink "$PWD/zshrc" "$HOME/.zshrc"
  create_symlink "$PWD/zprofile" "$HOME/.zprofile"
	check_dir_and_create "$HOME/.antigen"
  create_symlink "$PWD/antigen.zsh" "$HOME/.antigen/antigen.zsh"
}

function setup_pkgs()
{
  sudo apt-get update;
  sudo apt-get install exuberant-ctags vim tmux curl wget zsh mosh
}

function setup_move()
{
  git clone git@github.com:blue9057/config ~/cc
  rm -rf ~/config
  mv ~/cc ~/config
  chmod 400 ~/.ssh/id_rsa
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

  bin)
    setup_bin
  ;;

  ssh)
    setup_ssh
  ;;

  tmux)
    setup_tmux
  ;;

  pkgs)
    setup_pkgs
  ;;

  zsh)
    setup_zsh
  ;;

  move)
    setup_move
  ;;

  all)
    setup_git
    setup_bin
    setup_ssh
    setup_tmux
    setup_pkgs
    setup_bash
    setup_rvm
    setup_vim
  ;;

  *)
    echo "usage: $(basename $0) <command>"
    echo ''
    echo 'Available commands'
    echo '  vim	  Setup vim and its packages'
    echo '  bash  Setup bashrc'
    echo '  rvm   Setup RVM'
    echo '  git   Setup git'
    echo '  bin   Setup bin'
    echo '  ssh   Setup ssh keys'
    echo '  tmux  Setup tmux.conf'
    echo '  pkgs  Setup packages that I am using'
    echo '  all   Setup all things at once!'
    ;;
esac

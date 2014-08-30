#!/usr/bin/env sh
#
# File:		bootstrap.sh
#
# Purpose:	Bootstrap configuration files by:
#		1. Populating the home directory with symlinks to the actual
#		dotfils.
#
# Author:	Mohamed Sobh <mohamed.alhusieny@gmail.com>
# 
# Created:	2014-08-30
# Modified:	
#


#---- Variables ----------------------------------------------------------------
dir=$PWD			# dotfiles directory
olddir=~/dotfiles_old		# old dotfiles backup directory
# Dotfiles to manage
files="bashrc vimrc vim"
# zshrc oh-my-zsh private scrotwm.conf Xresources"    # list of files/folders to symlink in homedir


#---- Main ---------------------------------------------------------------------
# create dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles in $HOME ..."
mkdir -pv $olddir

# change to the dotfiles directory
echo -n "Changing to the $dir directory ..."
cd $dir

# Move any existing dotfiles in homedir to dotfiles_old directory, then create
# symlinks from the homedir to any files in the ~/dotfiles directory specified
# in $files
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv -v ~/.$file ~/dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done

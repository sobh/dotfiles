#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=always'

# Prompt
PS1='[\u@\h \W]\$ '				# Default
#PS1='\[\e[1;32m\][\u@\h \W]\$\[\e[0m\] '	# Green
# Fancy Prompt
#PS1='\[\e[0;32m\]\u@\h\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]\$\[\e[m\] \[\e[1;37m\]'

# Commands Autocompletion
complete -cf sudo
complete -cf pacman
complete -cf man

# 
dpsvn=http://dangerous-prototypes-open-hardware.googlecode.com/svn/trunk/

# Packer Temporary Directory
TMPDIR=$HOME/packertmp/
export TMPDIR
EDITOR=vim;	export EDITOR;
# My Scripts
PATH=$PATH:$HOME/bin
# Android SDK
PATH=$HOME/android/adt-bundle-linux-x86-20131030/sdk/tools/:$PATH
PATH=$HOME/android/adt-bundle-linux-x86-20131030/sdk/platform-tools/:$PATH
export PATH

#export PATH="/home/sobh/packertmp/packerbuild-1000/microchip-mplabxc16-bin/microchip-mplabxc16-bin/pkg/opt/microchip/xc16/v1.11/bin":$PATH

#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

# Prompt
PS1='[\u@\h \W]\$ '				# Default
#PS1='\[\e[1;32m\][\u@\h \W]\$\[\e[0m\] '	# Green
# Fancy Prompt
#PS1='\[\e[0;32m\]\u@\h\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]\$\[\e[m\] \[\e[1;37m\]'

# 
dpsvn=http://dangerous-prototypes-open-hardware.googlecode.com/svn/trunk/

# Set default applicaitons for non-graphical programs
export EDITOR=vim
export BROWSER=chromium

# Packer Temporary Directory
export TMPDIR=$HOME/packertmp/
# My Scripts
PATH=$PATH:$HOME/bin
# Android SDK
#PATH=$HOME/android/adt-bundle-linux-x86-20131030/sdk/tools/:$PATH
#PATH=$HOME/android/adt-bundle-linux-x86-20131030/sdk/platform-tools/:$PATH
export PATH

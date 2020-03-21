#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#---- Aliases ----------------------------------------------------------------------------------------------------------
alias grep='grep --color=auto'
alias info='info --vi-keys'
alias la='ls -a'
alias ll='ls -l'
alias ls='ls --group-directories-first --color=auto'
alias lsmovies='(ls /media/sdc5/sobh/movies; ls ~/movies;)'
alias spacaur='pacaur --noconfirm --noedit'

# Prompt
PS1='[\u@\h \W]\$ '				# Default
#PS1='\[\e[1;32m\][\u@\h \W]\$\[\e[0m\] '	# Green
# Fancy Prompt
#PS1='\[\e[0;32m\]\u@\h\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]\$\[\e[m\] \[\e[1;37m\]'

#
#dpsvn=http://dangerous-prototypes-open-hardware.googlecode.com/svn/trunk/

# Set default applicaitons for non-graphical programs
export EDITOR=vim
export BROWSER=chromium
export TERMINAL=st

# Packer Temporary Directory
export TMPDIR=$HOME/packertmp/

# My Scripts
PATH=$PATH:$HOME/bin
export PATH

#export QT_QPA_PLATFORMTHEME=qt5ct
export QT_QPA_PLATFORMTHEME=qt5ct

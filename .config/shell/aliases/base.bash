#!/bin/bash
#
# Pupose:	Aliases for basic commands
#

## Modified commands ## {{{
alias diff='colordiff'
alias grep='grep --color=auto'
alias ls='ls --group-directories-first -X --color=auto --human-readable'
alias more='less'
alias spacker='packer --noconfirm --noedit'
# alias mkdir='mkdir -pv'
# alias ping='ping -c 5'
# alias dmesg='dmesg -HL'
# # }}}
# 
# ## ls ## {{{
# alias lr='ls -R'                    # recursive ls
# alias ll='ls -l'
# alias la='ll -A'
# alias lx='ll -BX'                   # sort by extension
# alias lz='ll -rS'                   # sort by size
# alias lt='ll -rt'                   # sort by date
# alias lm='la | more'
# # }}}
# 
# ## Safety features ## {{{
# alias cp='cp -i'
# alias mv='mv -i'
# alias rm='rm -I'                    # 'rm -i' prompts for every file
# # safer alternative w/ timeout, not stored in history
# alias rm=' timeout 3 rm -Iv --one-file-system'
# alias ln='ln -i'
# alias chown='chown --preserve-root'
# alias chmod='chmod --preserve-root'
# alias chgrp='chgrp --preserve-root'
# alias cls=' echo -ne "\033c"'       # clear screen for real (it does not work in Terminology)
# # }}}
# 
# ## Make Bash error tolerant ## {{{
# alias :q=' exit'
# alias :Q=' exit'
# alias :x=' exit'
# alias cd..='cd ..'
# # }}}

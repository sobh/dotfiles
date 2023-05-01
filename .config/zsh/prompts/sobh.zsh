#!/bin/zsh
# Description:	Set the prompt for zsh.
#

# Prompt Blocks
P_BG='%F{yellow}%(1j.↓%j .)'
P_PWD='%F{magenta}%~'
P_EXIT='%(?..%B%F{red}:('

# On an SSH session, or not?
if [ $SSH_TTY ]; then
	P_HOST='%F{white}@%F{cyan}%m %F{white}: '
	P_SYM='%(!,%F{red}#,%F{blue}%%) >'
else
	P_HOST=''
	P_SYM='%(!,%F{red}#,%F{cyan}%%) >'
fi

# Initialize Prompt
zle-line-init () {
	# Start in vi-insert mode
	zle -K viins
	# Set beam cursor
	echo -ne '\e[5 q'
}
zle -N zle-line-init

#---- Left Prompt --------------------------------------------------------------
# Set Prompt, and cursor based on vimode
zle-keymap-select ()
{
	if [ $KEYMAP = vicmd ]; then	# Normal Mode
		export VIMODE='%F{blue}[N]'
		# Set block cursor
		echo -ne '\e[2 q'
	else				# Insert Mode
		export VIMODE='%F{green}[I]'
		# Set beam cursor
		echo -ne '\e[5 q'
	fi
	export PROMPT="%B$VIMODE ${P_HOST}$P_PWD $P_BG$P_SYM %f%b"
	zle reset-prompt
}
zle -N zle-keymap-select

#---- Right Prompt -------------------------------------------------------------
# Sad face on error exits
RPROMPT="$P_EXIT%f%b)"



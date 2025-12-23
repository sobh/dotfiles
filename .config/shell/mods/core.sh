unalias lsd 2>/dev/null
#-------- base -------------------------
_uname=$(uname -s)
if [ "$_uname" = "Linux" ]; then
	alias \
		grep='grep -E --color=auto' \
		ls='ls --group-directories-first -X --human-readable --color=auto'
else
	alias grep='grep -E'
fi
unset _uname

alias \
	cd..='cd ..'                  \
	cp='cp -rv'                   \
	diff='diff --color=auto'      \
	idate='date --iso'            \
	idt='idate'                   \
	info='info --vi-keys'         \
	ka='killall'                  \
	mkd='mkdir -pv'               \
	mv='mv -v'                    \
	qmv='qmv -f destination-only' \
	rm='trash'                    \
#

#---- cat ----------------------------------------------------------------------
if command -v bat >/dev/null 2>&1; then
	alias \
		c='bat --plain --paging=never'	\
		cn='bat'	\
#
else
	alias \
		c='cat'  \
		cn='cat' \
#
fi

#---- ls -----------------------------------------------------------------------

if command -v eza >/dev/null 2>&1; then
	alias \
		eza='eza --icons --group-directories-first' \
		ls='eza'                                    \
		l='eza --oneline'                           \
		la='eza --all'                              \
		lg='eza --long --header --git'              \
		ll='eza --long --header'                    \
		t='eza --tree --level=3'                    \
		ta='eza --tree'                             \
		td='eza --tree --only-dirs'                 \

#
elif command -v lsd >/dev/null 2>&1; then
	alias \
		ls='lsd'                                    \
		l='lsd --oneline'                           \
		la='lsd --almost-all'                       \
		lg='lsd --long --header --git'              \
		ll='lsd --long --header'                    \
		t='lsd --tree --depth 3'                    \
		ta='lsd --tree'                             \
		td='lsd --tree --depth 3 --directory-only'  \
#
else	
	alias \
		l='ls -1'  \
		la='ls -a' \
		ll='ls -l' \
#
	alias \
		lt='tree -L3'     \
		ltd='tree -L3 -d' \
#
fi

#---- grep ---------------------------------------------------------------------

if command -v rg >/dev/null 2>&1; then
	alias \
		rgi='rg -i' \
#
else
	alias \
    		rg='grep'     \
		rgi='grep -i' \
#
fi


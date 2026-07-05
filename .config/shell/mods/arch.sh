
# ---- pacman ------------------------------------------------------------------
alias \
	p='pacman' \
	pu='sudo pacman -Syu' \
	pq='pacman -Q' \
	po='pacman -Qo'

alias syay='yay --noconfirm'
poc() { pacman -Qo "$(which $1)"; } # Package Owns Command

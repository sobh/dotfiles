#!/bin/sh
#
# Description:	Definition of ANSI Escape Sequences
#

ESC='\e'
CSI="$ESC["

if [ "$ESCAPE_PREIX" = "true" ]; then
	#---- Style Codes -----------------------------------------
	E_RESET="$ESC[0m"
	E_DOUBLE_UNDERLINE="$ESC[21m"	# Per ECMA-48, but disables bold
	E_BOLD="$ESC[1m"	; E_RESET_BOLD="$ESC[22m"
	E_DIM="$ESC[2m"		; E_RESET_DIM="$ESC[22m"
	E_ITALIC="$ESC[3m"	; E_RESET_ITALIC="$ESC[23m"
	E_UNDERLINE="$ESC[4m"	; E_RESET_UNDERLINE="$ESC[24m"
	E_BLINK="$ESC[5m"	; E_RESET_BLINK="$ESC[25m"
	E_BLINK_RPAID="$ESC[6m"	; E_RESET_BLINK_RAPID="$ESC[26m"
	E_INVERSE="$ESC[7m"	; E_RESET_INVERSE="$ESC[27m"
	E_HIDE="$ESC[8m"	; E_RESET_HIDE="$ESC[28m"
	E_STRIKE="$ESC[9m"	; E_RESET_STRIKE="$ESC[29m"


	#---- Color Codes -----------------------------------------
	# Note: the $E_RESET resets all colors, text effects.
	E_FG_DEFAULT="$ESC[39m" 	; E_BG_DEFAULT="$ESC[49m"

	# Dim Colors
	E_FG_DIM_BLACK="$ESC[30m"	; E_BG_DIM_BLACK="$ESC[40m"
	E_FG_DIM_RED="$ESC[31m"		; E_BG_DIM_RED="$ESC[41m"
	E_FG_DIM_GREEN="$ESC[32m" 	; E_BG_DIM_GREEN="$ESC[42m"
	E_FG_DIM_YELLOW="$ESC[33m" 	; E_BG_DIM_YELLOW="$ESC[43m"
	E_FG_DIM_BLUE="$ESC[34m" 	; E_BG_DIM_BLUE="$ESC[44m"
	E_FG_DIM_MAGENTA="$ESC[35m" 	; E_BG_DIM_MAGENTA="$ESC[45m"
	E_FG_DIM_CYAN="$ESC[36m" 	; E_BG_DIM_CYAN="$ESC[46m"
	E_FG_DIM_WHITE="$ESC[37m" 	; E_BG_DIM_WHITE="$ESC[47m"

	# Bright Colors
	E_FG_BLACK="$ESC[90m"		; E_BG_BLACK="$ESC[100m"
	E_FG_RED="$ESC[91m"		; E_BG_RED="$ESC[101m"
	E_FG_GREEN="$ESC[92m"		; E_BG_GREEN="$ESC[102m"
	E_FG_YELLOW="$ESC[93m" 		; E_BG_YELLOW="$ESC[103m"
	E_FG_BLUE="$ESC[94m" 		; E_BG_BLUE="$ESC[104m"
	E_FG_MAGENTA="$ESC[95m" 	; E_BG_MAGENTA="$ESC[105m"
	E_FG_CYAN="$ESC[96m"		; E_BG_CYAN="$ESC[106m"
	E_FG_WHITE="$ESC[97m" 		; E_BG_WHITE="$ESC[107m"
else
	#---- Style Codes ----------------------------------------
	RESET="$ESC[0m"
	DOUBLUNDERLINE="$ESC[21m"	# Per ECMA-48, but disables bold
	BOLD="$ESC[1m"			; RESET_BOLD="$ESC[22m"
	DIM="$ESC[2m"			; RESET_DIM="$ESC[22m"
	ITALIC="$ESC[3m"		; RESET_ITALIC="$ESC[23m"
	UNDERLINE="$ESC[4m"		; RESET_UNDERLINE="$ESC[24m"
	BLINK="$ESC[5m"			; RESET_BLINK="$ESC[25m"
	BLINK_RPAID="$ESC[6m"		; RESET_BLINK_RAPID="$ESC[26m"
	INVERSE="$ESC[7m"		; RESET_INVERSE="$ESC[27m"
	HIDE="$ESC[8m"			; RESET_HIDE="$ESC[28m"
	STRIKE="$ESC[9m"		; RESET_STRIKE="$ESC[29m"


	#---- Color Codes -----------------------------------------
	# Note: the $RESET resets all colors, text effects.
	FG_DEFAULT="$ESC[39m"		; BG_DEFAULT="$ESC[49m"

	# Dim Colors
	FG_DIM_BLACK="$ESC[30m"		; BG_DIM_BLACK="$ESC[40m"
	FG_DIM_RED="$ESC[31m"		; BG_DIM_RED="$ESC[41m"
	FG_DIM_GREEN="$ESC[32m" 	; BG_DIM_GREEN="$ESC[42m"
	FG_DIM_YELLOW="$ESC[33m" 	; BG_DIM_YELLOW="$ESC[43m"
	FG_DIM_BLUE="$ESC[34m"		; BG_DIM_BLUE="$ESC[44m"
	FG_DIM_MAGENTA="$ESC[35m" 	; BG_DIM_MAGENTA="$ESC[45m"
	FG_DIM_CYAN="$ESC[36m"		; BG_DIM_CYAN="$ESC[46m"
	FG_DIM_WHITE="$ESC[37m" 	; BG_DIM_WHITE="$ESC[47m"

	# Bright Colors
	FG_BLACK="$ESC[90m"		; BG_BLACK="$ESC[100m"
	FG_RED="$ESC[91m"		; BG_RED="$ESC[101m"
	FG_GREEN="$ESC[92m"		; BG_GREEN="$ESC[102m"
	FG_YELLOW="$ESC[93m" 		; BG_YELLOW="$ESC[103m"
	FG_BLUE="$ESC[94m" 		; BG_BLUE="$ESC[104m"
	FG_MAGENTA="$ESC[95m"		; BG_MAGENTA="$ESC[105m"
	FG_CYAN="$ESC[96m"		; BG_CYAN="$ESC[106m"
	FG_WHITE="$ESC[97m" 		; BG_WHITE="$ESC[107m"
fi


#---- Test Function ------------------------------------------------------------
_test_escape() {
	if [ "$ESCAPE_PREIX" = "true" ]; then
		printf -- "-------- Styles --------\n"
		printf "This is regular text.\n"
		printf "This is a ${E_BOLD}Bold${E_RESET_BOLD} text.\n"
		printf "This is a ${E_DIM}Dim${E_RESET_DIM} text.\n"
		printf "This is a ${E_ITALIC}Italic${E_RESET_ITALIC} text.\n"
		printf "This is a ${E_UNDERLINE}Underline${E_RESET_UNDERLINE} text.\n"
		printf "This is a ${E_BLINK}Slow Blinking${E_RESET_BLINK} text.\n"
		printf "This is a ${E_BLINK_RAPID}Fast Blinking${E_RESET_BLINK_RAPID} text.\n"
		printf "This is a ${E_INVERSE}Inverted${E_RESET_INVERSE} text.\n"
		printf "This is a ${E_HIDE}Hidden${E_RESET_HIDE} text (hidden).\n"
		printf "This is a ${E_STRIKE}Striked Through${E_RESET_STRIKE} text.\n"

		printf "\n\n"
		printf -- "-------- Foregournd Colors --------\n"
		printf "This is a ${E_FG_DIM_BLACK}Black Text${E_FG_DEFAULT}.\n"
		printf "This is a ${E_FG_DIM_RED}Red Text${E_FG_DEFAULT}.\n"
		printf "This is a ${E_FG_DIM_GREEN}Green Text${E_FG_DEFAULT}.\n"
		printf "This is a ${E_FG_DIM_YELLOW}Yellow Text${E_FG_DEFAULT}.\n"
		printf "This is a ${E_FG_DIM_BLUE}Blue Text${E_FG_DEFAULT}.\n"
		printf "This is a ${E_FG_DIM_MAGENTA}Magenta Text${E_FG_DEFAULT}.\n"
		printf "This is a ${E_FG_DIM_CYAN}Cyan Text${E_FG_DEFAULT}.\n"
		printf "This is a ${E_FG_DIM_WHITE}White Text${E_FG_DEFAULT}.\n"

		printf "This is a ${E_FG_BLACK}Bright Black Text${E_FG_DEFAULT}.\n"
		printf "This is a ${E_FG_RED}Bright Red Text${E_FG_DEFAULT}.\n"
		printf "This is a ${E_FG_GREEN}Bright Green Text${E_FG_DEFAULT}.\n"
		printf "This is a ${E_FG_YELLOW}Bright Yellow Text${E_FG_DEFAULT}.\n"
		printf "This is a ${E_FG_BLUE}Bright Blue Text${E_FG_DEFAULT}.\n"
		printf "This is a ${E_FG_MAGENTA}Bright Magenta Text${E_FG_DEFAULT}.\n"
		printf "This is a ${E_FG_CYAN}Bright Cyan Text${E_FG_DEFAULT}.\n"
		printf "This is a ${E_FG_WHITE}Bright White Text${E_FG_DEFAULT}.\n"

		printf -- "-------- Background Colors --------\n"
		printf "This is a ${E_BG_DIM_BLACK}Black Background${E_BG_DEFAULT}.\n"
		printf "This is a ${E_BG_DIM_RED}Red Background${E_BG_DEFAULT}.\n"
		printf "This is a ${E_BG_DIM_GREEN}Green Background${E_BG_DEFAULT}.\n"
		printf "This is a ${E_BG_DIM_YELLOW}Yellow Background${E_BG_DEFAULT}.\n"
		printf "This is a ${E_BG_DIM_BLUE}Blue Background${E_BG_DEFAULT}.\n"
		printf "This is a ${E_BG_DIM_MAGENTA}Magenta Background${E_BG_DEFAULT}.\n"
		printf "This is a ${E_BG_DIM_CYAN}Cyan Background${E_BG_DEFAULT}.\n"
		printf "This is a ${E_BG_DIM_WHITE}White Background${E_BG_DEFAULT}.\n"

		printf "This is a ${E_BG_BLACK}Bright Black Background${E_BG_DEFAULT}.\n"
		printf "This is a ${E_BG_RED}Bright Red Background${E_BG_DEFAULT}.\n"
		printf "This is a ${E_BG_GREEN}Bright Green Background${E_BG_DEFAULT}.\n"
		printf "This is a ${E_BG_YELLOW}Bright Yellow Background${E_BG_DEFAULT}.\n"
		printf "This is a ${E_BG_BLUE}Bright Blue Background${E_BG_DEFAULT}.\n"
		printf "This is a ${E_BG_MAGENTA}Bright Magenta Background${E_BG_DEFAULT}.\n"
		printf "This is a ${E_BG_CYAN}Bright Cyan Background${E_BG_DEFAULT}.\n"
		printf "This is a ${E_BG_WHITE}Bright White Background${E_BG_DEFAULT}.\n"
	else
		printf -- "-------- Styles --------\n"
		printf "This is regular text.\n"
		printf "This is a ${BOLD}Bold${RESET_BOLD} text.\n"
		printf "This is a ${DIM}Dim${RESET_DIM} text.\n"
		printf "This is a ${ITALIC}Italic${RESET_ITALIC} text.\n"
		printf "This is a ${UNDERLINE}Underline${RESET_UNDERLINE} text.\n"
		printf "This is a ${BLINK}Slow Blinking${RESET_BLINK} text.\n"
		printf "This is a ${BLINK_RAPID}Fast Blinking${RESET_BLINK_RAPID} text.\n"
		printf "This is a ${INVERSE}Inverted${RESET_INVERSE} text.\n"
		printf "This is a ${HIDE}Hidden${RESET_HIDE} text (hidden).\n"
		printf "This is a ${STRIKE}Striked Through${RESET_STRIKE} text.\n"

		printf "\n\n"
		printf -- "-------- Foregournd Colors --------\n"
		printf "This is a ${FG_DIM_BLACK}Black Text${FG_DEFAULT}.\n"
		printf "This is a ${FG_DIM_RED}Red Text${FG_DEFAULT}.\n"
		printf "This is a ${FG_DIM_GREEN}Green Text${FG_DEFAULT}.\n"
		printf "This is a ${FG_DIM_YELLOW}Yellow Text${FG_DEFAULT}.\n"
		printf "This is a ${FG_DIM_BLUE}Blue Text${FG_DEFAULT}.\n"
		printf "This is a ${FG_DIM_MAGENTA}Magenta Text${FG_DEFAULT}.\n"
		printf "This is a ${FG_DIM_CYAN}Cyan Text${FG_DEFAULT}.\n"
		printf "This is a ${FG_DIM_WHITE}White Text${FG_DEFAULT}.\n"

		printf "This is a ${FG_BLACK}Bright Black Text${FG_DEFAULT}.\n"
		printf "This is a ${FG_RED}Bright Red Text${FG_DEFAULT}.\n"
		printf "This is a ${FG_GREEN}Bright Green Text${FG_DEFAULT}.\n"
		printf "This is a ${FG_YELLOW}Bright Yellow Text${FG_DEFAULT}.\n"
		printf "This is a ${FG_BLUE}Bright Blue Text${FG_DEFAULT}.\n"
		printf "This is a ${FG_MAGENTA}Bright Magenta Text${FG_DEFAULT}.\n"
		printf "This is a ${FG_CYAN}Bright Cyan Text${FG_DEFAULT}.\n"
		printf "This is a ${FG_WHITE}Bright White Text${FG_DEFAULT}.\n"

		printf -- "-------- Background Colors --------\n"
		printf "This is a ${BG_DIM_BLACK}Black Background${BG_DEFAULT}.\n"
		printf "This is a ${BG_DIM_RED}Red Background${BG_DEFAULT}.\n"
		printf "This is a ${BG_DIM_GREEN}Green Background${BG_DEFAULT}.\n"
		printf "This is a ${BG_DIM_YELLOW}Yellow Background${BG_DEFAULT}.\n"
		printf "This is a ${BG_DIM_BLUE}Blue Background${BG_DEFAULT}.\n"
		printf "This is a ${BG_DIM_MAGENTA}Magenta Background${BG_DEFAULT}.\n"
		printf "This is a ${BG_DIM_CYAN}Cyan Background${BG_DEFAULT}.\n"
		printf "This is a ${BG_DIM_WHITE}White Background${BG_DEFAULT}.\n"

		printf "This is a ${BG_BLACK}Bright Black Background${BG_DEFAULT}.\n"
		printf "This is a ${BG_RED}Bright Red Background${BG_DEFAULT}.\n"
		printf "This is a ${BG_GREEN}Bright Green Background${BG_DEFAULT}.\n"
		printf "This is a ${BG_YELLOW}Bright Yellow Background${BG_DEFAULT}.\n"
		printf "This is a ${BG_BLUE}Bright Blue Background${BG_DEFAULT}.\n"
		printf "This is a ${BG_MAGENTA}Bright Magenta Background${BG_DEFAULT}.\n"
		printf "This is a ${BG_CYAN}Bright Cyan Background${BG_DEFAULT}.\n"
		printf "This is a ${BG_WHITE}Bright White Background${BG_DEFAULT}.\n"
	fi
}

# If script is executed, and not source, execute the test function.
[ `basename "$0"` = 'escape.sh' ] && _test_escape

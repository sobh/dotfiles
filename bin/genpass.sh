#!/usr/bin/sh
#
# Description:	Generate random passphrase.
#
# TODO:		Remove the `xkcdpass` dependency.
#

#---- Functions ----------------------------------------------------------------
OS=$(uname -s)
# Get random special character
special() {
	# OpenBSD has jot
	if [ $OS = "OpenBSD" ]; then
		char=$(jot -r -c 1 33 47)
	else	# Linux
		SPECIAL='\-!@$%^&*_+=:|~?/.;'
		char=$(cat /dev/urandom | tr -dc "$SPECIAL" | head -c 1)
	fi
	# Must use quotes for glob expansion suppression of '*', and escape '%'
	# for `printf`.
	[ "$char" = '%' ] && char='%%'
	echo "$char"
}
# Get 2 random digits
digits() {
	# OpenBSD has jot
	if [ $OS = "OpenBSD" ]; then
		jot -r 1 10 99
	else
		cat /dev/urandom | tr -dc "0-9" | head -c 2
	fi
}

#---- Main ---------------------------------------------------------------------
WC=3
PAD=$(special)
DELIMITER=$(special)
WORDS=$(xkcdpass --numwords 3 --delimiter "$DELIMITER" --case 'alternating')
PASSPHRASE="$PAD$PAD$(digits)$DELIMITER$WORDS$DELIMITER$(digits)$PAD$PAD$LF"

# Add linefead if output is output is `stdout`
[ -t 1 ] && PASSPHRASE=$PASSPHRASE'\n'

printf -- $PASSPHRASE


#!/bin/sh
#
# Description:	Generate random passphrase.
#
# TODO:         Add command line argument for customizablity.
#

#---- Constants ----------------------------------------------------------------
OS=$(uname -s)
# Defaults
DEFAULT_WORD_COUNT=4
DEFAULT_WORD_LEN=4
DEFAULT_DIGITS_COUNT=2

WORDS_LIST_FILES="
$XDG_DATA_HOME/dict/words
/usr/share/dict/words
/usr/share/dict/american
/usr/share/dict/american-english
/usr/share/dict/british
/usr/share/dict/british-english
"

#---- Functions ----------------------------------------------------------------
# Get random special character
special() {
	DEFAULT_SPECIAL='\-!@$%^&*_+=:|~?/.;'
	SPECIAL=${1:-$DEFAULT_SPECIAL}
	# OpenBSD does not have `/dev/urandom`
	if [ $OS = "OpenBSD" ]; then
		jot -r -c 128 33 47 | tr -dc "$SPECIAL" | fold -w1 | head -n1 |
			tr -d '\n'
	else	# Linux
		cat /dev/urandom | tr -dc "$SPECIAL" | head -c 1 | tr -d '\n'
	fi
}
# Get 2 random digits
digits() {
	count=${1:-2}
	# OpenBSD does not have `/dev/urandom`
	if [ $OS = "OpenBSD" ]; then
		jot -s '' -nr "$count" 10 99
	else    # Linux
		cat /dev/urandom | tr -dc "0-9" | head -c "$count"
	fi
}

word() {
	words_list=${1}
	len=${2:-$DEFAULT_WORD_LEN}
	# Use 'sort -R' instead of 'shuf' for OpenBSD compatibility
	grep -E "^[a-zAZ]{$len,$len}\$" $words_list | sort -R | head -1
}

# Note: In case you pass a delimiter to this function use double quotes, to stop
#       the `shell` from interpreting as a glob.
#       words $WORD_COUNT $WORD_LEN "$DELIM"
words() {
	words_list=${1}                  # Word's List
	count=${2:-$DEFAULT_WORD_COUNT} # Words' Count
	len=${3:-$DEFAULT_WORD_LEN}     # Words' Length
	delimiter=${4-$(special)}       # Delimiter (Could be empty string)
	out="$delimiter"
	for i in $(seq $count); do
		if [ "$upper" ] ; then
			out="$out$(word $words_list $len| tr '[a-z]' '[A-Z]')$delimiter"
			unset upper
		else
			out="$out$(word $words_list $len| tr '[A-Z]' '[a-z]')$delimiter"
			upper='69'
		fi
	done
	echo -n "$out"
}
#---- Main ---------------------------------------------------------------------
# Get words' list file
WORDS_LIST=''
for file in $WORDS_LIST_FILES ; do
	if [ -f "$file" ]; then
		WORDS_LIST="$file"
		break
	fi
done
if [ -z $WORDS_LIST ]; then
	echo "Error: Unable to find a word file out of the following list:"
	for file in $WORDS_LIST_FILES ; do printf "\t- $file\n"; done
	exit -1
fi

PAD=$(special)
# Ensure the delimiter is different from the padding
while true; do
	DELIM=$(special)
	[ "$DELIM" != "$PAD" ] && break
done

PASSPHRASE=''
PASSPHRASE=$PASSPHRASE$PAD$PAD$(digits $DEFAULT_DIGITS_COUNT)
PASSPHRASE=$PASSPHRASE$(words $WORDS_LIST $DEFAULT_WORD_COUNT $DEFAULT_WORD_LEN "$DELIM")
PASSPHRASE=$PASSPHRASE$(digits $DEFAULT_DIGITS_COUNT)$PAD$PAD

# Add linefead if output is output is `stdout`
if [ -t 1 ] ; then
	echo "$PASSPHRASE"
else
	echo -n "$PASSPHRASE"
fi

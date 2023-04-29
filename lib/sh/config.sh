#!/bin/sh
# Description:	Helper for parsing and manibulating configuration files
#

#---- Load Libraries -----------------------------------------------------------
libs=${XDG_LOCAL_HOME:-$HOME/.local}/lib/sh
. $libs/log.sh

#---- Functions ----------------------------------------------------------------
# Gets the value of configuration key where key=value
# Argument: 1. key
#	    2. filename (if no file name was given, read stdin)
cfg_get_key(){
	key=$1
	fname=${2:-/dev/stdin}
	if [ ! -e "$fname" ] ; then
		error "File: '$fname' does not exist." >&2
		return 1
	fi
	sed -En "s/^\s*$key\s*=\s*(.*)/\1/p" $fname
}

# Sets the value of configuration key where key=value
# Argument: 1. key
#	    2. value
#	    3. filename (if no file name was given, read stdin, and output to
#	    stdout)
cfg_set_key(){
	key=$1
	value=$2
	fname=${3}
	sed_opt='-E'
	key_pattern="/^\s*$key\s*=/"

	if [ -z "$fname" ] ; then	# No file read from stdin
		fname=/dev/stdin
	elif [ -e "$fname" ] ; then	# Check if file exists
		sed_opt='-Ei'
	else
		error "File: '$fname' does not exist." >&2
		return 1
	fi

	# If key does not exist in file, append it. Otherwise change it to
	# value.
	if [ -z "$(sed -En "$key_pattern p" "$fname")" ] ; then
		echo "$key=$value" >> $fname
	else
		sed $sed_opt "$key_pattern c $key=$value" $fname
	fi
}

# Gets the value of C Header definition where #define DEF VALUE
# Argument: 1. def
#	    2. filename (if no file name was given, read stdin)
cfg_get_def(){
	def=$1
	fname=${2:-/dev/stdin}
	if [ ! -e "$fname" ] ; then
		error "File: '$fname' does not exist." >&2
		return 1
	fi
	sed -En "s/^#define\s+$def\s+(.*)/\1/p" $fname
}

# Sets the value of C Header definition where #define DEF VALUE
# Argument: 1. def
#	    2. value
#	    3. filename (if no file name was given, read stdin, and output to
#	    stdout)
cfg_set_def(){
	def=$1
	value=$2
	fname=${3}
	sed_opt='-E'
	def_pattern="/^#define\s+$def/"

	if [ -z "$fname" ] ; then	# No file read from stdin
		fname=/dev/stdin
	elif [ -e "$fname" ] ; then	# Check if file exists
		sed_opt='-Ei'
	else
		error "File: '$fname' does not exist." >&2
		return 1
	fi
	# sed $sed_opt "s/^#define\s+$def/#define $def $value/" $fname
	# If definition does not exist in file, then append it. Otherwise change
	# it to value.
	if [ -z "$(sed -En "$def_pattern p" "$fname")" ] ; then
		echo "#define $key $value" >> $fname
	else
		sed $sed_opt "$def_pattern c #define $def $value" $fname
	fi

}

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

	if [ -z "$fname" ] ; then	# No file read from stdin
		fname=/dev/stdin
	elif [ -e "$fname" ] ; then	# Check if file exists
		sed_opt='-Ei'
	else
		error "File: '$fname' does not exist." >&2
		return 1
	fi
	sed $sed_opt "/^\s*$key\s*=/ c $key=$value" $fname

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

	if [ -z "$fname" ] ; then	# No file read from stdin
		fname=/dev/stdin
	elif [ -e "$fname" ] ; then	# Check if file exists
		sed_opt='-Ei'
	else
		error "File: '$fname' does not exist." >&2
		return 1
	fi
	# sed $sed_opt "s/^#define\s+$def/#define $def $value/" $fname
	sed $sed_opt "/^#define\s+$def/ c #define $def $value" $fname

}

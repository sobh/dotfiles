#!/bin/sh
# Description:	Helper for logging
#

time_stamp(){
	date --rfc-3339='ns'
}


_log(){
	log_fmt='%s | %-6s | %s:%d | %s\n'
	# Positional Parameters
	script=$1   ; shift
	line=$1	    ; shift
	msg_type=$1 ; shift
	msg="$*"

	printf "$log_fmt" "$(time_stamp)" "$msg_type" "$script" "$line" "$msg"
}

alias info='_log $0 $LINENO INFO'
alias warning='_log $0 $LINENO WARNING'
alias error='_log $0 $LINENO ERROR'


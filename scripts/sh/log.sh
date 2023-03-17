#!/bin/sh
# Description:	Helper for logging info, warning, errors, etc...
#

. $HOME/scripts/sh/escape.sh

log(){
	time_stamp=$(date --rfc-3339='seconds')
	# Positional Parameters
	script=$1   ; shift
	line=$1	    ; shift
	msg_type=$1 ; shift
	msg="$*"

	# Colorize Output
	if [ -t 2 ]; then
		case $msg_type in
			INFO) log_fmt="%s | $FG_BLUE%-8s$RESET | %s:%d | %s\n" ;;
			WARNING) log_fmt="%s | $FG_YELLOW%-8s$RESET | %s:%d | %s\n" ;;
			ERROR|FAILURE) log_fmt="%s | $FG_RED%-8s$RESET | %s:%d | %s\n" ;;
			SUCCESS) log_fmt="%s | $FG_GREEN%-8s$RESET | %s:%d | %s\n" ;;
			*) log_fmt="%s | $FG_MAGENTA%-8s$RESET | %s:%d | %s\n" ;;
		esac
	else
		log_fmt='%s | %-8s | %s:%d | %s\n'
	fi

	printf "$log_fmt" "$time_stamp" "$msg_type" "$script" "$line" "$msg" 1>&2
}

status()
{
	# Positional Parameters
	msg_type=$1 ; shift
	msg="$*"

	# Colorize Output
	if [ -t 1 ]; then
		case $msg_type in
			info|INFO) log_fmt="$FG_BLUE%-8s$RESET | %s\n" ;;
			warning|WARNING) log_fmt="$FG_YELLOW%-8s$RESET | %s\n" ;;
			error|ERROR|failure|FAILURE) log_fmt="$FG_RED%-8s$RESET | %s\n" ;;
			success|SUCCESS) log_fmt="$FG_GREEN%-8s$RESET | %s\n" ;;
			*) log_fmt="$FG_MAGENTA%-8s$RESET | %s\n" ;;
		esac
	else
		log_fmt='%-8s | %s\n'
	fi

	printf "$log_fmt" "$msg_type" "$msg"
}

alias log_info='log $0 $LINENO INFO'
alias log_warning='log $0 $LINENO WARNING'
alias log_error='log $0 $LINENO ERROR'
alias log_success='log $0 $LINENO SUCCESS'
alias log_failure='log $0 $LINENO FAILURE'

alias info='status INFO'
alias warning='status WARNING'
alias error='status ERROR'
alias success='status SUCCESS'
alias failure='status FAILURE'

_test_log() {
	log_info "This is an info test."
	log_warning "This is an warning test."
	log_error "This is an error test."
	log_success "This is an success test."
	log_failure "This is an failure test."
	log $0 $LINENO CUSTOM "This is an custom message type."

	info "This is an info test."
	warning "This is an warning test."
	error "This is an error test."
	success "This is an success test."
	failure "This is an failure test."
	status CUSTOM "This is an custom message type."
}

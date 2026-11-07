#!/bin/sh
# {{SCRIPT}}
#
# Description:
#   Print a greeting. Replace this example action for the real script.
#
# Usage:
#   {{SCRIPT}} [-h|--help] [--] [name]
#
# Arguments:
#   name       Greeting recipient (default: world)
#
# Options:
#   -h, --help Show this help message
#
# Requirements:
#   POSIX sh, sed, and basename
#
# Exit codes:
#   0  Success or help displayed
#   1  Invalid usage

usage() {
	sed -n '2,/^$/s/^#[[:space:]]\{0,1\}//p' "$0" |
		sed "s/{{SCRIPT}}/$(basename "$0")/g"
}

end_options=false
for arg; do
	shift
	if [ "$end_options" = false ]; then
		case $arg in
		--help) arg=-h ;;
		--) end_options=true ;;
		esac
	fi
	set -- "$@" "$arg"
done
while getopts ':h' opt; do
	case $opt in
	h)
		usage
		exit 0
		;;
	*)
		printf 'Unknown option: -%s\n' "$OPTARG" >&2
		usage >&2
		exit 1
		;;
	esac
done
shift "$((OPTIND - 1))"

if [ "$#" -gt 1 ]; then
	printf 'Expected at most one name\n' >&2
	usage >&2
	exit 1
fi

# Replace only this example action; keep help before any real side effects.
printf 'Hello, %s\n' "${1-world}"

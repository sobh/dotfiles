#!/bin/sh
# {{SCRIPT}}
#
# Description:
#   Block clearly destructive shell commands before an AI harness runs them.
#   Used as a pre-tool hook by Kiro, Claude, Codex, Pi, OMP, and OpenCode.
#   A guardrail against accidents, not a security boundary.
#
# Usage:
#   {{SCRIPT}} [-h|--help] < event.json
#
# Input:
#   A hook event as JSON on stdin. The shell command is read from
#   tool_input.command; other tool_input shapes are scanned as text.
#
# Blocked:
#   Recursive rm of /, ~, $HOME, or the home path, quoted or not, with an
#   optional trailing / or /*. git push with --force, -f (also combined, as
#   in -uf), or a +refspec, including after options such as git -C DIR.
#   --force-with-lease is allowed.
#
# Requirements:
#   POSIX sh, jq, and grep with extended regular expressions.
#
# Exit codes:
#   0  Command allowed
#   1  Invalid input or missing dependency; harnesses treat this as non-blocking
#   2  Command blocked; the reason is written to stderr

usage() {
	sed -n '2,/^$/s/^#[[:space:]]\{0,1\}//p' "$0" |
		sed "s/{{SCRIPT}}/$(basename "$0")/g"
}

case ${1-} in
-h | --help)
	usage
	exit 0
	;;
esac

command -v jq >/dev/null 2>&1 || {
	printf 'guard-shell: jq is required\n' >&2
	exit 1
}

command_text=$(jq -r '
	.tool_input // {} |
	if type == "object" then
		(.command // .cmd // ([.. | strings] | join("\n")))
	else tostring end
') || {
	printf 'guard-shell: invalid hook event JSON\n' >&2
	exit 1
}

# block_if REASON PATTERN: exit 2 when the command matches the pattern.
block_if() {
	if printf '%s\n' "$command_text" | grep -Eq -- "$2"; then
		printf 'Blocked by shared AI guard: %s\n' "$1" >&2
		exit 2
	fi
}

separator='(^|[;&|(][[:space:]]*|[[:space:]])'
quote="[\"']?"

# Home spellings: ~, $HOME, ${HOME}, and the literal absolute home path.
# shellcheck disable=SC2016 # Match the unexpanded text an agent writes.
home='~|\$HOME|\$\{HOME\}'
home_path=${HOME%/}
case $home_path in
/?*)
	escaped_home_path=$(printf '%s\n' "$home_path" |
		sed 's#[][\.*^$+?(){}|]#\\&#g')
	home="$home|$escaped_home_path"
	;;
esac

# Targets may be quoted and may end in / or /*, e.g. "$HOME"/* or '/'.
target="$quote(/|($home)$quote/?)\\*?$quote([[:space:]]|\$|[;&|)])"

block_if 'recursive rm of / or the home directory' \
	"${separator}rm[[:space:]]+(-[a-zA-Z]+[[:space:]]+)*-[a-zA-Z]*[rR][a-zA-Z]*[[:space:]]+(-[a-zA-Z-]+[[:space:]]+)*${target}"
block_if 'recursive rm of / or the home directory' \
	"${separator}rm[[:space:]]+(-[a-zA-Z-]+[[:space:]]+)*--recursive[[:space:]]+(-[a-zA-Z-]+[[:space:]]+)*${target}"

# Allow global options such as -C DIR or -c KEY=VALUE between git and push.
git_option='[[:space:]]+-[^[:space:]]+([[:space:]]+[^-;&|[:space:]][^;&|[:space:]]*)?'
git_push="${separator}git(${git_option})*[[:space:]]+push"

# -f alone or combined with other short flags (-uf), or --force.
block_if 'git force push; use --force-with-lease' \
	"${git_push}([[:space:]]+[^;&|]*)?[[:space:]](-[a-zA-Z]*f[a-zA-Z]*|--force)([[:space:]]|\$)"
# A refspec with a leading +, e.g. +main or "+HEAD:main", also forces.
block_if 'git force push (+refspec); use --force-with-lease' \
	"${git_push}([[:space:]]+[^;&|]*)?[[:space:]]$quote\\+[^[:space:];&|]"

exit 0

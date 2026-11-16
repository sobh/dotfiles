#!/bin/sh
# {{SCRIPT}}
#
# Description:
#   Antigravity PreToolUse adapter for the shared shell guard. Passes the
#   run_command CommandLine to guard-shell.sh and prints Antigravity's JSON
#   decision: "deny" with the guard's reason when it blocks, otherwise "ask",
#   which keeps Antigravity's normal permission rules. An empty reply would
#   deny every command, so a decision is always printed.
#
# Usage:
#   {{SCRIPT}} [-h|--help] < event.json
#
# Input:
#   An Antigravity hook event as JSON on stdin, with the command in
#   toolCall.args.CommandLine.
#
# Requirements:
#   POSIX sh, jq, and guard-shell.sh beside this script.
#
# Exit codes:
#   0  Decision printed to stdout

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

guard=$(CDPATH='' cd -P "$(dirname "$0")" && pwd -P)/guard-shell.sh

# Invalid input or a guard failure falls back to "ask", matching the guard's
# non-blocking behavior in other harnesses.
reason=$(
	jq -c '{tool_input: {command: (.toolCall.args.CommandLine // "")}}' |
		sh "$guard" 2>&1 >/dev/null
)
status=$?

if [ "$status" -eq 2 ]; then
	jq -n --arg reason "$reason" '{decision: "deny", reason: $reason}'
else
	printf '{"decision":"ask"}\n'
fi

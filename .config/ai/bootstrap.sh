#!/bin/sh
# {{SCRIPT}}
#
# Description:
#   Wire all six default AI harness locations to this shared configuration.
#   No installations, authentication changes, or model requests are made.
#
# Usage:
#   {{SCRIPT}} [-n] [-b] [-h|--help]
#
# Options:
#   -n         Dry run; print planned changes without writing files
#   -b         Back up conflicting destinations before replacing them
#   -h, --help Show this help message
#
# Requirements:
#   POSIX sh and utilities, plus jq and readlink. HOME must be absolute.
#   Run from a checkout containing SYSTEM.md, prompts/, skills/, and hooks/.
#
# Exit codes:
#   0  Success or help displayed
#   1  Conflict, missing dependency, invalid input, or filesystem error

# ==== Help and errors ========================================================

usage() {
	sed -n '2,/^$/s/^#[[:space:]]\{0,1\}//p' "$0" |
		sed "s/{{SCRIPT}}/$(basename "$0")/g"
}

fail() {
	printf '%s\n' "$*" >&2
	exit 1
}

# ==== Options ================================================================

# Normalize the supported long option, preserving -- and positional operands.
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

dry_run=false
backup_conflicts=false
while getopts ':nbh' option; do
	case $option in
	n) dry_run=true ;;
	b) backup_conflicts=true ;;
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
[ "$#" -eq 0 ] || {
	usage >&2
	fail 'Unexpected arguments'
}

# ==== Requirements and paths =================================================

set -eu
umask 077
case ${HOME-} in
/*)
	;;
*)
	fail 'HOME must be absolute'
	;;
esac
for dependency in sed basename jq readlink cmp mkdir mv ln cat dirname date rm; do
	command -v "$dependency" >/dev/null 2>&1 ||
		fail "Missing dependency: $dependency"
done
ai_dir=$(CDPATH='' cd -P "$(dirname "$0")" && pwd -P)
[ -f "$ai_dir/SYSTEM.md" ] || fail 'Missing SYSTEM.md beside bootstrap'
[ -d "$ai_dir/prompts" ] || fail 'Missing prompts directory'
[ -d "$ai_dir/skills" ] || fail 'Missing skills directory'
[ -d "$ai_dir/hooks" ] || fail 'Missing hooks directory'
config_dir=${XDG_CONFIG_HOME:-$HOME/.config}
state_dir=${XDG_STATE_HOME:-$HOME/.local/state}
codex_home=${CODEX_HOME:-$HOME/.codex}
for directory in "$config_dir" "$state_dir" "$codex_home"; do
	case $directory in
	/*) ;;
	*) fail "Expected absolute path: $directory" ;;
	esac
done

# Hook commands run through each harness's shell, so keep the path quotable.
guard_script=$ai_dir/hooks/guard-shell.sh
[ -f "$guard_script" ] || fail 'Missing hooks/guard-shell.sh'
case $guard_script in
*"'"*) fail "Hook path cannot contain a single quote: $guard_script" ;;
esac
guard_command="sh '$guard_script'"

# ==== Safe filesystem operations =============================================

backup_root=$state_dir/ai-bootstrap/backups/$(date '+%Y%m%d-%H%M%S')-$$
backup_count=0
temp_dir=
cleanup() {
	if [ -n "$temp_dir" ]; then
		rm -rf "$temp_dir"
	fi
}
trap cleanup 0
trap 'exit 1' HUP INT TERM

# preserve DESTINATION: refuse conflicts, or move them outside discovery.
preserve() {
	if [ -e "$1" ] || [ -L "$1" ]; then
		[ "$backup_conflicts" = true ] || fail "Conflict: $1 (rerun with -b)"
		backup_count=$((backup_count + 1))
		printf 'Backup: %s -> %s/%s\n' "$1" "$backup_root" "$backup_count"
		if [ "$dry_run" = false ]; then
			mkdir -p "$backup_root"
			mv "$1" "$backup_root/$backup_count"
		fi
	fi
}

# link SOURCE DESTINATION: leave matching links alone.
link() {
	if [ -L "$2" ] && [ "$(readlink "$2")" = "$1" ]; then
		printf 'OK: %s\n' "$2"
		return
	fi
	preserve "$2"
	printf 'Link: %s -> %s\n' "$2" "$1"
	if [ "$dry_run" = false ]; then
		mkdir -p "$(dirname "$2")"
		ln -s "$1" "$2"
	fi
}

# Generated files are compared first so reruns need no backups or rewrites.
# install_file SOURCE DESTINATION: preserve conflicts before copying.
install_file() {
	if [ -f "$2" ] && cmp -s "$1" "$2"; then
		printf 'OK: %s\n' "$2"
		return
	fi
	preserve "$2"
	printf 'Write: %s\n' "$2"
	if [ "$dry_run" = false ]; then
		mkdir -p "$(dirname "$2")"
		cat "$1" >"$2"
	fi
}

# install_generated GENERATOR DESTINATION [ARGUMENT...]: run GENERATOR with the
# arguments and install its output. Dry runs compare the output in memory, so
# they report the same OK, backup, and conflict results without temp files.
# Real runs generate before preserve, since generators may read DESTINATION.
install_generated() {
	generator=$1
	generated_destination=$2
	shift 2
	if [ "$dry_run" = false ]; then
		"$generator" "$@" >"$temp_dir/generated"
		install_file "$temp_dir/generated" "$generated_destination"
		return
	fi
	if [ -f "$generated_destination" ] &&
		"$generator" "$@" | cmp -s - "$generated_destination"; then
		printf 'OK: %s\n' "$generated_destination"
		return
	fi
	preserve "$generated_destination"
	printf 'Write: %s\n' "$generated_destination"
}

# ==== Generated content ======================================================

# A guard hook from any checkout location, so a moved hub replaces its old
# entry instead of adding a second one. Shared by the check and the merge.
guard_hook_jq='
  def is_guard_hook:
	(.command? // "") | type == "string" and
	  test("^sh '\''.*/hooks/guard-shell\\.sh'\''$");
'

# guard_hook_json FILE: print FILE (or {}) with any older guard hooks removed
# and the current one appended to hooks.PreToolUse in Claude/Codex style.
# Every other key and hook is kept; only groups the removal emptied are dropped.
guard_hook_json() {
	if [ -f "$1" ]; then
		cat "$1"
	else
		printf '{}\n'
	fi | jq --arg command "$guard_command" "$guard_hook_jq"'
	  .hooks.PreToolUse = ((.hooks.PreToolUse // []) | map(
		if any(.hooks[]?; is_guard_hook) then
		  (.hooks |= map(select(is_guard_hook | not))) |
		  select(.hooks | length > 0)
		else . end
	  )) + [{
		matcher: "Bash",
		hooks: [{type: "command", command: $command}]
	  }]
	'
}

kiro_hook_json() {
	jq -n --arg command "$guard_command" '{
		version: "v1",
		hooks: [{
			name: "ai-guard",
			description: "Block destructive shell commands",
			trigger: "PreToolUse",
			matcher: "shell",
			action: {type: "command", command: $command}
		}]
	}'
}

# codex_adapter_skill NAME PROMPT: print an explicit-only Codex skill adapter.
codex_adapter_skill() {
	cat <<EOF
---
name: $1
description: Manually run the shared $1 prompt.
---

# Shared prompt: $1

Read and follow the shared prompt at:
\`$2\`
Treat supplied arguments as user inputs, not executable shell text.
EOF
}

codex_adapter_policy() {
	printf 'policy:\n  allow_implicit_invocation: false\n'
}

# opencode_json FILE: print FILE (or {}) with shared instruction/skill paths.
# Keep existing instruction order. Put shared skills last so the authored docs
# skill takes precedence over managed skills with the same name.
opencode_json() {
	if [ -f "$1" ]; then
		cat "$1"
	else
		printf '{}\n'
	fi | jq --arg system "$ai_dir/SYSTEM.md" \
		--arg skills "$ai_dir/skills" --argjson hasdocs "$has_docs" '
	  .instructions = ((.instructions // []) |
		if index($system) == null then . + [$system] else . end) |
	  .skills = ((.skills // []) | map(select(
		. != $skills and . != ($skills + "/docs")))) + [$skills] |
	  if $hasdocs
	  then .skills += [($skills + "/docs")] else . end
	'
}

# merge_guard_hook DESTINATION: add the shell guard to hooks.PreToolUse in a
# Claude- or Codex-style JSON file, keeping every other key and hook.
merge_guard_hook() {
	if [ -e "$1" ] || [ -L "$1" ]; then
		[ -f "$1" ] || fail "Not a readable configuration file: $1"
		jq -e 'type == "object" and
		  ((.hooks // {}) | type == "object") and
		  ((.hooks.PreToolUse // []) | type == "array")' "$1" >/dev/null ||
			fail "Hook settings must be an object with array hooks: $1"
		# Leave a file wired with exactly the current guard byte-for-byte
		# unchanged; stale or duplicate guard entries trigger a rewrite.
		if jq -e --arg command "$guard_command" "$guard_hook_jq"'
		  [.hooks.PreToolUse[]?.hooks[]? | select(is_guard_hook) | .command]
		  == [$command]
		  ' "$1" >/dev/null; then
			printf 'OK: %s\n' "$1"
			return
		fi
	fi
	install_generated guard_hook_json "$1" "$1"
}

# ==== Temporary generated files ==============================================

# Stage generated content only for real runs; dry runs never create temp files.
if [ "$dry_run" = false ]; then
	staging_dir=$state_dir/ai-bootstrap/work-$$
	mkdir -p "$(dirname "$staging_dir")"
	mkdir "$staging_dir" || fail 'Cannot create private staging directory'
	temp_dir=$staging_dir
fi

# ==== Claude =================================================================

link "$ai_dir/skills" "$HOME/.claude/skills"
link "$ai_dir/prompts" "$HOME/.claude/commands"
link "$ai_dir/SYSTEM.md" "$HOME/.claude/CLAUDE.md"
merge_guard_hook "$HOME/.claude/settings.json"

# ==== Pi and Oh-My-Pi =========================================================

for agent in .pi/agent .omp/agent; do
	link "$ai_dir/skills" "$HOME/$agent/skills"
	link "$ai_dir/prompts" "$HOME/$agent/prompts"
	link "$ai_dir/SYSTEM.md" "$HOME/$agent/APPEND_SYSTEM.md"
	link "$ai_dir/hooks/pi-guard.ts" "$HOME/$agent/extensions/ai-guard.ts"
done

# ==== Kiro ===================================================================

link "$ai_dir/skills" "$HOME/.kiro/skills"
link "$ai_dir/prompts" "$HOME/.kiro/prompts"
link "$ai_dir/SYSTEM.md" "$HOME/.kiro/steering/system.md"

# Kiro needs a JSON hook file with an absolute command, so it is generated.
install_generated kiro_hook_json "$HOME/.kiro/hooks/ai-guard.json"

# ==== Codex: shared skills and explicit-only prompt adapters ===================

link "$ai_dir/SYSTEM.md" "$codex_home/AGENTS.md"
merge_guard_hook "$codex_home/hooks.json"
for skill in "$ai_dir/skills"/*; do
	[ -f "$skill/SKILL.md" ] || continue
	link "$skill" "$codex_home/skills/${skill##*/}"
done

for prompt in "$ai_dir/prompts"/*.md; do
	[ -f "$prompt" ] || continue
	prompt_name=${prompt##*/}
	prompt_name=${prompt_name%.md}
	case $prompt_name in
	'' | *[!a-z0-9-]*)
		fail "Invalid prompt name: $prompt_name"
		;;
	esac
	# A canonical skill with this name already provides manual invocation.
	[ ! -f "$ai_dir/skills/$prompt_name/SKILL.md" ] || continue
	adapter_dir=$codex_home/skills/$prompt_name
	# Never write generated content through a directory symlink.
	if [ -L "$adapter_dir" ]; then
		preserve "$adapter_dir"
		if [ "$dry_run" = true ]; then
			printf 'Write: %s/SKILL.md\n' "$adapter_dir"
			printf 'Write: %s/agents/openai.yaml\n' "$adapter_dir"
			continue
		fi
	fi
	install_generated codex_adapter_skill "$adapter_dir/SKILL.md" \
		"$prompt_name" "$prompt"
	install_generated codex_adapter_policy "$adapter_dir/agents/openai.yaml"
done

# ==== OpenCode: preserve settings while adding shared resource paths ===========

link "$ai_dir/prompts" "$config_dir/opencode/commands"
link "$ai_dir/hooks/opencode-guard.ts" "$config_dir/opencode/plugins/ai-guard.ts"
opencode_config=$config_dir/opencode/opencode.json
if [ -e "$opencode_config" ] || [ -L "$opencode_config" ]; then
	[ -f "$opencode_config" ] ||
		fail "Not a readable configuration file: $opencode_config"
	jq -e 'type == "object" and
	  ((.instructions // []) | type == "array") and
	  ((.skills // []) | type == "array")' "$opencode_config" >/dev/null ||
		fail 'OpenCode config must use an object with array paths'
fi
has_docs=false
if [ -f "$ai_dir/skills/docs/SKILL.md" ]; then
	has_docs=true
fi
install_generated opencode_json "$opencode_config" "$opencode_config"
printf 'Done. Reload harnesses; install and authenticate them separately.\n'

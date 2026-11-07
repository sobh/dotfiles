---
name: shell
description: >-
  Write, review, or migrate shell scripts and examples: POSIX sh, comment-
  derived help.
---

# 🐚 Shell scripting

## Portability

- Write new scripts and shell examples for POSIX `sh` by default. Executable
  scripts use `#!/bin/sh`. Avoid Bash/Zsh-specific syntax and builtins; prefer
  `printf`, `.`, `[ ]`, `case`, and POSIX parameter expansion.
- Use POSIX utility options unless platform-specific dependencies are explicit.
- Read existing code and project conventions first. Do not silently change the
  interpreter of existing Bash/Zsh scripts or shell startup files. Preserve
  explicitly requested or project-required non-POSIX behavior and document it.
- Indent shell code with tabs, not spaces. Preserve literal data in heredocs
  and quoted strings; do not reindent their contents blindly.

## Human readability

- Optimize for a person reading the script, not the fewest lines or tokens.
  Use descriptive names such as `dry_run`, `backup_conflicts`, and `temp_dir`
  instead of cryptic abbreviations.
- Organize longer scripts into clearly labeled sections: options, validation,
  filesystem helpers, and the main workflow. Group setup by the resource or
  harness being configured so its complete wiring is easy to find.
- Expand multi-step branches and error handling onto separate lines. Avoid
  dense one-liners, nested substitutions, and side effects hidden in tests.
- Use small helpers for genuinely repeated operations. Explain positional
  parameters at their definitions; do not introduce generic frameworks or
  unnecessary indirection merely to shorten the main workflow.
- Comment intent, safety guarantees, and non-obvious precedence rules rather
  than narrating every command. Keep jq filters and generated content legible.
- Preserve behavior during readability refactors. Recheck help, dry runs,
  reruns, conflicts, backups, and relevant boundary cases with safe fixtures.

## Help and usage

The complete pattern is defined here. When implementing an executable script,
read [the local POSIX template](references/help-template.sh). It demonstrates
help extraction, option parsing, and exit behavior without external examples.
Replace its greeting action with the requested behavior; do not copy it as
unrelated script functionality.

- Keep help in a single leading comment block after the shebang, ending at the
  first blank line. Include `{{SCRIPT}}`, Description, Usage, Arguments,
  Options, Requirements, and Exit codes as applicable.
- Use the local template's simple two-stage POSIX `sed` usage function:
  extract the leading comment block, then substitute `{{SCRIPT}}` with the
  script's own basename, exactly as the template does. Do not replace it with
  an awk parser or maintain a second help string. This convention assumes
  ordinary script filenames without sed replacement metacharacters such as
  `&`, backslashes, or `/`.
- Support `-h` and `--help`: print help to stdout and exit 0 before dependency
  checks or side effects. Invalid options/arguments print diagnostics and
  usage to stderr and exit nonzero. Honor `--` as the end of options.
- Prefer the POSIX `getopts` builtin for short-option parsing, with explicit
  handling for supported long options such as `--help`. Honor `--` and report
  missing option arguments and unknown flags consistently.
- Match the pattern with POSIX-compliant implementation. Keep documented
  options, defaults, dependencies, and exit codes consistent with behavior.

## Verification

- Check POSIX scripts with `shellcheck -s sh`, `checkbashisms`, `sh -n`, and
  `shfmt -ln posix -d`. Use shfmt's default tab indentation; apply formatting
  with `shfmt -ln posix -w` and check again. Report unavailable or broken tools.
  For intentionally non-POSIX code, use checks for its interpreter instead.
- Exercise changed behavior with safe inputs, including both help flags,
  invalid usage, and the `--` boundary. Confirm output streams and exit codes.
- Do not run live PR creation, deployment, deletion, or other side effects just
  to test a script. Use isolated fixtures and report any verification limits.
- Syntax checks alone do not prove portability; report untested target shells
  and platforms. Wrap prose at 80 columns without breaking executable syntax.

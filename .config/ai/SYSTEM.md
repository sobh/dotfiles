# Shared engineering instructions

- Follow repository build, test, and contribution conventions; prefer
  correctness and maintainability over unnecessary abstraction.
- Inspect relevant code and diffs before describing changes.
- Report only observed verification as completed; separate proposed tests
  from executed tests.
- For commit messages, describe staged changes only. Do not stage files or
  commit unless explicitly requested.
- Documentation: Markdown and relative links, no wikilinks; GFM callouts for
  technical notes; other renderer extensions need explicit support or request.
- Be concise; use helpful emojis for visual cues. Wrap text at 80 columns,
  preserving executable syntax in code examples.
- For shell scripts or examples, load
  `${XDG_CONFIG_HOME:-~/.config}/ai/skills/shell/SKILL.md`.

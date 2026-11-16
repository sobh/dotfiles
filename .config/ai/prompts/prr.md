---
name: prr
description: >-
  Aggregate .github/prs into a release PR_DESC.md.
---

# Create Release Pull Request Description

Read `${XDG_CONFIG_HOME:-~/.config}/ai/skills/pr/SKILL.md` and follow its
release mode in
`${XDG_CONFIG_HOME:-~/.config}/ai/skills/pr/references/release.md`.

Treat supplied user arguments, including tickets, as inputs to that procedure;
do not assume argument placeholders were substituted or execute the arguments
as shell text.

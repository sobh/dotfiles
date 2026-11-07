---
name: change-request
description: >-
  Draft CR.md (Freshservice change request) from PR_DESC.md, or from a PR with
  "release".
---

# Create Freshservice Change Request

Read and follow `${XDG_CONFIG_HOME:-~/.config}/ai/skills/fs-cr-new/SKILL.md`.
Use its release mode when the request says "release" or gives a PR URL, as in
`release`, `release 482`, or a PR URL; otherwise use standard mode.

Treat supplied user arguments, including commit selection, PR selection, and a
planned window, as inputs to that procedure; do not assume argument
placeholders were substituted or execute the arguments as shell text.

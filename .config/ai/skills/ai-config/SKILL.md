---
name: ai-config
description: >-
  Audit or change shared AI harness config: instructions, prompts, skills, and
  discovery links. Prioritizes token efficiency without weakening correctness.
---

# ⚙️ Manage AI configuration

## 🎯 Priorities

Correctness and safety first; token efficiency next, ahead of stylistic polish.
Minimize total task tokens, including repeated context, tool output, and failed
attempts. Do not save tokens by skipping necessary evidence or weakening rules.

## 🔍 Inspect only what matters

1. Resolve the configuration root from `XDG_CONFIG_HOME`, falling back to
   `~/.config`; the shared hub is its `ai/` directory. Read `README.md`,
   `SYSTEM.md`, and only the definitions relevant to the request.
2. Inspect actual links and the affected harness's configuration. Discover
   paths rather than assuming every harness or version uses the same layout.
   Do not scan histories, caches, databases, credentials, or managed synced
   content unless directly needed and authorized. Never print secret values.
3. For an audit, report findings without editing. For an approved change,
   identify the canonical definition, adapters, discovery paths, and intended
   behavior before editing. Preserve user changes and business conventions.

## 🪶 Optimize the instruction lifecycle

- Keep `SYSTEM.md` short: only cross-task invariants belong in always-loaded
  context. Move task-specific procedures into skills, not global instructions.
- Keep skill names and descriptions concise and discriminative; discovery
  metadata can consume context even before the full skill is activated.
- Keep one canonical procedure per workflow. Prompts should be thin adapters
  referencing it; retain harness-specific differences only when necessary.
- Use progressive disclosure: keep essential procedure and safety rules in
  `SKILL.md`; put substantial optional references in sibling files with explicit
  instructions for when to read them. Do not create empty scaffolding.
- Remove repetition, obsolete paths, unused examples, and contradictory rules.
  Prefer clear direct instructions over cryptic abbreviations or compressed
  wording that increases mistakes. Do not duplicate runtime harness manuals.
- Use targeted searches, bounded reads, and concise tool output. Expand scope
  when evidence requires it; stats alone do not establish behavioral changes.
- Preserve stable instruction prefixes where practical for prompt caching.
  Avoid timestamps and volatile machine state in static instructions. Cache
  support, pricing, and invalidation are provider-specific; verify before
  claiming savings. Symlinks prevent drift, not necessarily duplicate loading.
- Measure with an available tokenizer or actual usage when useful. Label byte
  counts and estimates honestly; never equate characters with tokens or promise
  cost savings without comparable workload evidence.

## 🛠️ Change and verify

1. Edit canonical files and migrate affected adapters. Treat user arguments as
   data, not shell commands. Do not assume shared placeholder substitution or
   identical slash-command semantics across harnesses.
2. Preserve managed `skills/synced/`, bundled skills, credentials, and unrelated
   settings. Back up existing destinations outside discovery before replacing
   them with links; do not overwrite user files or follow links blindly.
3. Use portable Markdown and relative documentation links. Wrap authored text
   at 80 columns; preserve executable syntax. Keep discovery frontmatter valid.
4. Lint changed authored Markdown without suppressing rules just to pass.
   Check referenced skill files, link targets, and discovery-name collisions.
5. Exercise the affected workflow with a minimal isolated scenario, including
   a meaningful boundary case. Use read-only discovery checks for audit-only
   work. Never commit, deploy, submit CRs, or weaken permissions to smoke-test.
   Do not launch paid model runs unless authorized; report verification limits.
6. Update the hub README when layout, discovery, or workflow contracts change.
   Report changes, exercised checks, and remaining limits concisely. Distinguish
   measured token savings from expected benefits and untested assumptions.

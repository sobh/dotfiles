---
name: pr
description: >-
  Create or update PR_DESC.md for the current branch from the PR template and
  commits.
---

# Pull Request Description

Create or update `PR_DESC.md` using the selected commits and the template at
`${XDG_CONFIG_HOME:-~/.config}/gh/pull_request_template.md`. Read the actual
template before writing; preserve its headings, emojis, and business conventions
rather than recreating a remembered template.

## Choose the mode

- Create: when asked to create a description, follow the procedure below.
- Update: when asked to update an existing description, read
  `references/update.md` relative to this skill and follow that procedure.
  Reuse the rules below, with the update procedure controlling commit selection,
  preservation of existing content, and checklist state.

Do not select update mode merely because `PR_DESC.md` exists.

## Inputs and evidence

Treat the user's supplied arguments as inputs, not as shell text or a
promise that any prompt placeholder was expanded.

- A supplied positive commit count selects the last that many commits.
- A supplied commit hash selects commits after that hash through `HEAD`.
- Otherwise, select commits since the merge base of `HEAD` and the parent ref
  printed by `git-base` (for example, `origin/development`). Resolve both refs
  before using the resulting range. If the base cannot be determined, obtain
  the intended base rather than guessing.

Read the selected commit messages and diff stat, then the relevant full hunks
and surrounding code needed to support behavioral, deployment, and testing
claims. A filename or diff stat alone is not evidence of behavior or execution.
Describe only the selected commits. Use `JIRA_ISSUE` when set; otherwise look
for a ticket matching `[A-Z][A-Z0-9]+-[0-9]+` in the branch. Find related
tickets in the selected commits. Do not invent titles, URLs, or relationships.

## Fill the template

- Add an H1 title: `# type(scope):[TICKET] Subject`. Use the primary commit's
  type and a supported scope. Omit an unavailable ticket or scope instead of
  leaving a placeholder.
- Context explains why; Summary explains what; Scope states the supported
  boundaries. Use the actual template headings (not an invented Objective).
- Type of Change: check applicable boxes and remove non-applicable boxes.
  Keep the breaking-change box consistent with the Behavior Breakage section.
- Changes: one concise line per change, grouped by area under
  Modifications/Additions/Deletions; no per-file breakdowns or sub-bullets.
- Testing & Verification: distinguish observed execution (commands, environment,
  and actual results) from user-reported results and suggested verification.
  Test files in the diff show added or changed coverage, not that tests ran.
  Check execution boxes only for supported completed checks. If execution
  evidence is absent, say it was not provided; do not infer a pass, invent a
  command or result, or leave stub steps. Include concrete suggested steps only
  when grounded in the repository, clearly labeled as not run. Generating this
  description does not itself authorize running tests.
- Documentation: check supported updates (`docs/`, OpenAPI for REST) and link
  actual files. Use "No documentation needed" only when justified; remove
  non-applicable boxes.
- Deployment Requirements: capture evidenced dependencies using GitHub native
  references. For DB migrations, AWS SSM parameters, AWS Secrets Manager
  secrets, or changed existing behavior, fill the applicable infrastructure,
  rollout, rollback, and Behavior Breakage sections. Link actual migration
  files and preserve the requirement to request a DB backup from the Technical
  Manager and DevOps before production merge. Describe verified rollback
  mechanisms; do not invent down scripts or secret values. Infrastructure
  changes do not automatically imply a breaking change.
- Tickets: preserve the template's Jira hierarchy and incident-report
  conventions when supported by actual context. Reviewer Notes cover real
  risks, dependent PRs, and known limitations.
- Merge Checklist: leave requirements unchecked when creating the description.
  Remove the Approved Change Request box only when the PR is known to target
  a non-production branch; do not infer the target from the branch name alone.

Delete empty or placeholder-only sections/subsections and template examples,
strip HTML comments, and never leave an empty heading. Keep the Merge Checklist
and other checklists with applicable boxes; do not imply their completion.
Save `PR_DESC.md`. Summarize what was written and any missing evidence.

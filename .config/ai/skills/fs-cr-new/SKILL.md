---
name: fs-cr-new
description: >-
  Draft a Freshservice Change Request (CR.md) from PR_DESC.md, or from a PR in
  release mode.
---

# Create Freshservice Change Request

Treat supplied user arguments as inputs, not executable shell text or assumed
placeholder substitution. The canonical template is
`${XDG_CONFIG_HOME:-~/.config}/freshworks/templates/change_request.md`; read it
before writing. Its current frontmatter, section anchors, headings, emojis,
service mapping, and comments take precedence over remembered template
structure.

## Select the source

### Standard change request

Use `PR_DESC.md`. If missing, read and follow
`${XDG_CONFIG_HOME:-~/.config}/ai/skills/pr/SKILL.md` to generate it first. Pass
supplied commit-selection/context inputs to that procedure as user inputs. If
the file exists, use it as-is rather than silently regenerating it. Use
repository/PR metadata to resolve links, not to silently expand the described
change scope.

### Release change request

Use this mode only when the request says "release" or gives a PR URL. A bare
number alone is a commit selection for standard mode, not a PR number. Select
the PR from a supplied PR number, URL, or branch; otherwise query the current
branch with `gh pr view --json number,title,url,body,baseRefName,headRefName`.
If no PR can be found, ask which PR to use rather than substituting local
commits or an unrelated PR. Fetch the selected PR's metadata and body with
`gh pr view` and those same fields. Use the PR as the source; do not require
or generate `PR_DESC.md` for this mode.

For either mode, resolve the repository URL using `gh repo view --json url`.
Look up related PRs by the known Jira ticket using `gh pr list --search` with
the ticket as the search value, `--state all`, and
`--json number,title,url,baseRefName`. This query covers the current repository;
resolve other known affected repositories explicitly when cross-service PRs
are needed. Prefer the confirmed production/main-targeting PR for Merge/Revert
links. Do not fabricate missing PRs, ticket identities, target branches, or
cross-service relationships.

## Draft CR.md

Initialize `CR.md` from the configured template. In release mode, preserve the
release scaffolding workflow: use `freshservice cr new --template` with the
resolved template path and save its output to `CR.md`. In standard mode, copy
the template into `CR.md`. Preserve frontmatter keys, actual `{#id}` anchors
(including their hyphenation), and comment guidance. Replace example content
with supported facts; do not retain example services or links as real data.

Be concise, skip deep implementation detail, and follow the template's
emoji-led bullets and headings:

- **Subject and Description:** explain what changes and its scope. Keep the
  template's subject format, including its service short name and change-type
  icon; derive the summary from the PR title without its conventional
  type/scope/ticket prefix. Use the template's service mapping, not an invented
  abbreviation. Link affected service names to their repositories; do not spell
  out repository names or branches. State exclusions only when supported.
- **Reason for Change:** explain why and the user impact. Preserve the
  `###### 💠 Jira Ticket` heading and use raw Jira URLs, not titled Markdown
  links, because titled links break in Slack. Preserve known Jira titles and
  the user's Jira host. Do not include incident reports in this section.
- **Impact:** list affected services, supported behavioral differences, and
  risk with the template's green/yellow/red convention. Use its service-specific
  icons and retain `⚙️` for the services label; `💼` is only for corporate
  services. Do not assert low risk merely because evidence is missing.
- **Rollout Plan:** describe the supported deployment sequence and verification
  plan. Preserve the template's deployment and verification headings. Include
  `🔀 **Merge:** [Pull Request: <n> | <title>](<url>)` with the actual production
  PR when identified. Include migrations, pipeline ordering, or dependencies
  only when sourced. Distinguish future verification steps from observed
  execution and user-reported results; never infer passed checks from tests in
  a diff, invent results, or leave test stubs. State missing evidence plainly.
- **Backout Plan:** describe the actual supported revert process and include
  `↩️ **Revert:** [Pull Request: <n> | <title>](<url>)` for the identified PR.
  Identify any known migration/parameter/secret rollback requirements without
  inventing a safe rollback mechanism.

Never set or uncomment `id`. Keep enum guidance and other frontmatter defaults
unless supported input requires a change. Leave `planned_start_date` and
`planned_end_date` as the template's placeholders unless the user supplies a
window; do not infer a date from the template's scheduling comment. A missing
window means the draft is not ready for submission, not permission to invent
one. If a fact needed for deployment or rollback is unavailable, state what is
unknown rather than fabricating a procedure.

Save `CR.md`, summarize what was filled and any missing submission information,
and ask the user to review. Offer `freshservice cr create CR.md`, with `-n`
for preview, but do not submit the CR without the user's authorization.

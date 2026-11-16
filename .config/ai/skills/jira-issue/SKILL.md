---
name: jira-issue
description: >-
  Create or update a Jira ticket description in JIRA_ISSUE.md from the PRs in
  .github/prs.
---

# Jira Ticket Description

Create or update `JIRA_ISSUE.md` at the Git root from the pull request
descriptions in `.github/prs/`. Templates live in
`${XDG_CONFIG_HOME:-~/.config}/jira/templates/`: `task.md` for tasks,
features, and chores; `bug.md` for bugs and fixes. Read the actual template
before writing.

1. Resolve the ticket and PRs:
   - Ticket: resolve it as the shared instructions define, also matching the
     working directory.
   - Read `.github/prs/<TICKET>_*.md` (or `.github/prs/*.md`). If none exist,
     run `jira-fetch-prs <TICKET>` (or `gh-fetch-prs <TICKET>`).
2. Scaffold or reconcile, always at `<git-root>/JIRA_ISSUE.md`; never search
   outside the Git root:
   - If the file exists, preserve manual context and notes, and enrich it
     with the PR changes.
   - If it is missing, pull the remote baseline with
     `jira-pull-desc -t <TICKET> -w JIRA_ISSUE.md`; if there is none, seed the
     structure from `task.md` or `bug.md` and generate it from the PRs.
3. Format:
   - Line 1 is `# <EMOJI> <Component> | <Summary>`; `jira-update-desc` parses
     it as the ticket summary.
   - Write in present, imperative specification tense: the description states
     requirements before the work, never in the past tense.
   - Tasks and features follow `task.md`: `## 📋 Summary` (one or two
     sentences), `## 🎯 Context` (the problem and current gaps, grouped under
     bold categories), `## ✅ Acceptance Criteria` (categorized, atomic,
     pass/fail items), `## 🛠️ Other Information` (subsections
     `### 🔄 Workflows & Technical Design`,
     `### 🪝 Git Hooks & Developer Tooling`, `### 📚 Documentation`,
     `### 🧪 Testing & Verification`, and `### 🚀 Operational Notes`), and
     `## 🔗 Related Resources` (links to the PRs in `.github/prs/`).
   - Bugs and fixes follow `bug.md`: `## 📋 Summary`, `## 🎯 Context`,
     `## 🧪 Steps to Reproduce`, `## ❌ Actual Behavior`,
     `## ✅ Expected Behavior`, `## ✅ Acceptance Criteria`,
     `## 🛠️ Technical Context & Logs`, and `## 🔗 Related Resources`.
   - Base every statement on the PRs, the existing description, or the
     template; do not invent tickets, links, or behavior.
4. Save `JIRA_ISSUE.md`, summarize the update, and offer
   `jira-update-desc -t <TICKET> JIRA_ISSUE.md`. Run it only when asked; it
   changes the ticket in Jira.

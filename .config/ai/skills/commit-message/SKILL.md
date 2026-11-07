---
name: commit-message
description: >-
  Create a conventional commit message for staged files and save it to
  COMMIT_MSG.md.
---

# Create Commit Message

1. Run `git diff --cached --stat` and read the full staged diff with
   `git diff --cached`. Always read the diff, even when the stat appears clear.
   If there are no staged changes, stop and report that there is nothing to
   summarize; do not create or overwrite `COMMIT_MSG.md`.
2. Ticket: use the `JIRA_ISSUE` env var if set, else match
   `[A-Z][A-Z0-9]+-[0-9]+` in the branch name. If neither, omit it.
   Preserve uppercase Jira identifiers; do not lowercase the ticket.
3. Write a conventional commit to `COMMIT_MSG.md`:
   - `type(scope):[TICKET] Subject`; without a ticket, use
     `type(scope): Subject`. Use lowercase type and scope, and a sentence-case
     summary. Header ≤ 72 chars.
   - Body wrapped at 80 chars, covering what and why based on the staged diff.
4. Do not stage files or create a commit. Only write `COMMIT_MSG.md`.

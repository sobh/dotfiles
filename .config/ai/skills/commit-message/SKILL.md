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
2. Resolve the Jira ticket as the shared instructions define; omit it if
   none is found.
3. Write a conventional commit to `COMMIT_MSG.md`:
   - `type(scope):[TICKET] subject`; without a ticket, use
     `type(scope): subject`. Use lowercase type and scope, and a lowercase
     summary. Header ≤ 72 chars.
   - Body wrapped at 80 chars, covering what and why. Describe only the staged
     changes.
4. Do not stage files or create a commit. Only write `COMMIT_MSG.md`.

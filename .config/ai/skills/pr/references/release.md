# Release Pull Request Description

Aggregate the pull request descriptions in `.github/prs/` into one release
description in `PR_DESC.md` at the Git root.

1. Read the canonical skill entry at `../SKILL.md` relative to this reference
   if it has not already been read. Reuse its evidence, ticket, pruning, and
   formatting rules; this procedure replaces only commit selection and the
   title. Use the repository's `.github/pull_request_template.md` when present;
   otherwise use the template named in `../SKILL.md`.
2. Tickets: resolve them as the shared instructions define, also matching the
   working directory and PR filenames. A release can cover several
   space-separated tickets.
3. Read `.github/prs/<TICKET>_*.md` for each ticket, or `.github/prs/*.md`
   when no ticket narrows the set. If the directory is missing or empty, run
   `jira-fetch-prs <TICKET>` (or `gh-fetch-prs <TICKET>`). Include `MERGED`
   and `OPEN` PRs; ignore `DECLINED` and `CLOSED` ones. These descriptions are
   the evidence; do not add claims they do not support.
4. Title: `# release:[TICKET] subject`, or `# release:[TICKET1 TICKET2]
   subject` for several tickets, with a lowercase subject.
5. Merge the constituent PRs into the template:
   - Tickets: deduplicate Jira tickets (`[KEY | Title](url)`), parent epics,
     stories, and incident reports.
   - Context, Summary, and Scope: synthesize the release's motivation, goals,
     and the union of affected systems, workflows, and modules.
   - Type of Change and Documentation: the union across PRs, keeping the
     breaking-change box consistent with Behavior Breakage.
   - API Changes: merge new, modified, and deprecated endpoints into one
     table; remove the table when there are none.
   - Changes: group by functional area, one concise line per change, with
     overlapping entries deduplicated.
   - Testing & Verification: consolidate each PR's reported execution and
     suggested checks, keeping observed results distinct from suggestions.
   - Deployment Requirements: the union of `Depends on` and `Unblocks`
     references; one DB migrations table (`#`, `Migration File`, `Type`,
     `Description`), plus SSM parameters and Secrets Manager secrets.
   - Reviewer Notes: cross-cutting risks, rollout ordering, breaking changes,
     and operational caveats across the release.
   - Merge Checklist: leave unchecked; link the Change Request
     (`[KEY | Title](url)`) when known.
6. Save `PR_DESC.md`, summarize the release and any missing evidence, and
   offer `gh-pr-upsert` to create or update the release PR. Do not run it
   unless asked.

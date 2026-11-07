# Update Pull Request Description

Update `PR_DESC.md` for the selected new commits; read the existing description
first. Treat supplied user arguments as inputs, not shell text or assumed
placeholder substitution.

1. Read the canonical skill entry at `../SKILL.md` relative to this reference
   if it has not already been read. Reuse its template, evidence, ticket, and
   formatting rules; do not regenerate the description wholesale.
2. Select the last supplied positive number of commits, or commits after a
   supplied hash through `HEAD`. With no selection, use only the latest commit.
   Read their messages, diff stat, and relevant hunks/context before describing
   behavior. Do not treat filenames as proof of execution.
3. Expand Context, Summary, or Scope if the new commits change them; update
   concise Modifications/Additions/Deletions lines grouped by area, without
   per-file breakdowns. Keep unaffected content and the Merge Checklist's
   existing completion state. Update applicable documentation, dependencies,
   deployment, rollback, and breaking-change details consistently.
4. Keep observed execution, user-reported results, and suggested checks
   distinct. New test code is not evidence of a run. Do not invent passed tests,
   verification steps, or results, and do not silently extend an earlier test
   result to the new commits. State when evidence for the updated scope is
   absent. Do not run tests just to update the description.
5. Save `PR_DESC.md` and briefly summarize the update and missing evidence.

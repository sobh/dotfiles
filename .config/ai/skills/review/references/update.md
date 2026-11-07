# Verify Review Fixes

Read `REVIEW.md`. For each item under Suggestions and Issues (including their
existing heading symbols):

1. Treat the old file:line as a locator hint, not a stable address. Find the
   current file and symbol or behavior, following renames and moved code where
   necessary. A missing old line or file alone does not prove a fix.
2. Read the relevant current implementation and surrounding control flow.
   Inspect affected callers, contracts, and tests when needed to evaluate the
   original finding; use focused diffs or history to understand the change.
   Avoid unrelated re-review, but do not restrict evidence to a stale line.
3. Decide whether the original failure or concern is actually addressed,
   including equivalent paths introduced by a move or refactor. Resolve only
   findings supported by the inspected context. If evidence is insufficient,
   leave the item open and state what remains unverified.
4. Distinguish code inspection from executed verification. Test code alone
   proves neither execution nor a passing result. Record only observed command
   results as executed, label user-reported results as such, and label proposed
   checks as not run. This procedure does not authorize running tests.

Update `REVIEW.md`: mark resolved items with ~~strikethrough~~ + ✅ and a concise
evidence note. Keep unresolved findings open, updating their current locations
and explanation where appropriate. Refresh the Review Summary to reflect
resolved, unresolved, and unverified findings without claiming an unperformed
test run. Save to `REVIEW.md`.

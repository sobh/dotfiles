---
name: review
description: >-
  Review staged files or verify fixes from REVIEW.md; writes REVIEW.md.
---

# Review Code

## Select a mode

- Initial mode: review staged files and create `REVIEW.md`. Use this mode
  unless the user asks to verify fixes or update an existing review.
- Update mode: verify findings from `REVIEW.md`. Read and follow
  [the update procedure](references/update.md) instead of the initial procedure.
  The `review-verify` prompt selects this mode.

## Initial mode

Review ONLY staged files. An existing `REVIEW.md` alone does not select update
mode.

1. `git diff --cached --stat`. If nothing staged, say "No staged files to
   review." and stop.
2. Read each file's hunks (`git diff --cached -- <file>`); skip binaries.
3. Check: correctness, conventions (project steering, `.eslintrc.js`),
   consistency, completeness, security (secrets, injection), performance
   (N+1, needless loops).
4. Write `REVIEW.md` (omit empty sections, be concise):

```markdown
## 📝 Review Summary

(1-2 sentence assessment)

## ✅ Looks Good

- (well done items)

## ⚠️ Suggestions

- **file:line** — description

## ❌ Issues

- **file:line** — description (must fix)
```

---
name: docs
description: >-
  Create or update technical documentation in Markdown with GFM callouts and
  relative links.
---

# 📚 Technical documentation

1. Read existing documentation and relevant project files before writing.
   Follow the user's requested location and repository conventions.
2. Default to ordinary Markdown: headings, lists, fenced code blocks, standard
   blockquotes, and relative links with file extensions. No Obsidian wikilinks.
3. Add document frontmatter only when the repository or publishing target
   requires it. Inspect the actual schema; no metadata schema is universal
   across Astro, Docusaurus, and Zola. This skill's discovery frontmatter is
   separate from generated documents.
4. Use emojis as helpful visual cues, not substitutes for meaningful headings.
5. Use concise prose and practical examples grounded in the project. Label
   suggested commands and illustrative output; never claim they were executed.
6. Prefer GFM callouts for technical notes, tips, warnings, and cautions:
   `> [!NOTE]`, `> [!TIP]`, `> [!IMPORTANT]`, `> [!WARNING]`, `> [!CAUTION]`,
   followed by quoted body lines. These are an explicitly preferred extension,
   not universal Markdown. Keep the body understandable without special
   rendering; follow target-specific constraints when they require a fallback.
   Use Mermaid and other extensions only when supported or requested.
7. Document observed behavior and actual configuration. Do not invent API
   fields, test results, performance claims, prices, or compatibility
   guarantees. Cite primary sources and date volatile information.
8. Check relative link targets and code examples where feasible. Report what
   was exercised and any verification limits. Never execute deployment or
   destructive examples merely to validate documentation.
9. Keep only relevant sections. Do not force a universal template or leave
   placeholders in delivered documentation.
10. Wrap prose at 80 columns. Preserve executable syntax when wrapping code.

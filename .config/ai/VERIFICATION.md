# 🧪 Verification log

Dated checks, measurements, and machine-specific notes for this hub. The
[README](README.md) describes intended behavior; this file records evidence
and its limits. Recheck after harness upgrades. Git history records what
changed; this file records what was observed.

## 📉 Measured size

Measured with a Pi startup probe that stopped before any model request.
Sizes are characters, not tokens; roughly 4 characters per token is an estimate.

| Item | Before | After |
| --- | --- | --- |
| `SYSTEM.md` | 921 | 796 |
| Authored skill metadata in Pi | 2,004 | 1,365 |
| Pi system prompt | 12,509 | 11,945 |
| OMP system prompt | 12,838 | 12,638 |

`SYSTEM.md` loads once in Pi and OMP. The largest remaining block is the
managed `skills/synced/` metadata: about 7,100 of Pi's 11,900 characters. OMP
did not list those skills in its prompt. Limit which harnesses load it if that
cost matters. Savings from caching or pricing were not measured.

> [!NOTE]
> Later figures are file sizes in bytes, not new probes; the table above was
> not re-measured.
>
> - 2026-11-07 path edits: `SYSTEM.md` 818; prompts 3,214 to 2,865.
> - 2026-11-16 de-duplication, which moved the argument and Jira ticket rules
>   into `SYSTEM.md`: `SYSTEM.md` 818 to 1,017; prompts 3,252 to 1,613; all
>   authored prompts, skills, references, and `SYSTEM.md` 35,647 to 33,171.

## 🧭 Harness discovery

- Pi native RPC startup confirmed global instructions and shared commands.
- OMP native startup confirmed global instructions and authored skills; a
  former `/commit-message` adapter expanded in an isolated directory. The probe
  first treated OMP's system prompt array as a string; corrected inspection
  confirmed the shared text.
- OpenCode native diagnostics accepted the configuration and discovered the
  shared commands present on 2026-11-07.
- Codex 0.167.0 (2026-11-16): `codex debug prompt-input`, which makes no model
  request, listed the hub skills in the model context and none of the prompt
  adapters, which are explicit-only. Codex runs skills with `$name` or the
  `/skills` menu; it has no custom slash commands, and the legacy `/prompts:`
  namespace is unsupported.
- Kiro v3 login and agent discovery worked (2026-11-07). A chat run listed the
  authored skills then present; its interactive `/prompts` menu exposed file
  prompts and skills. Non-interactive slash inputs reached the model.
- Antigravity `agy` 1.1.26 (2026-11-16): print-mode runs quoted `SYSTEM.md`
  from `~/.gemini/config/AGENTS.md` and listed the hub skills and prompt
  adapters. Slash commands expand skills, so `/commit` runs the adapter.
- Claude re-read prompts and skills after edits; the `shell` skill rendered
  intact when invoked with arguments (no `$0`-style placeholders remain).

## 🔁 Workflows

Each run used an isolated repository on `feat/ABC-12-greeting` with one staged
file unless noted. No run staged files, committed, or changed history.

- Claude `/commit-message` (2026-11-07): empty staging produced no message
  file; a staged README produced a ticketed message.
- Claude, following the updated `commit-message` skill (2026-11-16): empty
  staging stopped; the shared rule in `SYSTEM.md` took `ABC-12` from the
  branch.
- OMP: an extension hook that threw did not stop model execution; one
  commit-message run completed, reporting the directory was not a repository.
- Antigravity `/commit` (2026-11-16, print mode): the log showed
  `expanded slash command "commit" (skill)`; the model read
  `prompts/commit.md` and the `commit-message` skill, ran
  `git diff --cached --stat && git diff --cached`, and wrote
  `feat(greeting):[ABC-12] add greeting text file`.
- Codex `$commit` (2026-11-16, `codex exec -s workspace-write`): the model read
  the adapter, `prompts/commit.md`, and the `commit-message` skill, ran
  `git diff --cached`, checked `JIRA_ISSUE`, and wrote
  `feat(greeting):[ABC-12] add hello greeting`. It stayed in the repository.

> [!WARNING]
> In `agy -p` print mode the model did not receive the workspace: hook events
> showed `workspacePaths: []`, and a bare `/commit` ran `git status` in
> `/home/sobh`, then tried to inspect `~/dotfiles` until headless mode denied
> a command outside the allow list. Passing the path as the argument
> (`/commit The repository is <path>; ...`) kept it in the repository.
> Interactive sessions were not checked.

- Not run end to end: `prc`, `pru`, `prr`, `rev`, `revv`, `cr`, and `jira` in
  any harness; Codex's interactive `$` picker and `/skills` menu. Discovery
  for these was checked in every harness's skill and prompt locations. No PRs,
  Jira updates, or change requests were created.

## 🪝 Bootstrap and hooks

- Isolated homes (2026-11-07): fresh setup matched the previous script's
  output exactly; dry runs created no files and reported the same conflicts,
  backups, and stale Codex adapters as real runs; four reruns left files,
  links, and modification times unchanged; merges kept unrelated keys and
  hooks; stale guard entries from a moved checkout (including paths with
  spaces) were replaced, not duplicated.
- Isolated homes (2026-11-16): OpenCode paths from an earlier hub location
  were replaced in place with user entries kept; Antigravity wiring backed up
  overlapping skills, kept other skills and named hooks, replaced an old
  `ai-guard` entry, and left Codex output byte-identical. Reruns were
  idempotent.
- Guard: 22 blocked and 17 allowed command cases passed, including quoted
  targets, a regex-special home path, `-uf`, `+refspec`, `git -C`, and
  `--force-with-lease`; `-h`/`--help` and invalid JSON behaved as documented.
  The Antigravity shim denied `rm -rf ~` and `git push -uf`, and replied `ask`
  for `ls` and invalid input.
- `sh -n`, `checkbashisms`, `shfmt -ln posix -d`, and `shellcheck -s sh`
  passed for `bootstrap.sh`, `hooks/guard-shell.sh`, and
  `hooks/antigravity-guard.sh`; `dash -n` was checked on 2026-11-07 only.
- Antigravity hook probes: a workspace `.agents/hooks.json` was not loaded,
  only the global one; a `{}` reply denied the command; `ask` let it run under
  normal permissions.
- Live: in Claude (2026-11-07), a model-issued `git push -f` in an empty
  scratch repository was blocked before execution; in Antigravity (CLI,
  2026-11-16), the guard denied a force push and allowed `echo`.
- Not yet exercised live: hook firing from a model tool call in Codex (needs
  `/hooks` trust), Kiro, Pi, OMP, OpenCode, and the Antigravity IDE and 2.0
  app.

## 🖥️ Machine notes

> [!WARNING]
> Codex trusts `/home/sobh`, broader than individual project roots. This
> existing setting was not changed.

- The hub is tracked in the dotfiles repository at `.config/ai`; since
  2026-11-07, `~/.config` is a link to `~/dotfiles/.config`. Hub links use
  the resolved `~/dotfiles/.config/ai` path.
- Hand-written originals replaced by hub content are kept outside discovery:
  - Kiro prompts: `~/.config/ai-backups/20261107-160747/.kiro/prompts/`.
  - Antigravity `commit`, `fs-cr-new`, `pr`, and `review`:
    `~/.local/state/ai-bootstrap/backups/20261116-073054-665971/`.
  - Antigravity `jira-issue` and `pr-release`:
    `~/.local/state/ai-bootstrap/backups/20261116-073547-670492/`.
  - Antigravity `pr-update` and `review-update`:
    `~/.local/state/ai-bootstrap/backups/20261116-074017-674483/`.
- Other directories under `~/.local/state/ai-bootstrap/backups/` hold replaced
  links, generated adapters, and settings from earlier runs.

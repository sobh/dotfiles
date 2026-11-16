# 🧪 Verification log

Dated checks, measurements, and machine-specific notes for this hub. The
[README](README.md) describes intended behavior; this file records evidence
and its limits. Recheck after harness upgrades.

## 📉 Measured token budget

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
> Later path edits (2026-11-07) made `SYSTEM.md` 818 bytes and shortened the
> prompts from 3,214 to 2,865 bytes. These are file sizes, not a new probe;
> the table above was not re-measured.

## 🧭 Harness discovery

- Pi native RPC startup confirmed global instructions and shared commands.
- OMP native startup confirmed global instructions and authored skills; a
  former `/commit-message` adapter expanded in an isolated directory. The probe
  first treated OMP's system prompt array as a string; corrected inspection
  confirmed the shared text.
- OpenCode native diagnostics accepted the configuration and discovered all
  seven shared commands.
- Codex native discovery confirmed the short adapters; `$pr` uses the PR skill
  and `$pu` remains explicit-only. The legacy `/prompts:` namespace is
  unsupported.
- Kiro v3 login and agent discovery worked. A chat run listed all six authored
  skills then present; its interactive `/prompts` menu exposed file prompts
  and skills. Non-interactive slash inputs reached the model.
- Claude re-read prompts and skills after edits; the `shell` skill rendered
  intact when invoked with arguments (no `$0`-style placeholders remain).

## 🔁 Workflows

- Claude `/commit-message` ran in an isolated temporary Git repository: empty
  staging produced no message file; a staged README on a Jira-named branch
  produced a ticketed message without changing staging or history.
- An OMP extension hook that threw did not stop model execution: one isolated
  commit-message run completed, reporting the directory was not a repository.
  No commit was created.
- Other workflows were checked through startup, registries, and menus, not
  end-to-end model runs. No PRs or change requests were created.

## 🪝 Bootstrap and hooks

- Isolated homes (2026-11-07): fresh setup matched the previous script's
  output exactly; dry runs created no files and reported the same conflicts,
  backups, and stale Codex adapters as real runs; four reruns left files,
  links, and modification times unchanged; merges kept unrelated keys and
  hooks; stale guard entries from a moved checkout (including paths with
  spaces) were replaced, not duplicated.
- Guard: 22 blocked and 17 allowed command cases passed, including quoted
  targets, a regex-special home path, `-uf`, `+refspec`, `git -C`, and
  `--force-with-lease`; `-h`/`--help` and invalid JSON behaved as documented.
- `sh -n`, `dash -n`, `checkbashisms`, `shfmt -ln posix -d`, and
  `shellcheck -s sh` passed for `bootstrap.sh` and `hooks/guard-shell.sh`.
- Live (2026-11-07): `bootstrap.sh -b` wired all six harnesses. In Claude, a
  model-issued `git push -f` in an empty scratch repository was blocked by the
  hook before execution.
- Not yet exercised live: Codex (needs `/hooks` trust), Kiro, Pi, OMP, and
  OpenCode hook firing from a model tool call.

## 🖥️ Machine notes

> [!WARNING]
> Codex trusts `/home/sobh`, broader than individual project roots. This
> existing setting was not changed.

- The original Kiro prompt directory is preserved outside discovery at
  `~/.config/ai-backups/20261107-160747/.kiro/prompts/`.
- The 2026-11-07 live bootstrap backed up `~/.claude/settings.json`, six
  hand-written Codex adapters, and `opencode.json` (formatting only) to
  `~/.local/state/ai-bootstrap/backups/20261107-174125-753714/`.
- The `rl` prompt was merged into `cr` (2026-11-07). Its generated Codex
  adapter moved to
  `~/.local/state/ai-bootstrap/backups/20261107-175032-rl-removed/rl/`.
- Prompts were renamed (2026-11-07): `cm`→`commit`, `pr`→`pr-create`,
  `pu`→`pr-update`, `rv`→`review-staged`, `ru`→`review-verify`,
  `cr`→`change-request`. Old Codex adapters moved to
  `~/.local/state/ai-bootstrap/backups/20261107-175320-prompt-rename/`.
- Prompts were shortened (2026-11-16): `pr-create`→`prc`, `pr-update`→`pru`,
  `review-staged`→`rev`, `review-verify`→`revv`, `change-request`→`cr`.
  Old Codex adapters moved to
  `~/.local/state/ai-bootstrap/backups/20261116-prompt-shorten/`.
- `~/.config/ai` now resolves to `~/dotfiles/.config/ai`; `bootstrap.sh -b`
  re-pointed all links (2026-11-16). Backups are in
  `~/.local/state/ai-bootstrap/backups/20261116-072200-657071/`. Bootstrap
  appended new `opencode.json` paths beside the old ones; the stale
  `~/.config/ai/` entries were removed by hand. `bootstrap.sh` now replaces
  them itself; checked against an isolated fixture under a temporary `HOME`
  (stale paths replaced in place, user entries kept, rerun idempotent).
- Antigravity added (2026-11-16, `agy` 1.1.26). Overlapping hand-written
  skills (`commit`, `fs-cr-new`, `pr`, `review`) moved to
  `~/.local/state/ai-bootstrap/backups/20261116-073054-665971/`;
  `jira-issue`, `pr-release`, `pr-update`, and `review-update` were kept.
  Probes: a workspace `.agents/hooks.json` was not loaded (only the global
  one was); a `{}` hook reply denied the command; `ask` let it run. Live
  `agy -p` runs then quoted `SYSTEM.md`, listed the hub skills and adapters,
  ran `echo`, and denied a force push via the guard. Adapter slash commands
  were not run end to end.
- The hub is tracked in the dotfiles repository at `.config/ai`; since
  2026-11-07, `~/.config` is a link to `~/dotfiles/.config`.

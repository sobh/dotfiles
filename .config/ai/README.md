# ⚙️ Shared AI configuration

```text
ai/
├── SYSTEM.md              Shared engineering instructions
├── bootstrap.sh           Safe default-harness wiring
├── hooks/                 Shared shell guard and thin harness shims
├── prompts/               Short, user-invoked workflow adapters
├── skills/
│   ├── <name>/SKILL.md     Canonical workflow definitions
│   ├── <name>/references/ On-demand procedure details
│   └── synced/            Managed content — do not edit
├── README.md              Wiring, shortcuts, and hooks
└── VERIFICATION.md        Dated checks, measurements, and machine notes
```

Prompts are thin adapters that read explicit skill paths under
`${XDG_CONFIG_HOME:-~/.config}/ai/`. They do not assume one harness's skill
invocation or argument substitution works in another. Supply commit ranges and
other inputs in the request; procedures treat them as data. Keep authored text
wrapped at 80 columns.

## 🚀 New-machine bootstrap

Check out this directory at `~/.config/ai`, then run:

```sh
sh ~/.config/ai/bootstrap.sh -h   # Help from the script's own comment header
sh ~/.config/ai/bootstrap.sh -n   # Preview without creating files
sh ~/.config/ai/bootstrap.sh      # Apply; refuse conflicting destinations
sh ~/.config/ai/bootstrap.sh -b   # Apply, backing up conflicts (-nb previews)
```

Requires POSIX `sh`, `jq`, and `readlink`. It wires all six default harness
locations, even for harnesses not installed yet, without installing,
authenticating, or making model requests. It links shared instructions,
skills, and prompts; generates explicit-only Codex prompt adapters (skipped
when a skill has the same name); and merges shared paths and hooks into JSON
settings while keeping unrelated keys. Codex bundled skills are untouched.

> [!WARNING]
> Without `-b`, any existing destination that differs is a conflict and the
> run stops. With `-b`, conflicts move to a numbered directory under
> `${XDG_STATE_HOME:-$HOME/.local/state}/ai-bootstrap/backups/`, outside
> discovery. A failure can leave earlier wiring applied; fix the cause and
> rerun. `-n` reports the same results as a real run without writing files.

Reruns are idempotent: matching links and generated files are left untouched.
Links use absolute paths, so rerun after moving the checkout.
`XDG_CONFIG_HOME`, `XDG_STATE_HOME`, and `CODEX_HOME` must be absolute when
set. Named Pi/OMP profiles, models, trust settings, credentials, and MCP
servers are not changed.

## 🔗 Harness discovery

| Harness | Instructions | Skills | Prompts |
| --- | --- | --- | --- |
| Claude | `~/.claude/CLAUDE.md` | `~/.claude/skills` | `~/.claude/commands` |
| Pi, OMP | `agent/APPEND_SYSTEM.md` | `agent/skills` | `agent/prompts` |
| Kiro | `~/.kiro/steering/system.md` | `~/.kiro/skills` | `~/.kiro/prompts` |
| Codex | `$CODEX_HOME/AGENTS.md` | Per-skill links | Generated adapters |
| OpenCode | `instructions` in JSON | `skills` in JSON | `commands/` |

Each entry links to `SYSTEM.md`, `skills/`, or `prompts/`. Pi and OMP append
`SYSTEM.md` to their built-in prompts. OpenCode's `opencode.json` lists
`skills/docs` last so the authored docs skill wins over the managed synced one.

### ⌨️ Workflow shortcuts

| Name | Action | Skill |
| --- | --- | --- |
| `commit` | 📝 Commit message | `commit-message` |
| `pr-create` | 🔀 PR create | `pr` |
| `pr-update` | 🔄 PR update | `pr` (update reference) |
| `review-staged` | 🔍 Review staged changes | `review` |
| `review-verify` | ✅ Verify review fixes | `review` (update reference) |
| `change-request` | 📋 Change request; `release` for a PR | `fs-cr-new` |

Use `/commit`, `/pr-create`, etc. in slash-command harnesses and `$commit`,
`$pr-create`, etc. in Codex. `/change-request release 482` or a PR URL selects
release mode; a bare number is a commit selection. Prompt names differ from
skill names so no prompt is hidden by a skill. Update procedures live in
`references/update.md` and load only for update requests.

> [!TIP]
> Restart or reload active harnesses after changing prompts or skills.

## 🪝 Hooks

`hooks/guard-shell.sh` holds the logic; each harness gets a thin adapter wired
by `bootstrap.sh`. The guard blocks recursive `rm` of `/`, `~`, `$HOME`, or the
home path (quoted or with a trailing `/` or `/*`), and force pushes:
`--force`, `-f` alone or combined (`-uf`), and `+refspec`, also after options
such as `git -C DIR`. `--force-with-lease` is allowed. It is an accident
guardrail, not a security boundary.

| Harness | Wiring |
| --- | --- |
| Claude | `hooks.PreToolUse` entry merged into `~/.claude/settings.json` |
| Codex | Same entry merged into `$CODEX_HOME/hooks.json` |
| Kiro | Generated `~/.kiro/hooks/ai-guard.json` (`PreToolUse`, `shell`) |
| Pi, OMP | `hooks/pi-guard.ts` linked into `agent/extensions/` |
| OpenCode | `hooks/opencode-guard.ts` linked into `plugins/` |

Claude, Codex, and Kiro run the guard directly: it reads event JSON on stdin
and blocks with exit code 2. Pi, OMP, and OpenCode shims run it and return
their native block result. A guard entry from an earlier checkout location
(`sh '…/hooks/guard-shell.sh'`) is replaced rather than duplicated.

> [!WARNING]
> Codex skips new or changed hooks until you trust them with `/hooks`.

Add hooks for other events as separate scripts. Event names and blocking
semantics differ, so test each adapter before sharing a script.

## 🛡️ Workflow safety

Commit generation reads the full staged diff, stops on empty staging, preserves
uppercase Jira IDs, and writes `COMMIT_MSG.md` without staging or committing.
PR documentation separates observed test execution from suggested verification.
Review updates relocate findings in current code rather than trusting old line
numbers. Freshservice creation remains an explicit user-approved action.

## 🪶 Changing this configuration

Use the [ai-config skill](skills/ai-config/SKILL.md) to audit or change this
hub, and the [shell skill](skills/shell/SKILL.md) for scripts. Record new
checks and measurements in [VERIFICATION.md](VERIFICATION.md), not here.

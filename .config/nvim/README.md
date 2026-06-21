# 🛠️ NeoVim Config

Personal NeoVim configuration built on Lua.

## 📋 Requirements

- Neovim 0.12+
- A [Nerd Font](https://www.nerdfonts.com/) (falls back to ASCII in TTY)
- `git`, `ripgrep` (`rg`), `fzf`

## 📦 Package Management

Packages are managed using [folke/lazy.nvim](https://github.com/folke/lazy.nvim).

## 🗂️ Structure

```
lua/sobh/
├── config/
│   ├── autocmds.lua    -- Autocommands (yank highlight, trailing whitespace, spell)
│   ├── icons.lua       -- Centralized icons (with TTY fallback)
│   ├── lsp.lua         -- Diagnostics configuration
│   └── options.lua     -- General editor options
├── mappings/
│   ├── init.lua        -- Global keymaps
│   ├── README.md       -- Full keymap reference
│   └── plugins/        -- Per-plugin keymaps
├── plugins/
│   ├── ai/             -- AI assistants
│   ├── code/           -- Formatter, linter, treesitter, LSP
│   ├── editor/         -- Editing enhancements
│   ├── general/        -- Fuzzy finder, which-key
│   ├── ui/             -- Colorschemes, indent guides, explorer
│   └── vcs/            -- Git integration
├── utils.lua           -- Utility functions
└── init.lua            -- Re-exports utils
```

## 🔌 Plugins

### 🎨 UI
- **colorschemes** — Theme collection (caironoon default, habamax fallback)
- **snacks.nvim** — Notifications, word highlights, lazygit
- **dressing.nvim** — Better `vim.ui.input`/`vim.ui.select` popups
- **nvim-highlight-colors** — Inline color code highlighting
- **blink.indent** / indent-rainbowline / indent-blankline — Indent guides
- **neo-tree** / snacks.explorer / nvim-tree — File explorer (pick one)
- **outline.nvim** — Code outline sidebar

### 🔍 General
- **Telescope** / **fzf-lua** — Fuzzy finder (pick one)
- **which-key.nvim** — Keymap popup/discovery

### 🔀 VCS
- **gitsigns.nvim** — Gutter signs, hunk staging, inline blame
- **diffview.nvim** — Diff viewer and file history
- **vim-fugitive** — Git blame drilling, `:Git` commands

### ✏️ Editor
- **nvim-cmp** — Completion engine
- **vim-easy-align** — Text alignment
- **vim-stabs** — Tabs for indentation, spaces for alignment
- **grug-far.nvim** — Search and replace across files
- **Comment.nvim** — Toggle comments (`gc`, `gb`)
- **mini.ai** — Enhanced text objects

### 🤖 AI (use one at a time)
- **avante.nvim** — Cursor-like AI sidebar (ACP/Kiro)
- **agentic.nvim** — ACP-based chat interface (portable sessions)

### 💻 Code
- **conform.nvim** — Code formatting (auto-format on save, except Lua)
- **nvim-lint** — Linting (cspell for spelling)
- **nvim-treesitter** — Syntax highlighting, folding, text objects
- **nvim-lspconfig** — LSP (ts_ls, eslint, lua_ls, pyright, rust_analyzer, clangd, gopls, phpactor)

## ⌨️ Key Mappings

See [lua/sobh/mappings/README.md](lua/sobh/mappings/README.md) for the full reference.

Leader key: `<Space>`

## 🖥️ TTY Support

The config detects dumb terminals (`TERM=linux`) and falls back to:
- ASCII icons instead of Nerd Fonts
- No `termguicolors`
- No cursor shape changes
- Simple fold characters (`+`/`-`)

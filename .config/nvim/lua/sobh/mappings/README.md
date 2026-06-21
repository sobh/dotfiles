# ⌨️ Key Mappings

Keymaps use plain `vim.keymap.set` calls. No custom DSL or abstraction layer.

## 🗂️ Structure

- `init.lua` — Global keymaps (`M.setup()`) and the `M.load(name, opts)` helper.
- `plugins/` — Per-plugin keymaps. Each file returns a function that accepts an
  `opts` table (e.g. `{ buffer = bufnr }`) and registers keymaps via
  `vim.keymap.set`.

## 📖 Usage

From a plugin's `config` function:

```lua
require('sobh.mappings').load('lsp', { buffer = bufnr })
```

## 🌐 Global Keymaps

| Key          | Mode | Description                          |
| ------------ | ---- | ------------------------------------ |
| `;`          | n, v | Command mode (swapped with `:`)      |
| `:`          | n, v | Repeat f/t motion (swapped with `;`) |
| `<leader>x`  | n    | Execute current file                 |
| `jk`         | i    | Escape to normal mode                |
| `jj`         | i    | Escape to normal mode                |
| `<Esc>`      | i, n | Escape, clear hlsearch, close floats |
| `<S-Tab>`    | n    | Switch to recent buffer              |
| `j` / `k`    | n    | Move by display line (respects wrap) |
| `<leader>.d` | n    | Config directory                     |
| `<leader>.e` | n    | Config edit (vsplit)                 |
| `<leader>pv` | n    | Project View (netrw)                 |
| `<leader>sw` | n    | Substitute word under cursor         |
| `<leader>y`  | n, v | Yank to system clipboard             |
| `<leader>Y`  | n    | Yank line to system clipboard        |
| `<leader>p`  | n, v | Paste from system clipboard          |
| `<leader>P`  | n, v | Paste before from system clipboard   |

### 🪟 Window Management

| Key          | Mode | Description            |
| ------------ | ---- | ---------------------- |
| `<leader>wh` | n    | Window left            |
| `<leader>wj` | n    | Window down            |
| `<leader>wk` | n    | Window up              |
| `<leader>wl` | n    | Window right           |
| `<leader>ws` | n    | Split horizontal       |
| `<leader>wv` | n    | Split vertical         |
| `<leader>wq` | n    | Close window           |
| `<leader>wo` | n    | Close other windows    |
| `<leader>w=` | n    | Equalize windows       |
| `<leader>ww` | n    | Next window            |

## 🔌 Plugin Keymaps

### 🔍 Telescope / fzf-lua

| Key               | Mode | Description                        |
| ----------------- | ---- | ---------------------------------- |
| `<leader><Space>` | n    | Find existing buffer               |
| `<leader>/`       | n    | Search current buffer              |
| `<leader>?`       | n    | Search workspace                   |
| `<leader>m`       | n    | Search Keymaps                     |
| `<leader>fd`      | n    | Find Diagnostics                   |
| `<leader>ff`      | n    | Find Files                         |
| `<leader>fg`      | n    | Find Git Files                     |
| `<leader>fh`      | n    | Find Help                          |
| `<leader>fr`      | n    | Find Recently Opened Files         |
| `<leader>fw`      | n    | Find Word under cursor (buffer)    |
| `<leader>fW`      | n    | Find Word under cursor (workspace) |
| `<leader>gc`      | n    | Git Commits                        |
| `<leader>ga`      | n    | Git Status                         |

### 💻 LSP / Code (buffer-local)

| Key           | Mode | Description             |
| ------------- | ---- | ----------------------- |
| `gd`          | n    | Goto Definition         |
| `gD`          | n    | Goto Declaration        |
| `gi`          | n    | Goto Implementation     |
| `gr`          | n    | Goto References         |
| `gy`          | n    | Goto Type Definition    |
| `K`           | n    | Hover Documentation     |
| `<C-k>`       | n    | Signature Help          |
| `<leader>cr`  | n    | Code Rename             |
| `<leader>ca`  | n    | Code Action             |
| `<leader>cf`  | n, v | Code Format             |
| `<leader>cs`  | n    | Document Symbols        |
| `<leader>cS`  | n    | Workspace Symbols       |
| `<leader>cwa` | n    | Workspace Add Folder    |
| `<leader>cwr` | n    | Workspace Remove Folder |
| `<leader>cwl` | n    | Workspace List Folders  |

### 🔎 Search and Replace

| Key          | Mode | Description                    |
| ------------ | ---- | ------------------------------ |
| `<leader>sr` | n    | Search and Replace (workspace) |
| `<leader>sb` | n    | Search and Replace (buffer)    |

### 📐 EasyAlign

| Key  | Mode | Description              |
| ---- | ---- | ------------------------ |
| `ga` | x    | Align Text (interactive) |

### 📁 Explorer

| Key          | Mode | Description         |
| ------------ | ---- | ------------------- |
| `<leader>et` | n    | Explorer toggle     |
| `<leader>ef` | n    | Explorer focus      |
| `<leader>eg` | n    | Explorer git status |

### 🔀 VCS

#### Gitsigns

| Key           | Mode | Description               |
| ------------- | ---- | ------------------------- |
| `<leader>gB`  | n    | Blame line popup          |
| `<leader>gd`  | n    | Diff against index        |
| `<leader>gp`  | n    | Preview Hunk              |
| `<leader>gr`  | n, v | Reset Hunk                |
| `<leader>gR`  | n    | Reset Buffer              |
| `<leader>gs`  | n, v | Stage Hunk                |
| `<leader>gS`  | n    | Stage Buffer              |
| `<leader>gu`  | n    | Undo Stage Hunk           |
| `<leader>gtb` | n    | Toggle inline Blame       |
| `<leader>gtd` | n    | Toggle Deleted            |
| `<leader>gtl` | n    | Toggle Line Highlight     |
| `<leader>gtw` | n    | Toggle Word Diff          |
| `ih`          | x, o | Select Hunk (text object) |

#### Fugitive

| Key          | Mode | Description                    |
| ------------ | ---- | ------------------------------ |
| `<leader>gb` | n    | Git Blame sidebar (~ to drill) |

#### Diffview

| Key          | Mode | Description      |
| ------------ | ---- | ---------------- |
| `<leader>gv` | n    | Git Diffview     |
| `<leader>gh` | n    | Git File History |

#### Global

| Key          | Mode | Description                        |
| ------------ | ---- | ---------------------------------- |
| `<leader>gD` | n    | Diff file against git ref (prompt) |
| `<leader>gg` | n    | Lazygit                            |

### ✨ Snacks

| Key  | Mode | Description         |
| ---- | ---- | ------------------- |
| `]w` | n    | Next word reference |
| `[w` | n    | Prev word reference |

### 🧭 Outline

| Key          | Mode | Description    |
| ------------ | ---- | -------------- |
| `<leader>ot` | n    | Toggle Outline |
| `<leader>of` | n    | Focus Outline  |

## 💡 Which-Key

[folke/which-key.nvim](https://github.com/folke/which-key.nvim) automatically
discovers keymaps that have a `desc` field. No manual registration is needed.

# Neovim Skills

## Purpose

This note is a reusable reference for how to think about Neovim, especially a modern Lua-based setup built on LazyVim.

It is not just a command cheat sheet. The goal is to preserve the reasoning behind the setup so future changes feel intentional instead of random.

---

## Core Mental Model

### Neovim is a programmable editor

Neovim is not just a text editor with plugins bolted on. It is a runtime for:

- buffers
- windows
- tabs
- Lua configuration
- plugins
- background integrations like LSP servers

Why this matters:

- once the setup is seen as a Lua program, files like `init.lua`, `config/lazy.lua`, and `plugins/*.lua` stop feeling magical

### The stack has layers

1. Neovim
2. `lazy.nvim` plugin manager
3. LazyVim distribution
4. local config/overrides

Why this matters:

- most problems come from forgetting which layer is responsible for what

Examples:

- if a plugin is installed/loaded weirdly -> likely `lazy.nvim` / plugin spec issue
- if a feature already exists before local config -> likely LazyVim default
- if behavior is custom and only in one file -> likely local override

---

## Understanding Config Structure

### `init.lua`

This is the entry point.

Typical role:

- bootstrap the rest of the config

Reason:

- keeping `init.lua` small makes the whole config easier to reason about

### `lua/config/*.lua`

These are files that usually run code directly.

Examples:

- `options.lua`
- `keymaps.lua`
- `autocmds.lua`

Use them for:

- global editor settings
- global mappings
- autocmd behavior

Why:

- these are editor-level concerns, not plugin declarations

### `lua/plugins/*.lua`

These usually return plugin spec tables.

Use them for:

- adding a plugin
- disabling a plugin
- adjusting plugin options
- small per-plugin overrides

Why:

- LazyVim/lazy.nvim reads these tables and merges them into the plugin graph

---

## Plugin Specs

Typical pattern:

```lua
return {
  "plugin/name",
  opts = { ... },
}
```

Important fields:

- plugin repo string
- `opts`
- `config`
- `dependencies`
- `keys`
- `event`
- `ft`
- `enabled = false`

### `opts` vs `config`

Use `opts` when:

- plugin already exposes normal setup options
- the goal is merging settings cleanly

Use `config` when:

- custom logic is needed
- plugin setup is manual
- deeper behavior is being overridden

Why this matters:

- `opts` is safer and easier to maintain
- `config` is more powerful but easier to make fragile

Rule of thumb:

- prefer `opts`
- only use `config` when you need actual code

---

## Buffers, Windows, Tabs

### Buffer

An in-memory open file or text object.

Why this matters:

- deleting a buffer is usually not deleting the file on disk

### Window

A view onto a buffer.

Why this matters:

- multiple windows can show one buffer

### Tab

A layout containing windows.

Why this matters:

- tabs are not files

---

## LSP Skills

### What an LSP is

LSP = Language Server Protocol.

It defines how the editor talks to local language tools.

Why "server" is misleading:

- usually local, not internet-based

Examples of LSP features:

- diagnostics
- hover
- references
- definition
- rename
- completion

### What a linter is

A linter is a separate rule checker.

Examples:

- `ruff`
- `eslint`
- `verible-verilog-lint`

Why LSP and linting feel similar:

- both can produce diagnostics

Why they are different:

- LSP = language intelligence + diagnostics
- linter = rule/style/quality checker

### Practical LSP debugging checklist

When a language seems broken, check:

```vim
:LspInfo
:set filetype?
:lua print(vim.inspect(vim.lsp.get_clients({ bufnr = 0 })))
```

Why this helps:

- confirms filetype
- confirms whether a client is attached
- separates "tool missing" from "diagnostics not showing"

### Python lesson

Problem:

- Python file opened, but no syntax diagnostics appeared

Cause:

- LazyVim Python extra was not enabled

Fix:

- enable `lazyvim.plugins.extras.lang.python`

Why:

- many language stacks are optional extras, not core defaults

### C++ lesson

Problem:

- `clangd` seemed inconsistent until saving

Cause:

- `clangd` relies heavily on project metadata like `compile_commands.json`

Fix:

- generate build metadata for the project

Why:

- C++ tooling depends more on external compile flags than many other languages

### Verilog lesson

Problem:

- linting and LSP overlapped and felt noisy

Fix:

- keep Verible LSP only

Why:

- one good source of diagnostics is clearer than two overlapping ones

---

## Diagnostics Skills

### Hover is not diagnostics

`K` usually means hover docs, not "show me the error message".

For diagnostics use:

- `<leader>cd` line diagnostics float
- `[d` previous diagnostic
- `]d` next diagnostic

Why this matters:

- confusion between hover and diagnostics makes LSP feel inconsistent

### Long diagnostics

If an inline message is too long:

- use a float instead of trying to read the whole virtual text

Why:

- floats wrap better and preserve readability

---

## Navigation and Motion Skills

### Flash

Flash is a visual jump plugin.

Useful keys:

- `s` jump by visible text
- `S` syntax-aware jump
- `r` in operator-pending mode for remote jump

Why it matters:

- it can replace repeated low-level motions when moving across visible text quickly

### Operator-pending mode

After pressing commands like:

- `d`
- `c`
- `y`

Neovim is waiting for a target.

Why it matters:

- many advanced motions only make sense after understanding this mode

Example:

- `dr` with Flash = delete to a chosen visual target

---

## Treesitter Skills

Treesitter parses code structure.

It powers things like:

- smarter comments
- better text objects
- syntax-aware jumps

Why it matters:

- modern Neovim behavior often depends on code structure, not just text matching

Example:

- `mini.ai` can select functions/classes/blocks using Treesitter

---

## Explorer Skills

### Directory-open behavior is a plugin decision

Opening:

```bash
nvim .
```

does not mean "show a blank editor".

It means:

- open Neovim on a directory target

Then some explorer plugin decides what that means.

### Yazi lesson

Problem:

- `nvim .` showed another explorer behind Yazi

Cause:

- `neo-tree` was still enabled as a LazyVim extra
- Yazi was also opening
- result: two directory UIs at once

Fix:

- load Yazi at startup
- disable Snacks explorer
- disable Neo-tree locally

Why this matters:

- directory-opening behavior can be owned by only one explorer cleanly
- otherwise multiple plugins race to handle the same directory argument

### Yazi configuration lesson

`yazi.nvim` config controls the Neovim bridge, not Yazi itself.

Why this matters:

- Yazi theme/key customization belongs in Yazi config files
- Neovim plugin config only controls how Yazi integrates into Neovim

---

## Theme Skills

### Omarchy lesson

The clean Omarchy-aware Neovim theme setup is:

- `~/.config/omarchy/current/theme/neovim.lua` is the current generated Neovim theme spec
- `~/.config/nvim/lua/plugins/theme.lua` is a symlink to that file

Why this matters:

- Omarchy becomes the source of truth for theme selection
- Neovim does not need a custom theme-sync workaround

### On-demand theme plugin installs

A giant preinstall list of theme plugins is not always necessary.

Why:

- if a theme plugin can be installed when needed, setup can stay leaner

Tradeoff:

- first switch may be slower, but config is simpler

---

## Command-Line and UI Skills

### Noice

Noice changes message/cmdline UI.

Lesson learned:

- LazyVim presets can interfere with custom placement

Why:

- a preset like `command_palette = true` can override or reshape popup behavior

Fix pattern:

- if exact placement is needed, disable the preset and configure views directly

---

## LazyVim Skills

### Prefer defaults first

If LazyVim already provides a strong default, use it until there is a real reason not to.

Why:

- fewer moving parts
- easier debugging
- easier learning

Examples:

- comments
- diagnostics UI
- which-key

### Use extras deliberately

Extras are opt-in language/workflow bundles.

Why:

- they keep core LazyVim lighter
- they explain why a language may silently have no LSP until its extra is enabled

### Keep local overrides small

The healthiest local plugin files are:

- short
- purpose-specific
- clearly justified

Why:

- smaller overrides are easier to keep aligned with LazyVim updates

---

## Reusable Workflow for Future Neovim Problems

1. Identify the layer
   - Neovim core?
   - plugin manager?
   - LazyVim default?
   - local override?

2. Check whether the feature already exists in LazyVim
   - if yes, prefer extending it

3. Check whether the issue is loading, filetype, or tool attachment
   - use `:LspInfo`, filetype checks, plugin keys, current buffer info

4. Remove redundant overrides before adding new ones

5. Only add local config when there is a clear reason

---

## High-Value Reminders

- `K` is hover, not diagnostics
- `opts` is usually better than `config`
- `lua/config/` is for immediate editor behavior
- `lua/plugins/` is for plugin specs
- `nvim .` means "open on this directory", not "open empty"
- only one explorer should own directory opening cleanly
- LSPs often make separate linters unnecessary
- LazyVim extras are opt-in
- fewer overrides = easier understanding

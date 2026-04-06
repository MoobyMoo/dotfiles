# Neovim + LazyVim Learning Map

**Status:** Active reference  
**Scope:** How this Neovim config works, why each layer exists, what was simplified, and how the pieces connect  
**Main config root:** `~/.config/nvim`  
**Plugin install root:** `~/.local/share/nvim/lazy`

---

## Why This Note Exists

This note is meant to be the "big picture" explanation of the Neovim setup, not just a pile of facts.

The goal is to answer questions like:

- What starts first when Neovim opens?
- What is LazyVim actually doing for me?
- Which files are mine and which files belong to LazyVim?
- Why do some things live in `config/` and others in `plugins/`?
- Why did some custom files turn out to be redundant?
- Why do LSPs, diagnostics, linters, Mason, and filetype detection all feel connected?

This note also records the problems we ran into and why the chosen fixes make sense.

---

## The Mental Model

The cleanest way to understand this setup is to think in layers.

### Layer 1: Neovim itself

Neovim is just the editor.

It knows how to:

- open files
- run Lua config
- show buffers/windows/tabs
- host plugins
- talk to local background tools like language servers

It does **not** automatically know:

- which plugins you want
- which LSP server to use for a language
- what your theme should be
- what keys you want

That is what the config solves.

### Layer 2: `lazy.nvim`

`lazy.nvim` is the plugin manager.

Its job is:

- install plugins
- update plugins
- load plugins lazily when appropriate
- merge plugin specs from different files

It is not the UI, not the LSP, and not a theme system. It is the plugin loader/manager.

### Layer 3: LazyVim

LazyVim is a distribution built on top of `lazy.nvim`.

Its job is:

- provide a very strong default plugin set
- give sane keymaps and UI defaults
- give a consistent LSP/formatting/diagnostic setup
- offer optional language "extras"

LazyVim is the reason things like:

- `gd`
- `gr`
- `K`
- `which-key`
- `bufferline`
- `lualine`
- `flash.nvim`
- diagnostics UI

already existed before any personal customization.

### Layer 4: local overrides

This is the stuff inside:

- `~/.config/nvim/lua/config/`
- `~/.config/nvim/lua/plugins/`

This layer is where personal behavior lives.

Its job is:

- add plugins LazyVim does not include
- disable LazyVim plugins you do not want
- tweak plugin defaults
- add language-specific configuration
- connect external systems like Omarchy themes to Neovim

This layer should usually be **small**. The more it duplicates LazyVim, the harder the setup is to understand.

---

## Startup Flow: What Happens When Neovim Opens

This is the most important connection chain in the config.

### Step 1: `init.lua`

File:

- `~/.config/nvim/init.lua`

It does one thing:

```lua
require("config.lazy")
```

Meaning:

- load the Lua module `config.lazy`
- which corresponds to `~/.config/nvim/lua/config/lazy.lua`

Why this matters:

- `init.lua` stays tiny
- all real startup logic is moved into organized modules

### Step 2: `config/lazy.lua`

File:

- `~/.config/nvim/lua/config/lazy.lua`

This file:

1. calculates where `lazy.nvim` should be installed
2. clones it if missing
3. adds it to Neovim's runtime path
4. calls `require("lazy").setup({ ... })`

Why it uses `~/.local/share/nvim` instead of `~/.config/nvim`:

- `~/.config/nvim` is for your editable config
- `~/.local/share/nvim` is for installed plugin code and runtime data

That separation is normal:

- config files = instructions
- plugin install directory = downloaded tools

### Step 3: `require("lazy").setup({ ... })`

This starts the plugin manager and gives it a big configuration table.

The key part is:

```lua
spec = {
  { "LazyVim/LazyVim", import = "lazyvim.plugins" },
  { import = "lazyvim.plugins.extras.lang.markdown" },
  { import = "lazyvim.plugins.extras.lang.python" },
  { import = "plugins" },
}
```

This means:

1. load LazyVim's built-in plugin specs
2. load selected LazyVim extras
3. then load local plugin specs from `lua/plugins/`

Why the order matters:

- LazyVim core must load first
- LazyVim extras extend core
- personal overrides should come last

That order is exactly why a Markdown extra had to be moved out of `lua/plugins/` and into `config/lazy.lua`.

---

## Why `require(...)` Matters

`require("config.lazy")` means:

- load a Lua module named `config.lazy`
- dots map to folders
- so Lua looks for `lua/config/lazy.lua`

This is why the folder is named `lua/`.

Examples:

- `require("config.options")` -> `lua/config/options.lua`
- `require("plugins.yazi")` -> `lua/plugins/yazi.lua`

Why this exists:

- it turns the config into a modular Lua program
- files can be separated by purpose instead of becoming one giant `init.lua`

---

## `config/` vs `plugins/`

This distinction is one of the most important things learned.

### `lua/config/*.lua`

These files usually **run code directly**.

Examples:

- `options.lua`
- `keymaps.lua`
- `autocmds.lua`

Typical contents:

- `vim.opt.number = true`
- `vim.keymap.set(...)`
- `vim.api.nvim_create_autocmd(...)`

Why:

- these files are about editor behavior, not plugin declarations

### `lua/plugins/*.lua`

These files usually **return plugin spec tables**.

Typical contents:

```lua
return {
  "plugin/name",
  opts = { ... },
}
```

Why:

- LazyVim/lazy.nvim reads these returned tables and merges them into the plugin system
- these files do not usually perform startup behavior by themselves

So the shortcut is:

- `config/` = do things now
- `plugins/` = describe plugin behavior

---

## What a Plugin Spec Is

A plugin spec is just a Lua table that describes a plugin.

Example shape:

```lua
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = { ... },
}
```

Common fields:

- plugin repo string
- `event`, `ft`, `cmd`, `keys` = lazy-load triggers
- `opts` = settings
- `config = function() ... end` = manual setup code
- `dependencies` = required companion plugins
- `enabled = false` = disable the plugin

Why specs are useful:

- they let many files contribute to one merged plugin graph
- they make lazy loading possible
- they let overrides be small and declarative

---

## `opts` vs `config`

This is a major concept.

### `opts`

Use `opts` when:

- the plugin already has a normal setup path
- you just want to provide or merge settings

Why it is preferred:

- cleaner
- safer
- fits LazyVim's merge model better

### `config = function() ... end`

Use `config` when:

- you need custom Lua logic
- you need to call the plugin manually
- you are doing something more advanced than normal option merging

Why it is riskier:

- easier to override defaults unintentionally
- easier to depend on plugin internals
- harder to maintain

Concrete example:

- `which-key.lua` used `opts` and was simple
- `codesnap.lua` uses deep custom `config` logic and is much more fragile

---

## Buffers, Windows, and Tabs

This mattered because of the Snacks buffer-delete mappings.

### Buffer

A buffer is Neovim's in-memory representation of a file or text document.

Why it matters:

- closing a buffer is not the same as deleting the file on disk

### Window

A window is just a view onto a buffer.

Why it matters:

- multiple windows can show the same buffer

### Tab

A tab is a layout containing one or more windows.

Why it matters:

- tabs do not equal files; they are workspace layouts

This is why `Snacks.bufdelete()` means:

- stop showing/keeping that buffer loaded in Neovim
- not "delete the actual file"

---

## LSP, Protocols, and Linters

This was one of the biggest conceptual areas.

### What a protocol is

A protocol is just an agreed set of rules for how two programs talk.

Why that matters:

- editor and language tools need a standard communication format

### What LSP means

LSP = Language Server Protocol.

It defines how:

- Neovim (client)
- talks to a language server (server)

Why "server" is confusing:

- it usually runs **locally on your machine**
- it does **not** usually mean internet/cloud

Examples of LSP features:

- diagnostics
- go to definition
- references
- rename
- hover docs
- completion
- signature help

### What a linter is

A linter is a separate rule-checking tool.

Examples:

- `ruff`
- `pylint`
- `eslint`
- `verible-verilog-lint`

What it usually focuses on:

- warnings
- style violations
- suspicious code patterns
- project rule enforcement

### Why LSP and linting are separate

Because they solve different layers of the problem.

- LSP asks: "what does this code mean, and is it valid enough to understand?"
- linter asks: "does this code follow the rules, style, and quality constraints we want?"

### Why separate linting is often unnecessary

For many languages, modern LSPs already report a lot of useful diagnostics.

That is why separate linting was removed for:

- Lua
- Python

and kept conceptually only where tooling was weaker, like Verilog, until Verible LSP turned out to cover the same ground well enough.

### The actual decision reached

- Python -> use LSP (`pyright` + `ruff` via LazyVim Python extra)
- C++ -> use `clangd`
- Verilog -> use Verible LSP, not duplicate linting
- MATLAB -> not an LSP; use a MATLAB integration plugin
- Arduino -> not really an LSP plugin; more of a workflow plugin

---

## Treesitter and Operator-Pending Mode

These came up because of Flash and comment handling.

### Treesitter

Treesitter is a parsing system that understands code structure.

Why it matters:

- it knows what is a function, class, tag, string, comment, etc.
- this enables smarter text objects, comments, jumps, and syntax behavior

### Operator-pending mode

This is the temporary state after pressing an operator like:

- `d` delete
- `c` change
- `y` yank

Why it matters:

- Neovim is waiting for a motion/target
- plugins like Flash can act as the motion provider

Example:

- `dr` with Flash means "delete to a Flash-selected target"

---

## LazyVim Internal Files: What They Already Provide

One of the biggest discoveries was that many custom files were redundant because LazyVim already had solid internal defaults.

### `lazyvim/plugins/editor.lua`

Provides:

- `grug-far.nvim`
- `flash.nvim`
- `which-key.nvim`
- `gitsigns.nvim`
- `trouble.nvim`

Why it mattered:

- `which-key` was already built in
- `flash.nvim` was already built in
- `<leader>c` was already the code namespace
- many Git and diagnostics tools already existed

### `lazyvim/plugins/coding.lua`

Provides:

- `mini.pairs`
- `ts-comments.nvim`
- `mini.ai`
- `lazydev.nvim`

Why it mattered:

- comment setup was already there
- autopairs were already there
- Lua config editing support was already there

### `lazyvim/plugins/lsp/init.lua`

Provides:

- diagnostics defaults
- LSP keymaps
- Mason integration
- shared server defaults
- inlay hints / folds / codelens handling

Why it mattered:

- custom diagnostics styling was mostly redundant
- local LSP files only needed to add small per-server settings

### `lazyvim/plugins/ui.lua`

Provides:

- `bufferline.nvim`
- `lualine.nvim`
- `noice.nvim`

Why it mattered:

- a lot of the polished UI was already handled by LazyVim
- top buffer tabs, bottom statusline, popup message UX all come from here

---

## Local Files That Were Kept, Removed, or Changed

This section records the actual cleanup and the reasons behind it.

### Kept

#### `snacks.lua`

Why keep it:

- it powers a lot of the personal workflow
- dashboard
- picker
- terminal
- scratch buffers
- git helper actions
- zen mode

What was changed:

- smooth scrolling was disabled because it felt physically uncomfortable/dizzying

Why:

- comfort matters more than visual novelty

#### `yazi.lua`

Why keep it:

- it is an actual integration you want
- it bridges Neovim and Yazi

Important fixes:

- `open_for_dir` was wrong
- changed to `open_for_directories = true`
- disabled `netrwPlugin` so Yazi can take over directory opening

Why:

- the original option name typo meant the setting likely did nothing
- if Yazi is supposed to be your directory UI, netrw should not race it

#### `verible-lsp.lua`

Why keep it:

- Verilog/SystemVerilog LSP support matters
- Verible LSP provides hover, definitions, diagnostics, references, etc.

Important fix:

- custom `root_dir` so school folders without `.git` still work

Why:

- default root detection is often project-root based
- coursework folders are often not normal Git repos

#### `arduino-nvim.lua`

Why keep it:

- Arduino plugin docs expect a `FileType`-driven setup pattern
- `.ino` file detection needed a local bridge

Why that is okay:

- not every plugin fully self-bootstraps
- this file exists to connect filetype detection to plugin activation

#### `matlab.lua`

Why keep it:

- you actually use MATLAB from Neovim

What was configured:

- set `matlab_dir = "/usr/bin/matlab"`
- added wrappers so run/help/doc commands auto-open the CLI if needed

Why:

- the plugin expected a valid MATLAB executable path
- some commands failed because they tried to send text before the terminal job existed

#### `codesnap.lua`

Why keep it:

- it does real custom screenshot/export behavior

What was fixed:

- removed the incorrect `themes_folders = { "~/.config/yazi" }`

Why:

- CodeSnap theme folders are for CodeSnap themes, not Yazi themes
- built-in theme handling is enough when using `catppuccin-mocha`

### Removed

#### `cmdline.lua`

Why removed:

- it only disabled `fine-cmdline.nvim`
- dead config for a plugin you did not want

#### `disable-news-alert.lua`

Why removed:

- it only disabled LazyVim/Neovim news alerts
- not necessary to understand the config better

#### `diagnostics.lua`

Why removed:

- mostly duplicated LazyVim's built-in diagnostics defaults
- only restyled existing behavior

#### `nvim-lint.lua` and `nvim-lint-verilog.lua`

Why removed:

- general linting for Python/Lua was unnecessary with LSP
- Verible linting duplicated Verible LSP diagnostics

Key lesson:

- if the LSP already gives the needed diagnostics, separate linting often adds noise rather than value

#### `comment.lua`

Why removed:

- LazyVim already had `ts-comments.nvim`
- custom comment setup overlapped and could conflict

#### `disable-flash.lua`

Why removed:

- re-enabled LazyVim's built-in Flash so the default editing workflow can be learned properly

#### `verilog-autoinst.lua`

Why removed:

- it was already disabled
- dead config should not stay around without purpose

#### `which-key.lua`

Why removed:

- goal shifted toward understanding default LazyVim behavior first
- overrides made learning harder

#### `all-themes.lua`

Why removed:

- you are okay with Lazy installing Omarchy theme plugins on demand
- no need to preinstall everything just for convenience

---

## Omarchy Theme Integration: What Was Confusing and What Was True

This was one of the trickiest areas.

### Initial confusion

At first it looked like:

- a custom file `omarchy-theme-hotreload.lua` was managing Neovim theme reloads

That turned out to be a DIY local solution, not the community-standard Omarchy pattern.

### The actual Omarchy-style model

The more accurate model is:

- Omarchy manages `~/.config/omarchy/current/theme/`
- the current Omarchy Neovim theme spec is:
  - `~/.config/omarchy/current/theme/neovim.lua`
- the current Omarchy theme name is:
  - `~/.config/omarchy/current/theme.name`
- `~/.config/nvim/lua/plugins/theme.lua` should be a symlink to:
  - `~/.config/omarchy/current/theme/neovim.lua`

Why this makes sense:

- Omarchy is the source of truth for the current desktop theme
- Neovim should not reinvent that source of truth
- the symlink lets Neovim use Omarchy's own generated theme spec directly

### Final state

- custom hotreload plugin removed
- custom theme-loader plugin removed
- `theme.lua` restored as a symlink to Omarchy's current Neovim theme file

Why this was the right endpoint:

- closer to actual Omarchy community behavior
- less custom glue
- easier to reason about

---

## Python: Why It Was Not Working

Problem:

- Python files opened with `filetype=python`
- but no Python LSP attached
- syntax mistakes in `multiAgents.py` were not being reported

Root cause:

- LazyVim Python support lives in the Python extra
- the Python extra was not enabled in `config/lazy.lua`

Fix:

- enabled `lazyvim.plugins.extras.lang.python`

Result:

- `pyright` attached
- `ruff` attached

Why this matters conceptually:

- LazyVim core is not every language under the sun
- many language stacks are opt-in extras

Example verified file:

- `~/School/intro_AI/Pacman/HW2_pacman/multiAgents.py`

---

## C++: Why It Sometimes Feels Like Save Is Needed

Problem:

- C++ LSP seemed inconsistent until files were saved

What was verified:

- `clangd` is installed
- `clangd` does attach to `.cpp` buffers

Likely cause:

- C++ tooling depends heavily on build/project context
- especially:
  - `compile_commands.json`
  - `compile_flags.txt`

Why save can matter:

- unsaved buffers may not have a stable file path inside the project
- `clangd` may not know which compile flags/includes apply yet
- without build metadata, `clangd` has to guess

So the deeper reason is not "LSP is broken."

It is:

- C++ requires more external project metadata than many languages

Recommended fix per project:

- generate `compile_commands.json`
- e.g. with CMake:

```bash
cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -B build
```

---

## Verilog: Why It Felt Weird

Problem:

- Verible linting initially did not show correctly
- then it felt noisy and duplicated

What happened:

- custom parser was wrong at first
- then LSP and linting overlapped

Fix:

- moved to Verible LSP only

Why that was better:

- LSP already gave diagnostics
- no duplicate warnings
- also got hover/definitions/references/completion

Bigger lesson:

- in ecosystems with weaker tooling, it is common to try both LSP and linters
- but if one tool already covers the needed diagnostics well, duplicating both creates confusion

---

## MATLAB: What the Plugin Actually Is

Important lesson:

- `matlab.nvim` is not a linter
- it is not an LSP
- it is a MATLAB workflow/CLI integration plugin

It is for things like:

- opening MATLAB CLI inside Neovim
- running lines, selections, and cells
- opening docs/help/workspace

Why this mattered:

- once that was understood, the right fix was not "configure a language server"
- the right fix was "make the CLI integration reliable"

Example test file created:

- `~/matlab_test.m`

Why this was useful:

- concrete proof that the integration worked
- especially for plots and cell execution

---

## Yazi: What the Neovim Plugin Actually Controls

Important distinction learned:

- `yazi.nvim` config controls the **Neovim bridge**
- Yazi's own config lives in Yazi config files, not the Neovim plugin file

So:

- `~/.config/nvim/lua/plugins/yazi.lua`
  - controls how Neovim launches and integrates Yazi
- `~/.config/yazi/...`
  - controls Yazi itself

Why this matters:

- otherwise it is easy to expect the Neovim plugin to handle theme/key behavior that actually belongs to Yazi proper

---

## Diagnostics vs Hover: Why `K` Did Not Show Errors

Problem:

- trying `K` for long error messages did not help

Reason:

- `K` is LSP hover
- diagnostics are a separate Neovim system

Correct LazyVim diagnostic keys:

- `<leader>cd` -> current line diagnostics float
- `[d` / `]d` -> previous/next diagnostic

Why this matters:

- hover answers "what is this symbol?"
- diagnostics answer "what is wrong here?"

---

## Why Some Things Should Stay Default

Repeated pattern discovered:

- if LazyVim already does something well, overriding it too early makes the config harder to learn

Examples:

- `which-key` -> better to learn default groups first
- comments -> default `ts-comments.nvim` was already enough
- diagnostics UI -> defaults were already good enough

Why this principle matters:

- every unnecessary override creates one more place to debug
- understanding the base system first makes future customization much easier

---

## Practical Current Map of the Setup

### Core local config files

- `~/.config/nvim/init.lua`
- `~/.config/nvim/lua/config/lazy.lua`
- `~/.config/nvim/lua/config/options.lua`
- `~/.config/nvim/lua/config/keymaps.lua`
- `~/.config/nvim/lua/config/autocmds.lua`

### Active local plugin files

- `~/.config/nvim/lua/plugins/snacks.lua`
- `~/.config/nvim/lua/plugins/codesnap.lua`
- `~/.config/nvim/lua/plugins/matlab.lua`
- `~/.config/nvim/lua/plugins/arduino-nvim.lua`
- `~/.config/nvim/lua/plugins/yazi.lua`
- `~/.config/nvim/lua/plugins/tmux-navigator.lua`
- `~/.config/nvim/lua/plugins/verible-lsp.lua`
- `~/.config/nvim/lua/plugins/blink-cmp.lua`
- `~/.config/nvim/lua/plugins/theme.lua` -> symlink to Omarchy
- `~/.config/nvim/lua/plugins/example.lua` -> inactive reference file

### Enabled LazyVim extras

- Markdown extra
- Python extra

### Big built-in LazyVim layers already doing heavy lifting

- `editor.lua`
- `coding.lua`
- `lsp/init.lua`
- `ui.lua`

---

## The Best Final Summary

The config makes the most sense when viewed as a funnel:

1. Neovim starts
2. `init.lua` loads `config.lazy`
3. `config.lazy` boots `lazy.nvim`
4. LazyVim core plugin specs load
5. selected LazyVim extras load
6. personal plugin files load last
7. local files only patch or extend the defaults that already exist

That is the real answer to "how does everything connect together?"

The connection chain is not random.

It is:

- **Neovim** provides the runtime
- **lazy.nvim** provides plugin management
- **LazyVim** provides defaults and architecture
- **local config** provides personal behavior only where needed

Whenever something felt confusing, the fix was usually one of these:

- remove a redundant override
- enable the correct LazyVim extra
- let the built-in LazyVim system handle the hard part
- add only a small local bridge where external context demanded it

That is the pattern worth keeping.

# LazyVim Internal Notes

## `lazyvim/plugins/editor.lua`

- This is a LazyVim-managed file inside `~/.local/share/nvim/lazy/LazyVim/...`.
- It is part of the upstream plugin, so editing it directly is a bad idea because
  updates can overwrite your comments and changes.
- These notes mirror the important ideas in that file in a safe place you own.

### What this file is

- `editor.lua` is one of LazyVim's built-in plugin-spec files.
- It returns a Lua table containing several plugin specs.
- Each spec describes one plugin: when it loads, which keys it defines, and
  which options it uses.
- Your own files in `~/.config/nvim/lua/plugins/` load after this and can
  override or extend these defaults.

### Plugin: `MagicDuck/grug-far.nvim`

- Purpose: project-wide search and replace.
- Main key: `<leader>sr`.
- LazyVim opens the UI with a smart default file filter based on the current
  file extension.
- Example: if you are in a Python file, it may prefill `*.py` so you search
  only Python files first.

### Plugin: `folke/flash.nvim`

- Purpose: fast visual jumping inside the current window.
- Keys:
  - `s` -> normal Flash jump
  - `S` -> Treesitter-aware jump
  - `r` -> remote jump in operator-pending mode
  - `R` -> Treesitter search motion
  - `<C-s>` in command mode -> toggle flash search behavior
- Treesitter-aware means it can jump by code structure, not just raw text.
- Operator-pending means you already started an action like `d`, `c`, or `y`
  and Neovim is waiting for the motion/target.

### Plugin: `folke/which-key.nvim`

- Purpose: show keybinding hints as you type prefixes.
- This is where many leader-key groups come from.
- Important built-in groups:
  - `<leader>c` -> code
  - `<leader>b` -> buffer
  - `<leader>g` -> git
  - `<leader>s` -> search
  - `<leader>u` -> UI
  - `<leader>w` -> windows
- This is why custom mappings should usually respect these namespaces.
- Example: buffer delete belongs more naturally under `<leader>b...` than under
  `<leader>c`.

### Plugin: `lewis6991/gitsigns.nvim`

- Purpose: show Git changes in the sign column and act on hunks.
- Navigation keys:
  - `]h` / `[h` -> next / previous hunk
  - `]H` / `[H` -> last / first hunk
- Action keys:
  - `<leader>ghs` -> stage hunk
  - `<leader>ghr` -> reset hunk
  - `<leader>ghb` -> blame line
  - `<leader>ghd` -> diff this
- There is also a LazyVim toggle on `<leader>uG` for turning git signs on/off.

### Plugin: `folke/trouble.nvim`

- Purpose: structured diagnostics/symbols/references list.
- Important keys:
  - `<leader>xx` -> diagnostics list
  - `<leader>xX` -> diagnostics for current buffer
  - `<leader>cs` -> symbols
  - `<leader>cS` -> LSP references/definitions/etc.
- This is another reason `<leader>c` is already a meaningful LazyVim prefix.

### Big picture

- `editor.lua` defines the default editing experience in LazyVim.
- Your config should usually extend these defaults instead of replacing them.
- When you remove one of your own override files, you usually "fall back" to
  the behavior defined here.

### Examples from your setup

- Deleting your `which-key.lua` means you now use the built-in `which-key`
  config from `editor.lua`.
- Re-enabling Flash means the `flash.nvim` spec in `editor.lua` is active again.
- Your earlier Snacks mapping on bare `<leader>c` conflicted conceptually with
  LazyVim because `editor.lua` already reserves `<leader>c` for code actions.

## `lazyvim/plugins/coding.lua`

- This is another LazyVim-managed internal file.
- It provides "coding helpers" rather than navigation/UI helpers.
- The main built-in plugins here are:
  - `mini.pairs`
  - `ts-comments.nvim`
  - `mini.ai`
  - `lazydev.nvim`

### Plugin: `nvim-mini/mini.pairs`

- Purpose: automatic bracket/quote pairing.
- Example:
  - typing `(` inserts `)`
  - typing `"` inserts another `"`
- LazyVim enables it in:
  - insert mode
  - command mode
- LazyVim disables it in terminal mode.
- It also adds smarter behavior so pairing is skipped in situations where it
  would be annoying or incorrect.

### Plugin: `folke/ts-comments.nvim`

- Purpose: smarter commenting based on Treesitter syntax context.
- This is why LazyVim already had a good built-in comment solution.
- It was the reason your old custom `comment.lua` file was redundant.
- In mixed-syntax files, this helps Neovim choose the correct comment style.

### Plugin: `nvim-mini/mini.ai`

- Purpose: better text objects.
- Text objects are things like `iw` (inner word) or `ap` (a paragraph).
- LazyVim adds structure-aware objects such as:
  - `af` / `if` for functions
  - `ac` / `ic` for classes
  - `ao` / `io` for blocks/conditionals/loops
  - `at` / `it` for tags
- This makes structural editing much more powerful.

### Plugin: `folke/lazydev.nvim`

- Purpose: improve Lua completion and type information when editing your Neovim
  configuration.
- It helps Lua understand APIs from:
  - `vim`
  - `LazyVim`
  - `Snacks`
  - `lazy.nvim`
  - `nvim-lspconfig`
- This is one reason editing your Neovim config feels smarter than plain Lua.

### Big picture

- `coding.lua` provides the default coding conveniences in LazyVim.
- Your config benefits from these even if you never configured them yourself.
- This file explains why you already had:
  - autopairs
  - a comment system
  - powerful text objects
  - better Lua editing support

## `lazyvim/plugins/lsp/init.lua`

- This is the core LazyVim LSP file.
- It handles:
  - diagnostics defaults
  - LSP keymaps
  - server configuration
  - Mason integration
  - inlay hints
  - code lens
  - folding support
- This is the main reason LSP "just works" in LazyVim.

### Main plugin: `neovim/nvim-lspconfig`

- Loads on `BufReadPre` and `BufNewFile` so LSP is ready when you open files.
- Depends on:
  - `mason.nvim`
  - `mason-lspconfig.nvim`
- The `opts` function returns one large LSP settings table.

### Diagnostics defaults

- LazyVim configures Neovim diagnostics with:
  - underline enabled
  - `update_in_insert = false`
  - virtual text enabled
  - severity sorting enabled
  - custom sign icons
- This is why your old custom diagnostics file was mostly redundant.

### Inlay hints, code lens, folds

- Inlay hints: enabled by default for most filetypes.
- Code lens: disabled by default.
- Folding from LSP: enabled by default when a server supports it.

### Server configuration model

- `servers = { ... }` is the central map of LSP server configs.
- `servers["*"]` acts like a shared default for all servers.
- Example shared defaults include:
  - common capabilities
  - the default LSP keymaps

### Important default LSP keymaps

- `gd` -> go to definition
- `gr` -> references
- `gI` -> go to implementation
- `gy` -> type definition
- `gD` -> declaration
- `K` -> hover
- `gK` -> signature help
- `<leader>ca` -> code action
- `<leader>cr` -> rename
- `<leader>co` -> organize imports (when supported)
- `<leader>cl` -> LSP info via Snacks picker

### Why your Verible LSP worked

- Your `verible-lsp.lua` adds a server under `opts.servers.verible`.
- LazyVim merges that into this base LSP system.
- Then this file decides whether Mason should manage it or Neovim should enable
  it directly.

### Mason integration

- LazyVim checks whether each configured server is known to Mason.
- If a server can use Mason and `mason ~= false`, LazyVim lets Mason install it.
- If `mason = false`, LazyVim configures and enables it directly.
- This is why your Verible config with `mason = false` worked with the system
  binary.

### Main Mason plugin block

- Separate plugin: `mason-org/mason.nvim`
- Provides the `:Mason` UI.
- Default tools ensured by LazyVim here include:
  - `stylua`
  - `shfmt`
- When Mason installs a tool successfully, LazyVim triggers a `FileType` event
  shortly afterward so newly installed language tooling can attach without a
  full restart.

### `lsp/keymaps.lua`

- LazyVim uses a helper file to register LSP keymaps cleanly.
- It can attach keymaps conditionally based on whether a connected server
  supports a given LSP method such as:
  - `definition`
  - `references`
  - `rename`
  - `codeAction`
- This is why some LSP mappings only appear when the current server supports
  them.

### Big picture

- `lsp/init.lua` is the foundation of LazyVim's language support.
- Your local LSP files usually should add server entries or small overrides,
  not rebuild the whole system.
- This file is the reason you can often just add one server spec and get:
  - diagnostics
  - keymaps
  - hover
  - references
  - rename
  - Mason install behavior

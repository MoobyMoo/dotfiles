-- Decide where the plugin manager should be installed.
-- `vim.fn.stdpath("data")` is Neovim's data folder, separate from your config.
-- On this machine that is usually ~/.local/share/nvim, so the full path becomes
-- ~/.local/share/nvim/lazy/lazy.nvim.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- Check whether lazy.nvim already exists at that path.
-- If it does not, clone it from GitHub so Neovim can use it.
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
-- Add lazy.nvim to Neovim's runtime path.
-- The runtime path is one of the places Neovim searches for plugins and Lua modules.
-- After this line, `require("lazy")` can find the lazy.nvim code we just installed.
vim.opt.rtp:prepend(lazypath)

-- Load the `lazy` module and call its `setup` function.
-- `setup({ ... })` receives one big Lua table that tells lazy.nvim:
--   1. which plugin specs to load
--   2. what default rules to use
--   3. a few extra behaviors like update checking and performance tuning
require("lazy").setup({
  spec = {
    -- `spec` is the list of plugin-spec sources.
    -- First load the LazyVim distribution and import its built-in plugin specs.
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- Then load any LazyVim extras you want to enable.
    { import = "lazyvim.plugins.extras.lang.markdown" },
    { import = "lazyvim.plugins.extras.lang.python" },
    -- Then import your own plugin specs from ~/.config/nvim/lua/plugins/*.lua.
    -- This is what makes files like lua/plugins/nvim-lint.lua matter.
    { import = "plugins" },
  },
  defaults = {
    -- `defaults` sets fallback rules for plugin specs unless a spec overrides them.
    -- `lazy = false` means your custom plugins load at startup by default.
    -- A plugin can still lazy-load itself by setting `event`, `ft`, `cmd`, etc.
    lazy = false,
    -- `version = false` means use the latest plugin commits instead of release tags.
    version = false,
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  -- `install` controls a few first-time install behaviors.
  -- Here it tells lazy.nvim which colorschemes it can fall back to during startup.
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = {
    -- `checker` lets lazy.nvim look for plugin updates in the background.
    enabled = true,
    -- Do not show popup notifications when updates are found.
    notify = false,
  },
  performance = {
    rtp = {
      -- `performance.rtp.disabled_plugins` disables some built-in Vim plugins.
      -- This keeps the runtime path a little smaller and can help startup time.
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

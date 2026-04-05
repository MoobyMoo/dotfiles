return {
  -- Community plugin that integrates the Yazi terminal file manager with Neovim.
  -- This file is your local config for that plugin.
  "mikavilpas/yazi.nvim",
  dependencies = {
    -- Small helper library used by many Neovim plugins.
    "nvim-lua/plenary.nvim",
  },
  -- Load later instead of during the earliest startup phase.
  event = "VeryLazy",
  init = function()
    -- `init` runs before the plugin is fully loaded.
    -- This is the right place for global settings that affect startup behavior.

    -- When Yazi is used for directories, disable netrw's directory plugin so it
    -- does not take over first.
    -- `netrw` is Neovim/Vim's built-in file browser.
    vim.g.loaded_netrwPlugin = 1
  end,
  keys = {
    {
      -- Press <leader>y to open Yazi manually at the current file/location.
      "<leader>y",
      function()
        -- Open Yazi on demand.
        -- `require("yazi")` loads the plugin's Lua module.
        -- `.yazi()` opens the Yazi UI.
        require("yazi").yazi()
      end,
      -- Used by which-key and similar tools to show what the mapping does.
      desc = "Open Yazi file manager",
    },
  },
  opts = {
    -- `opts` are passed to yazi.nvim's setup function by lazy.nvim.

    -- Automatically use Yazi when opening directories.
    -- If you open a directory in Neovim, Yazi will appear instead of netrw.
    open_for_directories = true,
    keymaps = {
      -- These are keymaps active inside the Yazi integration window itself.

      -- Show Yazi help from inside the integration.
      show_help = "g?",
    },
  },
}

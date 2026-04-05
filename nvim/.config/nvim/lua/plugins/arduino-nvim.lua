return {
  -- Community plugin that adds Arduino-specific Neovim support.
  -- This file is your local config for that plugin.
  "yuukiflow/Arduino-Nvim",
  dependencies = {
    -- Telescope is typically used for picker/selection UI by this plugin.
    "nvim-telescope/telescope.nvim",
    -- LSP support may be used by the plugin's Arduino tooling integration.
    "neovim/nvim-lspconfig",
  },
  config = function()
    -- When a buffer's filetype is `arduino`, load the plugin module.
    -- `require("Arduino-Nvim")` runs the plugin's Lua module so its Arduino
    -- behavior becomes available for that buffer type.
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "arduino",
      callback = function()
        require("Arduino-Nvim")
      end,
    })
    
    -- Tell Neovim that `.ino` files should use the `arduino` filetype.
    -- This is what causes the FileType autocmd above to fire for Arduino sketches.
    vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
      pattern = "*.ino",
      callback = function()
        vim.bo.filetype = "arduino"
      end,
    })
  end,
}

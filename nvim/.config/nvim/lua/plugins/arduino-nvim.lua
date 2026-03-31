return {
  "yuukiflow/Arduino-Nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "neovim/nvim-lspconfig",
  },
  config = function()
    -- Load Arduino plugin for .ino files
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "arduino",
      callback = function()
        require("Arduino-Nvim")
      end,
    })
    
    -- Set filetype to arduino for .ino files
    vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
      pattern = "*.ino",
      callback = function()
        vim.bo.filetype = "arduino"
      end,
    })
  end,
}

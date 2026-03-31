return {
  "VonHeikemen/fine-cmdline.nvim",
  lazy = false,
  dependencies = { "MunifTanjim/nui.nvim" },
  config = function()
    require("fine-cmdline").setup({
      cmdline = {
        enable_keymaps = true,
      },
    })
    
    -- Keybindings for fine-cmdline
    vim.keymap.set("n", ":", "<cmd>FineCmdline<CR>", { noremap = true })
  end,
}

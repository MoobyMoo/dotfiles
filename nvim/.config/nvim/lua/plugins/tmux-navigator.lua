-- Seamless navigation between Neovim and tmux
-- Maps Ctrl+h/j/k/l to navigate between Neovim windows and tmux panes
return {
  "christoomey/vim-tmux-navigator",
  event = "VeryLazy",
  config = function()
    -- Navigation keymaps for normal, insert, and terminal modes
    for _, mode in ipairs({ "n", "i", "t" }) do
      vim.keymap.set(mode, "<C-h>", "<cmd>TmuxNavigateLeft<cr>", { noremap = true, silent = true })
      vim.keymap.set(mode, "<C-j>", "<cmd>TmuxNavigateDown<cr>", { noremap = true, silent = true })
      vim.keymap.set(mode, "<C-k>", "<cmd>TmuxNavigateUp<cr>", { noremap = true, silent = true })
      vim.keymap.set(mode, "<C-l>", "<cmd>TmuxNavigateRight<cr>", { noremap = true, silent = true })
      vim.keymap.set(mode, "<C-\\>", "<cmd>TmuxNavigatePrevious<cr>", { noremap = true, silent = true })
    end
  end,
}

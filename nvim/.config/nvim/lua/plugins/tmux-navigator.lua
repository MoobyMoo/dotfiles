-- Seamless navigation between Neovim and tmux.
-- This file is your local config for the community plugin `vim-tmux-navigator`.
-- It lets the same movement keys work across both Neovim splits and tmux panes.
return {
  "christoomey/vim-tmux-navigator",
  -- Load later instead of during the earliest startup phase.
  event = "VeryLazy",
  config = function()
    -- Apply the same navigation keys in several modes:
    --   n = normal mode
    --   i = insert mode
    --   t = terminal mode
    -- This way Ctrl+h/j/k/l behaves consistently almost everywhere.
    for _, mode in ipairs({ "n", "i", "t" }) do
      -- Move left/right/up/down across Neovim windows and tmux panes.
      -- If there is no split in that direction, the plugin asks tmux to move instead.
      vim.keymap.set(mode, "<C-h>", "<cmd>TmuxNavigateLeft<cr>", { noremap = true, silent = true })
      vim.keymap.set(mode, "<C-j>", "<cmd>TmuxNavigateDown<cr>", { noremap = true, silent = true })
      vim.keymap.set(mode, "<C-k>", "<cmd>TmuxNavigateUp<cr>", { noremap = true, silent = true })
      vim.keymap.set(mode, "<C-l>", "<cmd>TmuxNavigateRight<cr>", { noremap = true, silent = true })
      -- Jump back to the previously focused pane/window.
      vim.keymap.set(mode, "<C-\\>", "<cmd>TmuxNavigatePrevious<cr>", { noremap = true, silent = true })
    end
  end,
}

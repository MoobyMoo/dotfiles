return {
  "mikavilpas/yazi.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  event = "VeryLazy",
  keys = {
    {
      "<leader>y",
      function()
        require("yazi").yazi()
      end,
      desc = "Open Yazi file manager",
    },
  },
  opts = {
    open_for_dir = false,
    keymaps = {
      show_help = "g?",
    },
  },
}

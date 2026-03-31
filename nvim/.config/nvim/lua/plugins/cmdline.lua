return {
  "VonHeikemen/fine-cmdline.nvim",
  lazy = false,
  dependencies = { "MunifTanjim/nui.nvim" },
  config = function()
    require("fine-cmdline").setup()
  end,
}

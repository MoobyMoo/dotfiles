return {
  {
    "mistricky/codesnap.nvim",
    build = "make",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("codesnap").setup({
        save_path = vim.fn.expand("~/Pictures/CodeSnap"),
        has_breadcrumbs = true,
        show_workspace = true,
        has_line_number = true,
      })
    end,
  },
}

return {
  {
    -- Community plugin that wires external language servers into Neovim.
    -- This is your local config file for that plugin, not the plugin itself.
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Use Verible's language server for Verilog/SystemVerilog navigation,
        -- hover, references, completion, and language-aware diagnostics.
        verible = {
          -- Use the already-installed system binary instead of asking Mason to manage it.
          mason = false,
          -- The default Verible config expects a git repo root.
          -- Many school/homework folders are not git repos, so fall back to the file's folder.
          root_dir = function(bufnr, on_dir)
            local fname = vim.api.nvim_buf_get_name(bufnr)
            local root = vim.fs.root(fname, ".git") or vim.fs.dirname(fname)
            -- Tell Neovim which directory Verible should treat as the project root.
            on_dir(root)
          end,
        },
      },
    },
  },
}

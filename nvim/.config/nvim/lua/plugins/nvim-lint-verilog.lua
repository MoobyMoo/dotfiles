return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  config = function()
    local lint = require("lint")

    -- Define iverilog linter for Verilog
    lint.linters_by_ft = {
      verilog = { "iverilog" },
      systemverilog = { "iverilog" },
    }

    -- Custom iverilog linter configuration
    local iverilog_linter = {
      cmd = "iverilog",
      stdin = false,
      append_fname = true,
      args = { "-g2009", "-Wall" },
      stream = "stderr",
      ignore_exitcode = true,
      parser = function(output, bufnr)
        local diagnostics = {}
        for line in output:gmatch("[^\r\n]+") do
          -- Parse iverilog output format: file.v:line: error/warning message
          local filename, lnum, severity, msg = line:match("([^:]+):(%d+):%s*(.-):%s*(.*)")
          if lnum then
            table.insert(diagnostics, {
              lnum = tonumber(lnum) - 1,
              col = 0,
              severity = severity:lower():gsub("error", vim.diagnostic.severity.ERROR):gsub("warning", vim.diagnostic.severity.WARN),
              message = msg,
              source = "iverilog",
            })
          end
        end
        return diagnostics
      end,
    }

    lint.linters.iverilog = iverilog_linter

    -- Auto-lint on save and text change
    vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "TextChanged", "InsertLeave" }, {
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}

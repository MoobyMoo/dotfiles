return {
  -- Community plugin that opens MATLAB CLI inside Neovim and sends commands to it.
  -- This is not a linter or LSP plugin; it is a MATLAB workflow/integration plugin.
  -- Useful commands provided by this setup:
  --   :MatlabCliOpen            -> open a MATLAB CLI split
  --   :MatlabCliRunLine         -> run the current line
  --   :MatlabCliRunSelection    -> run the current visual selection
  --   :MatlabCliRunCell         -> run the current %% cell
  --   :MatlabCliClear           -> send `clear;`
  --   :MatlabCliCancelOperation -> interrupt a running MATLAB command
  --   :MatlabHelp               -> help for word under cursor
  --   :MatlabDoc                -> documentation for word under cursor
  --   :MatlabOpenWorkspace      -> open MATLAB workspace window
  --   :MatlabOpenEditor         -> open current file in MATLAB GUI editor
  --   :MatlabCliAddPath         -> add current file's directory to MATLAB path
  "MIBismuth/matlab.nvim",
  -- Only load when editing MATLAB files.
  ft = { "matlab" },
  config = function()
    local matlab = require("matlab")

    matlab.setup({
      -- Use the system MATLAB executable that exists on this machine.
      matlab_dir = "/usr/bin/matlab",
    })

    local function close_matlab_terminal()
      local buf = vim.api.nvim_get_current_buf()
      local name = vim.api.nvim_buf_get_name(buf)
      if name:match("^term://") and name:find("/usr/bin/matlab", 1, true) then
        vim.cmd("bd!")
      end
    end

    vim.api.nvim_create_user_command("MatlabCliClose", close_matlab_terminal, {})

    -- Convenience keymaps for MATLAB terminal buffers.
    vim.api.nvim_create_autocmd("TermOpen", {
      pattern = "term://*matlab*",
      callback = function(args)
        local opts = { buffer = args.buf, silent = true, desc = "Close MATLAB terminal" }
        -- In terminal mode, Ctrl-q is the most reliable close shortcut.
        vim.keymap.set("t", "<C-q>", [[<C-\><C-n><cmd>MatlabCliClose<cr>]], opts)
        -- Keep a normal-mode mapping too after leaving terminal-input mode.
        vim.keymap.set("t", "<leader>mx", [[<C-\><C-n><cmd>MatlabCliClose<cr>]], opts)
        vim.keymap.set("n", "<leader>mx", "<cmd>MatlabCliClose<cr>", opts)
      end,
    })

    -- The upstream plugin expects `:MatlabCliOpen` to be run before commands
    -- like `:MatlabCliRunCell`. Add small wrappers so the CLI opens
    -- automatically the first time you try to run/help/doc from a MATLAB file.
    local function ensure_cli_open()
      if type(matlab._job_id) ~= "number" then
        matlab.matlab_cli_open()
      end
    end

    vim.api.nvim_create_user_command("MatlabCliRunLine", function()
      ensure_cli_open()
      matlab.matlab_cli_run_line()
    end, {})

    vim.api.nvim_create_user_command("MatlabCliRunSelection", function()
      ensure_cli_open()
      matlab.matlab_cli_run_selection()
    end, { range = true })

    vim.api.nvim_create_user_command("MatlabCliRunCell", function()
      ensure_cli_open()
      matlab.matlab_cli_run_cell()
    end, {})

    vim.api.nvim_create_user_command("MatlabHelp", function()
      ensure_cli_open()
      matlab.matlab_help()
    end, {})

    vim.api.nvim_create_user_command("MatlabDoc", function()
      ensure_cli_open()
      matlab.matlab_doc()
    end, {})
  end,
}

return {
  -- Community utility/UI plugin that bundles many small features.
  -- This file is your local config for Snacks, not the plugin itself.
  "folke/snacks.nvim",
  -- Load early because several UI features depend on it.
  priority = 1000,
  -- Start at launch instead of waiting for a lazy-load event.
  lazy = false,
  keys = {
    -- Buffer management shortcuts.
    -- A buffer is Neovim's in-memory version of an open file or text document.
    -- Deleting a buffer closes it in Neovim; it does not normally delete the file on disk.
    {
      "<leader>c",
      function()
        Snacks.bufdelete()
      end,
      desc = "Delete Buffer",
    },
    {
      "<leader>C",
      function()
        Snacks.bufdelete.other()
      end,
      desc = "Delete Other Buffers",
    },
    {
      "<leader>bo",
      function()
        Snacks.bufdelete.other()
      end,
      desc = "Delete Other Buffers",
    },
    {
      "<leader>bx",
      function()
        Snacks.bufdelete()
      end,
      desc = "Delete Buffer",
    },
    -- Notification and search/picker shortcuts.
    -- A picker is an interactive UI for searching/selecting files, text, help pages, commands, etc.
    -- `smart()` usually chooses a useful search mode automatically based on context.
    {
      "<leader>sn",
      function()
        Snacks.notifier.show_history()
      end,
      desc = "Notification History",
    },
    {
      "<leader>sf",
      function()
        Snacks.picker.smart()
      end,
      desc = "Smart Find",
    },
    {
      "<leader>ss",
      function()
        Snacks.picker.grep()
      end,
      desc = "Grep",
    },
    {
      "<leader>sg",
      function()
        -- Only works inside a Git repository because it asks Git for tracked files.
        Snacks.picker.git_files()
      end,
      desc = "Git Files",
    },
    {
      "<leader>?",
      function()
        Snacks.picker.help()
      end,
      desc = "Help",
    },
    {
      "<leader>:",
      function()
        Snacks.picker.commands()
      end,
      desc = "Commands",
    },
    {
      "<leader>/",
      function()
        Snacks.picker.grep()
      end,
      desc = "Grep",
    },
    -- Open a terminal rooted at the current file's directory.
    {
      "<C-/>",
      function()
        local cwd = vim.fn.expand("%:p:h") -- Get current file's directory
        Snacks.terminal(nil, { cwd = cwd })
      end,
      desc = "Toggle Terminal",
    },
    -- Misc workflow helpers.
    {
      "<leader>n",
      function()
        Snacks.notifier.show_history()
      end,
      desc = "Notifications",
    },
    {
      "<leader>z",
      function()
        -- Zen mode hides/reduces UI clutter for focused editing.
        Snacks.zen()
      end,
      desc = "Zen Mode",
    },
    {
      "<leader>Z",
      function()
        -- Zoom temporarily enlarges the current window/pane.
        Snacks.zen.zoom()
      end,
      desc = "Zoom",
    },
    {
      "<leader>.",
      function()
        -- A scratch buffer is a temporary note/sandbox buffer, not a normal project file.
        Snacks.scratch()
      end,
      desc = "Toggle Scratch Buffer",
    },
    {
      "<leader>S",
      function()
        Snacks.scratch.select()
      end,
      desc = "Select Scratch Buffer",
    },
    -- Git helpers.
    {
      "<leader>gg",
      function()
        Snacks.lazygit()
      end,
      desc = "Lazygit",
    },
    {
      "<leader>gb",
      function()
        Snacks.git.blame_line()
      end,
      desc = "Git Blame Line",
    },
    {
      "<leader>gB",
      function()
        Snacks.gitbrowse()
      end,
      desc = "Git Browse",
    },
  },
  opts = {
    -- Startup screen shown when Neovim opens without a file.
    dashboard = {
      enabled = true,
      sections = {
        {
          -- Run a terminal command inside the dashboard for a visual header.
          -- This is cosmetic: it shows Pokemon art on the startup screen.
          section = "terminal",
          cmd = "pokemon-colorscripts -n charizard -f mega-x --no-title; sleep .1",
          random = 10,
          pane = 1,
          indent = 4,
          height = 15,
        },
        -- Show key hints and startup timing below the header.
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
      },
    },
    -- Adjust behavior for very large files.
    -- Large files often disable expensive editor features to keep Neovim responsive.
    bigfile = { enabled = true },
    -- Use Snacks for the left gutter/status column.
    -- The status column is the left-side area that can show line numbers, signs, folds, etc.
    statuscolumn = { enabled = true },
    -- Notification popup UI.
    notifier = {
      enabled = true,
      -- Keep popup notifications readable without getting too large.
      width = { min = 40, max = 120 },
      height = { min = 1, max = 20 },
      -- Fancy style gives the notifications a more polished look.
      style = "fancy",
      margin = { top = 1, right = 1 },
      padding = true,
      -- High zindex helps notifications stay above other floating windows.
      zindex = 100,
    },
    -- Fuzzy picker/search UI.
    picker = {
      enabled = true,
      -- Let Snacks power generic selection prompts when plugins use `vim.ui.select`.
      ui_select = true,
    },
    -- Smooth scrolling animation support.
    scroll = {
      enabled = false,
    },
    -- Open repository URLs from the current file/selection.
    gitbrowse = { enabled = true },
    -- Embedded terminal settings.
    terminal = {
      enabled = true,
      -- Use fish for terminals opened through Snacks.
      shell = "fish",
    },
    -- Distraction-free editing modes.
    zen = { enabled = true },
    -- Git TUI integration.
    lazygit = { enabled = true },
    -- File explorer support.
    explorer = { enabled = true },
    -- Extra git helpers.
    git = { enabled = true },
    -- Temporary scratch buffers.
    scratch = { enabled = true },
    -- Misc animations used by Snacks.
    animate = { enabled = true },
  },
}

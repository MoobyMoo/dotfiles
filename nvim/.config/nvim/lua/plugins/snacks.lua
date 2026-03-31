return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  keys = {
    { "<leader>c", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
    { "<leader>C", function() Snacks.bufdelete.other() end, desc = "Delete Other Buffers" },
    { "<leader>bo", function() Snacks.bufdelete.other() end, desc = "Delete Other Buffers" },
    { "<leader>bx", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
    { "<leader>sn", function() Snacks.notifier.show_history() end, desc = "Notification History" },
    { "<leader>sf", function() Snacks.picker.smart() end, desc = "Smart Find" },
    { "<leader>ss", function() Snacks.picker.grep() end, desc = "Grep" },
    { "<leader>sg", function() Snacks.picker.git_files() end, desc = "Git Files" },
    { "<leader>?", function() Snacks.picker.help() end, desc = "Help" },
    { "<leader>:", function() Snacks.picker.commands() end, desc = "Commands" },
    { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
    { "<C-/>", function() Snacks.terminal() end, desc = "Toggle Terminal" },
    { "<leader>n", function() Snacks.notifier.show_history() end, desc = "Notifications" },
    { "<leader>z", function() Snacks.zen() end, desc = "Zen Mode" },
    { "<leader>Z", function() Snacks.zen.zoom() end, desc = "Zoom" },
    { "<leader>.", function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
    { "<leader>S", function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
    { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
    { "<leader>gb", function() Snacks.git.blame_line() end, desc = "Git Blame Line" },
    { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse" },
  },
  opts = {
    dashboard = {
      enabled = true,
      preset = {
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          { icon = " ", key = "s", desc = "Restore Session", action = ":lua require('persistence').load()" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
      sections = {
        { section = "header" },
        {
          section = "keys",
          gap = 1,
          padding = 1,
        },
        {
          icon = "󰰒 ",
          title = "Recent Files",
          section = "recent_files",
          indent = 2,
          padding = 1,
          limit = 5,
        },
        {
          icon = " ",
          title = "Projects",
          section = "projects",
          indent = 2,
          padding = 1,
          limit = 5,
        },
      },
    },
    -- Bigfile configuration
    bigfile = { enabled = true },
    -- Statuscolumn
    statuscolumn = { enabled = true },
    -- Notifier
    notifier = {
      enabled = true,
      width = { min = 40, max = 120 },
      height = { min = 1, max = 20 },
      style = "fancy",
      margin = { top = 1, right = 1 },
      padding = true,
      zindex = 100,
    },
    -- Picker
    picker = {
      enabled = true,
      ui_select = true,
    },
    -- Scrolling
    scroll = {
      enabled = false, -- Disable smooth scrolling animations
    },
    -- Git signs
    gitbrowse = { enabled = true },
    -- Terminal
    terminal = { enabled = true },
    -- Zen mode
    zen = { enabled = true },
    -- Lazygit
    lazygit = { enabled = true },
    -- Explorer
    explorer = { enabled = true },
    -- Git status
    git = { enabled = true },
    -- Scratch buffer
    scratch = { enabled = true },
    -- Animate
    animate = { enabled = true },
  },
}

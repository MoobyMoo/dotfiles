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
      sections = {
        {
          section = "terminal",
          cmd = "pokemon-colorscripts -n charizard -f mega-x --no-title; sleep .1",
          random = 10,
          pane = 1,
          indent = 4,
          height = 15,
        },
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
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
    terminal = {
      enabled = true,
      shell = "fish",
    },
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

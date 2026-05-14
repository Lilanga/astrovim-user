-- Consolidated snacks.nvim configuration for AstroNvim v6
-- Dashboard, picker, explorer, notifier, indent, scroll, zen, lazygit, image, words

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = function(_, opts)
    local dashboard_image = require("util.dashboard_image")

    return vim.tbl_deep_extend("force", opts, {
      -- Dashboard
      dashboard = {
        preset = {
          header = table.concat(dashboard_image.bat4, "\n"),
        },
        sections = {
          { section = "header", gap = 1, padding = 2 },
          { section = "keys", gap = 1, padding = 2 },
          {
            pane = 1,
            icon = " ",
            title = "Recent Files",
            section = "recent_files",
            indent = 2,
            padding = 1,
          },
          {
            pane = 1,
            icon = " ",
            title = "Projects",
            section = "projects",
            indent = 2,
            padding = 1,
          },
          {
            pane = 1,
            icon = " ",
            title = "Git Status",
            section = "terminal",
            enabled = function() return Snacks.git.get_root() ~= nil end,
            cmd = "git status --short --branch --renames",
            height = 5,
            padding = 1,
            ttl = 5 * 60,
            indent = 3,
          },
          { section = "startup", gap = 1, padding = 2 },
        },
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          {
            icon = " ",
            key = "g",
            desc = "Find Text",
            action = ":lua Snacks.dashboard.pick('live_grep')",
          },
          {
            icon = " ",
            key = "r",
            desc = "Recent Files",
            action = ":lua Snacks.dashboard.pick('oldfiles')",
          },
          {
            icon = " ",
            key = "c",
            desc = "Config",
            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
          },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          {
            icon = " ",
            key = "L",
            desc = "Lazy",
            action = ":Lazy",
            enabled = package.loaded.lazy ~= nil,
          },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },

      -- Notifier
      notifier = {
        enabled = true,
        timeout = 3000,
      },

      -- Indent guides (replaces indent-blankline)
      indent = {
        enabled = true,
        char = "▏",
        scope = { enabled = true },
      },

      -- Smooth scroll (replaces neoscroll)
      scroll = {
        enabled = true,
        animate = {
          duration = { step = 15, total = 150 },
        },
      },

      -- Zen mode (replaces zen-mode.nvim)
      zen = {
        enabled = true,
      },

      -- Dim inactive code (replaces twilight.nvim)
      dim = {
        enabled = true,
      },

      -- Word/reference highlighting (replaces vim-illuminate)
      words = {
        enabled = true,
      },

      -- Input UI
      input = {
        enabled = true,
      },

      -- Status column
      statuscolumn = {
        enabled = true,
      },

      -- Git integration
      git = {
        enabled = true,
      },
      gitbrowse = {
        enabled = true,
      },
      lazygit = {
        enabled = true,
      },

      -- Image support (nice-to-have)
      image = {
        enabled = true,
      },
    })
  end,
  keys = {
    -- Git blame
    {
      "<Leader>gb",
      function() Snacks.git.blame_line() end,
      desc = "Show Git Blame for Current Line",
    },
    {
      "<Leader>gB",
      function() Snacks.git.blame() end,
      desc = "Show Git Blame for File",
    },
    {
      "<Leader>go",
      function() Snacks.gitbrowse() end,
      desc = "Open in Git Browser",
    },
    -- Lazygit
    {
      "<Leader>gg",
      function() Snacks.lazygit() end,
      desc = "Lazygit",
    },
    -- Zen mode
    {
      "<Leader>uz",
      function() Snacks.zen() end,
      desc = "Zen Mode",
    },
    -- Notifications
    {
      "<Leader>un",
      function() Snacks.notifier.show_history() end,
      desc = "Notification History",
    },
    {
      "<Leader>uN",
      function() Snacks.notifier.hide() end,
      desc = "Dismiss All Notifications",
    },
  },
}

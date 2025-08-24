return {
  "folke/snacks.nvim",
  event = "VimEnter",
  priority = 1000,
  opts = function(_, opts)
    local dashboard_image = require("util.dashboard_image")

    -- Ensure dashboard exists in opts
    if not opts.dashboard then opts.dashboard = {} end

    -- Set the header using preset
    opts.dashboard.preset = {
      header = table.concat(dashboard_image.bat4, "\n"),
    }

    -- Header spanning full width, then equally split panes below
    opts.dashboard.sections = {
      -- Header at the top covering both panes
      { section = "header", gap = 1, padding = 2 },

      -- Left pane: Keys and startup (pane 1)
      { section = "keys", gap = 1, padding = 2 },
      { pane = 1, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
      { pane = 1, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
      {
        pane = 1,
        icon = " ",
        title = "Git Status",
        section = "terminal",
        enabled = function()
          return Snacks.git.get_root() ~= nil
        end,
        cmd = "git status --short --branch --renames",
        height = 5,
        padding = 1,
        ttl = 5 * 60,
        indent = 3,
      },
      { section = "startup", gap = 1, padding = 2 },

    }

    -- Set up keys for the dashboard
    opts.dashboard.keys = {
      { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
      { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
      { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
      { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
      { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
      { icon = " ", key = "s", desc = "Restore Session", section = "session" },
      { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
      { icon = " ", key = "q", desc = "Quit", action = ":qa" },
    }
    return opts
  end,
}

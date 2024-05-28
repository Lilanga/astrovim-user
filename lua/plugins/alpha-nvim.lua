return {
    "goolord/alpha-nvim",
    enabled = true,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = "VimEnter",
    lazy = true,
    config = function ()
        local dashboard = require "alpha.themes.dashboard"
        -- dashboard.opts.opts.noautocmd = true
        dashboard.section.header.val = require "util.dashboard_image".bat4
      require "alpha".setup(dashboard.opts)
    end
  }
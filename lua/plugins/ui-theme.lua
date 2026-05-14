-- Consolidated theme configuration for AstroNvim v6
-- TokyoNight (primary), Catppuccin (alternate), Rose Pine (calm)

return {
  -- TokyoNight - Primary theme
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "storm",
      transparent = true,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = false },
        functions = { bold = true },
        variables = {},
        sidebars = "transparent",
        floats = "transparent",
      },
      sidebars = { "qf", "help", "vista_kind", "terminal", "packer", "neo-tree" },
      day_brightness = 0.3,
      hide_inactive_statusline = false,
      dim_inactive = true,
      lualine_bold = false,
      on_highlights = function(hl, c)
        hl.RainbowDelimiterRed = { fg = c.red }
        hl.RainbowDelimiterYellow = { fg = c.yellow }
        hl.RainbowDelimiterBlue = { fg = c.blue }
        hl.RainbowDelimiterOrange = { fg = c.orange }
        hl.RainbowDelimiterGreen = { fg = c.green }
        hl.RainbowDelimiterViolet = { fg = c.purple }
        hl.RainbowDelimiterCyan = { fg = c.cyan }
      end,
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd.colorscheme("tokyonight-storm")
    end,
  },

  -- Catppuccin - Alternate theme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    opts = {
      flavour = "mocha",
      transparent_background = true,
      integrations = {
        aerial = true,
        gitsigns = true,
        mason = true,
        neotree = true,
        noice = true,
        notify = true,
        snacks = true,
        telescope = { enabled = true },
        treesitter = true,
        which_key = true,
      },
    },
  },

  -- Rose Pine - Calm writing theme
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = true,
    opts = {
      dark_variant = "moon",
      disable_italics = true,
      disable_float_background = true,
      highlight_groups = {
        RainbowDelimiterRed = { fg = "love" },
        RainbowDelimiterBlue = { fg = "foam" },
        RainbowDelimiterCyan = { fg = "rose" },
        RainbowDelimiterGreen = { fg = "pine" },
        RainbowDelimiterOrange = { fg = "#CAE7A7" },
        RainbowDelimiterViolet = { fg = "iris" },
        RainbowDelimiterYellow = { fg = "gold" },
        StatusNormal = { fg = "surface", bg = "rose" },
        StatusInsert = { fg = "surface", bg = "foam" },
        StatusVisual = { fg = "surface", bg = "iris" },
        StatusReplace = { fg = "surface", bg = "love" },
        StatusCommand = { fg = "surface", bg = "gold" },
      },
    },
  },

  -- Kanagawa - Beautiful darker theme
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    opts = {
      theme = "dragon",
      transparent = true,
    },
  },
}

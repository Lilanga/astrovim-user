return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("tokyonight").setup({
      style = "storm",                     -- The theme comes in three styles, `storm`, a darker variant `night` and `day`
      transparent = true,                  -- Enable this to disable setting the background color
      terminal_colors = true,              -- Configure the colors used when opening a `:terminal` in Neovim
      styles = {
        -- Style to be applied to different syntax groups
        -- Value is any valid attr-list value `:help attr-list`
        comments = { italic = true },
        keywords = { italic = false },
        functions = { bold = true },
        variables = {},
        -- Background styles. Can be "dark", "transparent" or "normal"
        sidebars = "transparent",          -- style for sidebars, see below
        floats = "transparent",            -- style for floating windows
      },
      sidebars = { "qf", "help", "vista_kind", "terminal", "packer", "neo-tree" }, -- Set a darker background on sidebar-like windows
      day_brightness = 0.3,                -- Adjusts the brightness of the colors of the **Day** style
      hide_inactive_statusline = false,    -- Enabling this option, will hide inactive statuslines
      dim_inactive = true,                 -- dims inactive windows
      lualine_bold = false,               -- When `true`, section headers in the lualine theme will be bold
      on_highlights = function(hl, c)
        -- Fix for rainbow delimiters
        hl.RainbowDelimiterRed = { fg = c.red }
        hl.RainbowDelimiterYellow = { fg = c.yellow }
        hl.RainbowDelimiterBlue = { fg = c.blue }
        hl.RainbowDelimiterOrange = { fg = c.orange }
        hl.RainbowDelimiterGreen = { fg = c.green }
        hl.RainbowDelimiterViolet = { fg = c.purple }
        hl.RainbowDelimiterCyan = { fg = c.cyan }
      end,
    })
    
    -- Load the colorscheme
    vim.cmd.colorscheme("tokyonight-storm")
  end,
}

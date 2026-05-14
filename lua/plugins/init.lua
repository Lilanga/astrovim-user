-- General plugins for AstroNvim v6

return {
  ------ Disabled plugins ------
  { "Exafunction/codeium.nvim", enabled = false },
  { "Exafunction/codeium.vim", enabled = false },

  ------ Visuals ------
  {
    "wsdjeg/vim-fetch",
    lazy = false,
  },

  {
    "gen740/SmoothCursor.nvim",
    lazy = false,
    opts = {
      type = "exp",
      autostart = true,
      fancy = {
        enable = true,
        head = { cursor = "", texthl = "SmoothCursor", linehl = nil },
      },
    },
  },

  {
    "zbirenbaum/neodim",
    event = "VeryLazy",
    opts = {
      alpha = 0.75,
    },
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "modern",
      delay = 200,
      notify = false,
      win = {
        border = "rounded",
        padding = { 1, 2 },
        title = true,
        title_pos = "center",
        zindex = 1000,
      },
      layout = {
        width = { min = 20 },
        spacing = 3,
      },
      sort = { "local", "order", "group", "alphanum", "mod" },
      icons = {
        breadcrumb = "»",
        separator = "➜",
        group = "+",
        ellipsis = "…",
        mappings = true,
        colors = true,
        keys = {
          Up = " ",
          Down = " ",
          Left = " ",
          Right = " ",
          C = "󰘴 ",
          M = "󰘵 ",
          D = "󰘳 ",
          S = "󰘶 ",
          CR = "󰌑 ",
          Esc = "󱊷 ",
          ScrollWheelDown = "󱕐 ",
          ScrollWheelUp = "󱕑 ",
          NL = "󰌑 ",
          BS = "󰁮",
          Space = "󱁐 ",
          Tab = "󰌒 ",
          F1 = "󱊫",
          F2 = "󱊬",
          F3 = "󱊭",
          F4 = "󱊮",
          F5 = "󱊯",
          F6 = "󱊰",
          F7 = "󱊱",
          F8 = "󱊲",
          F9 = "󱊳",
          F10 = "󱊴",
          F11 = "󱊵",
          F12 = "󱊶",
        },
      },
      show_help = true,
      show_keys = true,
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.add({
        { "<Leader>b", group = "Buffer" },
        { "<Leader>d", group = "Debug" },
        { "<Leader>f", group = "Find" },
        { "<Leader>g", group = "Git" },
        { "<Leader>l", group = "LSP" },
        { "<Leader>t", group = "Terminal" },
        { "<Leader>u", group = "UI" },
        { "<Leader>x", group = "Diagnostics" },
        { "<Leader>r", group = "Replace" },
        { "<Leader>s", group = "Search" },
        { "<Leader>a", group = "AI" },
      })
    end,
  },

  ------ Movement ------
  {
    "jinh0/eyeliner.nvim",
    lazy = false,
    opts = {
      highlight_on_key = true,
      dim = true,
    },
  },

  ------ Functionality ------

  -- Aerial for symbol navigation
  {
    "stevearc/aerial.nvim",
    cmd = { "AerialToggle", "AerialOpen", "AerialNavToggle" },
    opts = {
      attach_mode = "window",
      backends = { "lsp", "treesitter", "markdown", "man" },
      layout = { min_width = 28 },
      show_guides = true,
      filter_kind = false,
      guides = {
        mid_item = "├ ",
        last_item = "└ ",
        nested_top = "│ ",
        whitespace = "  ",
      },
      keymaps = {
        ["[y"] = "actions.prev",
        ["]y"] = "actions.next",
        ["[Y"] = "actions.prev_up",
        ["]Y"] = "actions.next_up",
        ["{"] = false,
        ["}"] = false,
      },
    },
  },

  -- Trouble diagnostics panel (configured via astrocommunity)
  { "folke/trouble.nvim" },

  -- Cheatsheet
  {
    "sudormrfbin/cheatsheet.nvim",
    cmd = { "Cheatsheet", "CheatsheetEdit" },
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
    },
  },

  { "gennaro-tedesco/nvim-jqx" },

  ------ Renaming ------
  { "windwp/nvim-spectre" },

  {
    "cshuaimin/ssr.nvim",
    keys = {
      {
        "<Leader>sr",
        function() require("ssr").open() end,
        mode = { "n", "x" },
        desc = "Structural Replace",
      },
    },
    opts = {
      min_width = 50,
      min_height = 5,
      keymaps = {
        close = "q",
        next_match = "n",
        prev_match = "N",
        replace_all = "<leader><cr>",
      },
    },
  },

  ------ Text Manipulation ------
  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    config = function() require("mini.ai").setup() end,
  },

  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {
      keymaps = {
        normal = "sa",
        normal_cur = "sv",
        normal_line = "ss",
        normal_curl_line = "sS",
        visual = "s",
        delete = "sd",
        change = "sr",
      },
      aliases = {
        ["u"] = { "}", "]", ")", ">", '"', "'", "`" },
      },
    },
  },

  ------ Lua / Neovim dev ------
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
  { "Bilal2453/luvit-meta", lazy = true },

  ------ User plugins ------
  "andweeb/presence.nvim",
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },

  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require("luasnip").setup(opts)
      local luasnip = require("luasnip")
      luasnip.filetype_extend("javascript", { "javascriptreact" })
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require("nvim-autopairs").setup(opts)
      local npairs = require("nvim-autopairs")
      local Rule = require("nvim-autopairs.rule")
      local cond = require("nvim-autopairs.conds")
      npairs.add_rules({
        Rule("$", "$", { "tex", "latex" })
          :with_pair(cond.not_after_regex("%%"))
          :with_pair(cond.not_before_regex("xxx", 3))
          :with_move(cond.none())
          :with_del(cond.not_after_regex("xx"))
          :with_cr(cond.none()),
        Rule("a", "a", "-vim"),
      })
    end,
  },
}

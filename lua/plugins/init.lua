return {
  ------ disable ------
  ---------------------
  { "jay-babu/mason-nvim-dap.nvim", enabled = false },
  { "uga-rosa/ccc.nvim",            enabled = false }, -- Disable due to LSP buffer handling issues

  ------ Visuals ------
  ---------------------

  {
    "wsdjeg/vim-fetch",
    lazy = false,
  },

  {
    "nyoom-engineering/oxocarbon.nvim",
    -- lazy = false,
  },

  {
    "kvrohit/mellow.nvim",
    -- lazy = false,
  },

  {
    "gen740/SmoothCursor.nvim",
    -- cond = vim.g.neovide == nil,
    lazy = false,
    opts = {
      type = "exp",
      autostart = true,
      fancy = {
        enable = true,
        head = { cursor = "", texthl = "SmoothCursor", linehl = nil, },
      },
    },
  },

  {
    "zbirenbaum/neodim",
    event = "User AstroFile",
    opts = {
      alpha = 0.75,
    },
  },

  {
    "folke/todo-comments.nvim",
    event = "User AstroFile",
    config = true,
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      local wk = require("which-key")
      
      -- Configure which-key with v3 compatible settings
      wk.setup({
        preset = "modern",
        delay = 200,
        expand = 1,
        notify = false,
        triggers = {
          { "<auto>", mode = "nixsotc" },
          { "<leader>", mode = { "n", "v" } },
        },
        win = {
          border = "rounded",
          padding = { 1, 2 }, -- extra window padding [top/bottom, left/right]
          title = true,
          title_pos = "center",
          zindex = 1000,
          -- Remove winblend from win config - it's not supported in v3
        },
        layout = {
          width = { min = 20 },
          spacing = 3,
        },
        keys = {
          scroll_down = "<c-d>",
          scroll_up = "<c-u>",
        },
        sort = { "local", "order", "group", "alphanum", "mod" },
        expand = 0,
        replace = {
          key = {
            function(key)
              return require("which-key.view").format(key)
            end,
          },
        },
        icons = {
          breadcrumb = "»",
          separator = "➜",
          group = "+",
          ellipsis = "…",
          mappings = true,
          rules = {},
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
        disable = {
          bt = {},
          ft = {},
        },
      })
      
      -- Register key groups
      wk.add({
        { "<leader>b", group = "Buffer" },
        { "<leader>f", group = "Find" },
        { "<leader>g", group = "Git" },
        { "<leader>l", group = "LSP" },
        { "<leader>t", group = "Terminal" },
        { "<leader>u", group = "UI" },
        { "<leader>x", group = "Diagnostics" },
        { "<leader>r", group = "Replace" },
        { "<leader>s", group = "Search" },
      })
    end,
  },

  ------ movement ------
  ----------------------

  {
    "jinh0/eyeliner.nvim",
    -- enabled = false,
    lazy = false,
    opts = {
      highlight_on_key = true,
      dim = true,
    },
  },

  {
    "TheSafdarAwan/find-extender.nvim",
    enabled = false,
    keys = { "f", "F", "F", "T", "t", "t", "T" },
    config = true,
  },

  --- Functionality ---
  ---------------------
  {
    "folke/twilight.nvim",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
  -- Org mode
  {
    "nvim-orgmode/orgmode",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter", lazy = true },
    },
    event = "VeryLazy",
    ft = { "org" },
    config = function()
      -- Setup orgmode
      require("orgmode").setup {
        org_agenda_files = "~/orgfiles/**/*",
        org_default_notes_file = "~/orgfiles/refile.org",
      }
    end,
  },
  -- Replaced tagbar with aerial.nvim for better LSP integration
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

  { "folke/trouble.nvim" },

  -- plenary.nvim is already included as a dependency by other plugins

  -- dressing.nvim is now handled by snacks.nvim in AstroNvim v5

  -- Replaced nvim-cheat.sh with cheatsheet.nvim for better compatibility
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

  -- Renaming --
  --------------
  { "windwp/nvim-spectre" },

  -- Structual Search and Replace
  {
    "cshuaimin/ssr.nvim",
    keys = {
      {
        "<leader>sr",
        function() require("ssr").open() end,
        mode = { "n", "x" },
        desc = "Structural Replace"
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

  -- Text Manipulation --
  -----------------------

  {
    "echasnovski/mini.ai",
    event = "User AstroFile",
    config = function() require("mini.ai").setup() end,
  },

  {
    "kylechui/nvim-surround",
    event = "User AstroFile",
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

  ------ git ------
  -----------------
  -- diffview.nvim is now imported from astrocommunity

  --- Languages ---
  -----------------
  {
    "QuickGD/quickgd.nvim",
    -- dev = true,
    ft = "gdshader",
    cmd = {
      "GodotRun",
      "GodotRunLast",
      "GodotStart",
    },
    config = function()
      local quickgd = require "quickgd"
      quickgd.setup()
      quickgd.treesitter()
      quickgd.cmp()
    end,
  },

  -- neodev.nvim is deprecated, use lazydev.nvim instead
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
  { "Bilal2453/luvit-meta", lazy = true },

  { "sbdchd/neoformat" },

  ------ fun ------
  -----------------


  -- Icons are now handled by mini.icons in AstroNvim v5
  -- See lua/plugins/webdevicons.lua for the configuration
}

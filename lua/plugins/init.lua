return {
  ------ disable ------
  ---------------------
  { "jay-babu/mason-nvim-dap.nvim", enabled = false },

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
    opts = function(_, opts)
      return require("astrocore").extend_tbl(opts, {
        window = {
          winblend = vim.g.winblend,
        },
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
    config = function()
      -- Load treesitter grammar for org
      require("orgmode").setup_ts_grammar()

      -- Setup treesitter
      require("nvim-treesitter.configs").setup {
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = { "org" },
        },
        ensure_installed = { "org" },
      }

      -- Setup orgmode
      require("orgmode").setup {
        org_agenda_files = "~/orgfiles/**/*",
        org_default_notes_file = "~/orgfiles/refile.org",
      }
    end,
  },
  -- tagbar, needs ctags to work.
  {
    "preservim/tagbar",
    cmd = "TagbarToggle",
  },

  { "folke/trouble.nvim" },

  { "nvim-lua/plenary.nvim" },

  -- {
  --   'stevearc/dressing.nvim',
  --   opts = {},
  -- },

  {
    "RishabhRD/nvim-cheat.sh",
    dependencies = {
      "RishabhRD/popfix",
    },
  },

  { "gennaro-tedesco/nvim-jqx" },

  -- Renaming --
  --------------
  { "windwp/nvim-spectre" },

  -- Structual Search and Replace
  {
    "cshuaimin/ssr.nvim",
    ft = "<leader>r",
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

  {
    "sindrets/diffview.nvim",
    event = "User AstroGitFile",
  },

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

  { "folke/neodev.nvim" },

  { "sbdchd/neoformat" },

  ------ fun ------
  -----------------


  ------- icons -------
  ---------------------
  {
    "nvim-tree/nvim-web-devicons",
    dependencies = { "DaikyXendo/nvim-material-icon" },
    config = function()
      require("nvim-web-devicons").setup {
        override = require("nvim-material-icon").get_icons(),
      }
    end,
  },
}

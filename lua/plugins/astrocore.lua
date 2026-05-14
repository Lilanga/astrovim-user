-- AstroCore configuration for AstroNvim v6
-- Options, diagnostics, keymaps, and autocmds

local function is_windows()
  return vim.fn.has("win32") == 1
end

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    features = {
      diagnostics = true,
    },
    diagnostics = {
      virtual_text = true,
      virtual_lines = { current_line = true },
      underline = true,
      update_in_insert = false,
      severity_sort = true,
    },
    options = {
      opt = {
        termguicolors = true,
        cursorline = true,
        number = true,
        relativenumber = true,
        signcolumn = "yes",
        splitbelow = true,
        splitright = true,
        winborder = "rounded",
        pumblend = 8,
        winblend = 0,
        autoread = true,
        winwidth = 10,
        winminwidth = 10,
        equalalways = true,
      },
      g = {
        heirline_bufferline = true,
        neovide_cursor_vfx_mode = "railgun",
        neovide_cursor_vfx_particle_lifetime = 1.5,
        neovide_cursor_vfx_particle_density = 15,
        neovide_transparency = 0.9,
      },
    },
    -- Shell configuration for Windows
    autocmds = {
      powershell_setup = is_windows() and {
        {
          event = "VimEnter",
          callback = function()
            vim.o.shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell"
            vim.o.shellcmdflag =
              "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
            vim.o.shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait"
            vim.o.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
            vim.o.shellquote = ""
            vim.o.shellxquote = ""
          end,
          desc = "Configure PowerShell as default shell on Windows",
        },
      } or nil,
      neovide_setup = {
        {
          event = "VimEnter",
          callback = function()
            if vim.g.neovide then
              vim.o.winblend = 30
              vim.cmd("hi! NormalFloat blend=" .. vim.o.winblend)
              vim.opt.guifont =
                "VictorMono Nerd Font,Hack Nerd Font:h12:#e-subpixelantialias:antialias=1:autohint=0"
              vim.o.pumblend = 30
            end
          end,
          desc = "Configure Neovide settings",
        },
      },
    },
    mappings = {
      n = {
        -- Disable default keymaps
        ["gh"] = false,
        ["s"] = false,
        ["Q"] = false,

        -- AI Assistant group
        ["<Leader>A"] = { desc = " AI Assistant" },
        ["<Leader>Ac"] = { desc = " Copilot" },
        ["<Leader>Ace"] = { "<cmd>Copilot enable<cr>", desc = "Enable Copilot" },
        ["<Leader>Acd"] = { "<cmd>Copilot disable<cr>", desc = "Disable Copilot" },
        ["<Leader>Acs"] = { "<cmd>Copilot status<cr>", desc = "Copilot Status" },

        -- Movement
        ["<M-o>"] = { "o<ESC>", desc = "Insert line below and exit insert" },
        ["<M-O>"] = { "O<ESC>", desc = "Insert line above and exit insert" },
        ["<C-d>"] = { "<C-d>zz", desc = "Page down and center" },
        ["<C-u>"] = { "<C-u>zz", desc = "Page up and center" },

        -- Telescope / Picker
        ["<C-p>"] = { "<cmd>Telescope fd<CR>", desc = "Find files" },
        ["<C-S-p>"] = { "<cmd>Telescope commands<CR>", desc = "Commands" },
        ["<C-f>"] = { "<cmd>Telescope live_grep<CR>", desc = "Live grep" },

        -- Trouble diagnostics
        ["<Leader>xx"] = { "<cmd>Trouble diagnostics toggle<CR>", desc = "Toggle Trouble" },
        ["<Leader>xw"] = { "<cmd>Trouble diagnostics toggle<CR>", desc = "Workspace diagnostics" },
        ["<Leader>xd"] = {
          "<cmd>Trouble diagnostics toggle filter.buf=0<CR>",
          desc = "Document diagnostics",
        },
        ["<Leader>xq"] = { "<cmd>Trouble qflist toggle<CR>", desc = "Quickfix list" },
        ["<Leader>xl"] = { "<cmd>Trouble loclist toggle<CR>", desc = "Location list" },
        ["<Leader>xr"] = { "<cmd>Trouble lsp_references toggle<CR>", desc = "LSP references" },

        -- Zen mode (snacks.zen)
        ["<Leader>n"] = {
          function() Snacks.zen() end,
          desc = "Zen Mode",
        },

        -- Tools
        ["<Leader>u1"] = { "<cmd>AerialToggle<CR>", desc = "Toggle Aerial" },
        ["<Leader>u2"] = { "<cmd>Trouble diagnostics toggle<CR>", desc = "Toggle Trouble" },

        -- Grapple
        ["gt"] = { ":GrappleToggle<cr>", desc = "Grapple toggle" },
        ["gp"] = { ":GrapplePopup tags<cr>", desc = "Grapple popup" },

        -- Renaming
        ["yrw"] = { "yiw:s/\\C\\<<C-R>0\\>/", desc = "Rename word" },
        ["yrW"] = { "yiW:s/\\C\\<<C-R>0\\>/", desc = "Rename WORD" },
        ["yre"] = { "yie:s/\\C\\<<C-R>0\\>/", desc = "Rename entire word" },
        ["yrE"] = { "yiE:s/\\C\\<<C-R>0\\>/", desc = "Rename entire WORD" },
        ["<F2>"] = { "y:%s/<C-R>0/", desc = "Global replace" },
        ["<F2><F2>"] = { "y:%s/<C-R>0/", desc = "Global replace" },

        -- Spectre / SSR
        ["<F3>"] = { "<cmd>lua require('spectre').open()<cr>", desc = "Open Spectre" },
        ["<F3><F3>"] = {
          "<cmd>lua require('spectre').open_visual({select_word=true})<CR>",
          desc = "Open Spectre with word",
        },
        ["<Leader>r"] = {
          function() require("ssr").open() end,
          desc = "Structural Search Replace",
        },

        -- TreeSJ
        ["sj"] = { "<cmd>TSJToggle<CR>", desc = "TreeSJ toggle" },
      },
      v = {
        ["r"] = { "y:s/\\C\\<<C-R>0\\>/", desc = "Replace selection" },
        ["<F2>"] = { "'<'>%s/\\C<C-R>0/", desc = "Replace in selection" },
        ["<F2><F2>"] = { "'<'>s/\\C<C-R>0/", desc = "Replace in selection (single)" },
        ["<Leader>r"] = {
          function() require("ssr").open() end,
          desc = "Structural Search Replace",
        },
      },
      i = {
        ["<M-o>"] = { "<C-o>o", desc = "Insert line below" },
        ["<M-O>"] = { "<C-o>O", desc = "Insert line above" },
        ["<M-l>"] = { "<cmd>><cr>", desc = "Indent" },
        ["<M-h>"] = { "<cmd><<cr>", desc = "Unindent" },
      },
    },
  },
}

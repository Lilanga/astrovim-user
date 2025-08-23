-- Custom keymaps for AstroNvim v5
-- This creates a virtual plugin that sets up keymaps without trying to install anything

return {
  {
    dir = vim.fn.stdpath("config"), -- Use config directory as fake plugin directory
    name = "custom-keymaps",
    lazy = false,
    priority = 1000, -- Load early
    config = function()
      local macro = require "util.macro"
      local buffer = require "util.buffer"

      local function notify(msg, level)
        vim.notify(msg, level or vim.log.levels.INFO)
      end

      local map = vim.keymap.set

      -- Disable keymaps
      map("n", "gh", "<nop>")
      map("n", "s", "<nop>")
      map("n", "Q", "<nop>")

      -- Movement
      map("n", "<M-o>", "o<ESC>", { desc = "Insert line below and exit insert" })
      map("n", "<M-O>", "O<ESC>", { desc = "Insert line above and exit insert" })
      map("n", "<C-d>", "<C-d>zz", { desc = "Page down and center" })
      map("n", "<C-u>", "<C-u>zz", { desc = "Page up and center" })
      map("n", "n", macro.better_search "n", { desc = "Next search with center and unfold" })
      map("n", "N", macro.better_search "N", { desc = "Previous search with center and unfold" })

      -- Buffer navigation
      map("n", "<S-l>", function() buffer.nav(vim.v.count > 0 and vim.v.count or 1) end, { desc = "Next buffer" })
      map("n", "<S-h>", function() buffer.nav(-(vim.v.count > 0 and vim.v.count or 1)) end, { desc = "Previous buffer" })
      map("n", "<M-l>", function() buffer.nav(vim.v.count > 0 and vim.v.count or 1) end, { desc = "Move buffer right" })
      map("n", "<M-h>", function() buffer.nav(-(vim.v.count > 0 and vim.v.count or 1)) end, { desc = "Move buffer left" })

      -- Buffer switching with Telescope
      map("n", "<Tab>", function()
        local bufs = buffer.get_valid_buffers()
        if #bufs > 1 then
          require("telescope.builtin").buffers {
            sort_mru = true,
            ignore_current_buffer = true,
          }
        else
          notify "No other buffers open"
        end
      end, { desc = "Switch Buffers" })

      -- Renaming shortcuts
      map("n", "yrw", "yiw:s/\\C\\<<C-R>0\\>/", { desc = "Rename word" })
      map("n", "yrW", "yiW:s/\\C\\<<C-R>0\\>/", { desc = "Rename WORD" })
      map("n", "yre", "yie:s/\\C\\<<C-R>0\\>/", { desc = "Rename entire word" })
      map("n", "yrE", "yiE:s/\\C\\<<C-R>0\\>/", { desc = "Rename entire WORD" })
      map("n", "<F2>", "y:%s/<C-R>0/", { desc = "Global replace" })
      map("n", "<F2><F2>", "y:%s/<C-R>0/", { desc = "Global replace" })

      -- Spectre and SSR
      map("n", "<F3>", "<cmd>lua require('spectre').open()<cr>", { desc = "Open Spectre" })
      map("n", "<F3><F3>", "<cmd>lua require('spectre').open_visual({select_word=true})<CR>",
        { desc = "Open Spectre with word" })
      map("n", "<leader>r", function() require("ssr").open() end, { desc = "Structural Search Replace" })

      -- Telescope
      map("n", "<C-p>", "<cmd>Telescope fd<CR>", { desc = "Find files" })
      map("n", "<C-S-p>", "<cmd>Telescope commands<CR>", { desc = "Commands" })
      map("n", "<C-f>", "<cmd>Telescope live_grep<CR>", { desc = "Live grep" })

      -- Trouble
      map("n", "<leader>xx", "<cmd>TroubleToggle<CR>", { desc = "Toggle Trouble" })
      map("n", "<leader>xw", "<cmd>TroubleToggle lsp_workspace_diagnostics<CR>", { desc = "Workspace diagnostics" })
      map("n", "<leader>xd", "<cmd>TroubleToggle lsp_document_diagnostics<CR>", { desc = "Document diagnostics" })
      map("n", "<leader>xq", "<cmd>TroubleToggle quickfix<CR>", { desc = "Quickfix list" })
      map("n", "<leader>xl", "<cmd>TroubleToggle loclist<CR>", { desc = "Location list" })
      map("n", "<leader>xr", "<cmd>TroubleToggle lsp_references<CR>", { desc = "LSP references" })

      -- Terminal mappings (WezTerm if available, integrated otherwise)
      map("n", "<leader>th", function()
        if _G.TerminalUtils then
          _G.TerminalUtils.open_external_terminal("horizontal")
        else
          vim.cmd("ToggleTerm size=15 direction=horizontal")
        end
      end, { desc = "Terminal Horizontal (External/Integrated)" })
      
      map("n", "<leader>tv", function()
        if _G.TerminalUtils then
          _G.TerminalUtils.open_external_terminal("vertical")
        else
          vim.cmd("ToggleTerm size=80 direction=vertical")
        end
      end, { desc = "Terminal Vertical (External/Integrated)" })
      
      map("n", "<leader>tf", function()
        if _G.TerminalUtils then
          _G.TerminalUtils.open_external_terminal("float")
        else
          vim.cmd("ToggleTerm direction=float")
        end
      end, { desc = "Terminal Float (External/Integrated)" })
      
      -- Integrated terminal specific
      map("n", "<leader>ti", "<cmd>ToggleTerm direction=horizontal<CR>", { desc = "Terminal Integrated" })
      map("n", "<leader>tI", "<cmd>ToggleTerm direction=float<CR>", { desc = "Terminal Integrated Float" })
      
      -- External terminal specific (WezTerm/Windows Terminal)
      map("n", "<leader>te", function()
        if _G.TerminalUtils then
          _G.TerminalUtils.open_external_terminal("horizontal")
        else
          vim.notify("No external terminal available", vim.log.levels.WARN)
        end
      end, { desc = "Terminal External (WezTerm/WT)" })
      
      -- Other tools
      map("n", "<leader>n", "<cmd>ZenMode<CR>", { desc = "Zen Mode" })
      map("n", "<leader>u1", "<cmd>AerialToggle<CR>", { desc = "Toggle Aerial" })
      map("n", "<leader>u2", "<cmd>TroubleToggle<CR>", { desc = "Toggle Trouble" })
      map("n", "sj", "<cmd>TSJToggle<CR>", { desc = "TreeSJ toggle" })

      -- Grapple
      map("n", "gt", ":GrappleToggle<cr>", { desc = "Grapple toggle" })
      map("n", "gp", ":GrapplePopup tags<cr>", { desc = "Grapple popup" })

      -- Visual mode mappings
      map("v", "r", "y:s/\\C\\<<C-R>0\\>/", { desc = "Replace selection" })
      map("v", "<F2>", "'<'>%s/\\C<C-R>0/", { desc = "Replace in selection" })
      map("v", "<F2><F2>", "'<'>s/\\C<C-R>0/", { desc = "Replace in selection (single)" })
      map("v", "<leader>r", function() require("ssr").open() end, { desc = "Structural Search Replace" })

      -- Insert mode mappings
      map("i", "<M-o>", "<C-o>o", { desc = "Insert line below" })
      map("i", "<M-O>", "<C-o>O", { desc = "Insert line above" })
      map("i", "<M-l>", "<cmd>><cr>", { desc = "Indent" })
      map("i", "<M-h>", "<cmd><<cr>", { desc = "Unindent" })
    end,
  }
}

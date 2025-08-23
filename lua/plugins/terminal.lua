-- Terminal configuration for AstroNvim v5
-- Ensures PowerShell is used as default terminal

return {
  {
    "akinsho/toggleterm.nvim",
    opts = function(_, opts)
      -- Configure PowerShell as default shell for toggleterm
      local shell
      if vim.fn.has("win32") == 1 then
        shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell"
      else
        shell = vim.o.shell
      end

      return vim.tbl_deep_extend("force", opts, {
        shell = shell,
        shellcmdflag = vim.fn.has("win32") == 1 and "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command" or nil,
        size = function(term)
          if term.direction == "horizontal" then
            return 15
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
          end
        end,
        open_mapping = [[<C-\>]], -- Default terminal toggle
        hide_numbers = true,
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        terminal_mappings = true,
        persist_size = true,
        persist_mode = true,
        direction = "horizontal", -- 'vertical' | 'horizontal' | 'tab' | 'float'
        close_on_exit = true,
        auto_scroll = true,
        float_opts = {
          border = "curved",
          winblend = 3,
        },
        winbar = {
          enabled = false,
          name_formatter = function(term)
            return string.format("%d:%s", term.id, term:_display_name())
          end
        },
      })
    end,
  },
}
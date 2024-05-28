vim.api.nvim_create_augroup("winblend", { clear = true })
vim.api.nvim_create_autocmd("VimEnter", {
  group = "winblend",
  callback = function()
    if vim.g.neovide then
      vim.o.winblend = vim.g.winblend
      vim.cmd("hi! NormalFloat blend=" .. vim.o.winblend)
      vim.g.neovide_cursor_vfx_mode = "railgun"
      vim.g.neovide_cursor_vfx_particle_lifetime = 1.5
      vim.g.neovide_cursor_vfx_particle_density = 15
      vim.g.neovide_transparency = 0.9
      vim.g.heirline_bufferline = true
      vim.g.winblend = vim.g.neovide and 30 or 0
      vim.opt.guifont = "VictorMono Nerd Font,Hack Nerd Font:h12:#e-subpixelantialias:antialias=1:autohint=0"
      -- opt = {
      --   -- guifont = "VictorMono Nerd Font,Hack Nerd Font:h13.5:#h-normal",
      --   -- guifont = "VictorMono Nerd Font,Hack Nerd Font:h12:#e-subpixelantialias:antialias=1:autohint=0",
      -- }
      vim.o.autoread = true
      vim.o.winwidth = 10
      vim.o.winminwidth = 10
      vim.o.equalalways = true
      vim.o.pumblend = vim.g.winblend
      vim.o.shell = vim.fn.executable "pwsh" and "pwsh" or "powershell"
      vim.o.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
      vim.o.shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait"
      vim.o.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
      vim.o.shellquote = ""
      vim.o.shellxquote = ""
    end
  end,
})

local function is_lsp_server_ready()
  local clients = vim.lsp.get_active_clients({ bufnr = 0 })
  return #clients > 0
end

-- vim.api.nvim_create_augroup("DiagnosticPopup", { clear = true })
-- vim.api.nvim_create_autocmd("CursorHold", {
--   group = "DiagnosticPopup",
--   callback = function()
--     local row, col = vim.api.nvim_win_get_cursor(0)
--     local line_diagnostic = vim.diagnostic.get(0, { lnum = row })
--     if is_lsp_server_ready() then vim.diagnostic.open_float() end
--   end,
-- })

vim.api.nvim_create_augroup("DiagnosticMode", { clear = true })
vim.api.nvim_create_autocmd("ModeChanged", {
  pattern = { "i", "v" },
  group = "DiagnosticMode",
  callback = function()
    if is_lsp_server_ready() then vim.diagnostic.hide() end
  end,
})

vim.api.nvim_create_autocmd("ModeChanged", {
  pattern = "n",
  group = "DiagnosticMode",
  callback = function()
    if is_lsp_server_ready() then vim.diagnostic.show() end
  end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    _G.THEME = require("util.theme").setup()
    vim.api.nvim_set_hl(0, 'SmoothCursor', { fg = THEME.mode.normal })
  end
})

-- Set the cursor color based on the mode
vim.api.nvim_create_autocmd({ 'ModeChanged' }, {
  callback = function()
    local current_mode = vim.fn.mode()
    if current_mode == 'n' then
      vim.api.nvim_set_hl(0, 'SmoothCursor', { fg = THEME.mode.normal })
      vim.fn.sign_define('smoothcursor', { text = '' })
    elseif current_mode == 'v' then
      vim.api.nvim_set_hl(0, 'SmoothCursor', { fg = THEME.mode.visual })
      vim.fn.sign_define('smoothcursor', { text = '' })
    elseif current_mode == 'V' then
      vim.api.nvim_set_hl(0, 'SmoothCursor', { fg = THEME.mode.visual })
      vim.fn.sign_define('smoothcursor', { text = '' })
    elseif current_mode == 'r' or current_mode == 'R' then
      vim.api.nvim_set_hl(0, 'SmoothCursor', { fg = THEME.mode.replace })
      vim.fn.sign_define('smoothcursor', { text = '' })
    elseif current_mode == 'i' then
      vim.api.nvim_set_hl(0, 'SmoothCursor', { fg = THEME.mode.insert })
      vim.fn.sign_define('smoothcursor', { text = '' })
    end
  end,
})
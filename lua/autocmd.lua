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

-- THEME is now initialized in theme-init.lua before this file loads
-- Set up SmoothCursor highlights using the theme system
local theme_init = require("theme-init")

-- Set initial SmoothCursor color
local function update_smooth_cursor()
  local normal_color = theme_init.get_mode_color("normal")
  if normal_color then
    vim.api.nvim_set_hl(0, 'SmoothCursor', { fg = normal_color })
  end
end

-- Update cursor color on theme changes
vim.api.nvim_create_autocmd("User", {
  pattern = "ThemeUpdated",
  group = vim.api.nvim_create_augroup("SmoothCursorTheme", { clear = true }),
  callback = update_smooth_cursor,
  desc = "Update SmoothCursor colors when theme changes"
})

-- Set initial color
update_smooth_cursor()

-- Set the cursor color based on the mode
vim.api.nvim_create_autocmd({ 'ModeChanged' }, {
  group = vim.api.nvim_create_augroup("SmoothCursorMode", { clear = true }),
  callback = function()
    local current_mode = vim.fn.mode()
    local color
    
    if current_mode == 'n' then
      color = theme_init.get_mode_color("normal")
    elseif current_mode == 'v' or current_mode == 'V' then
      color = theme_init.get_mode_color("visual")
    elseif current_mode == 'r' or current_mode == 'R' then
      color = theme_init.get_mode_color("replace")
    elseif current_mode == 'i' then
      color = theme_init.get_mode_color("insert")
    elseif current_mode == 'c' then
      color = theme_init.get_mode_color("command")
    end
    
    if color then
      vim.api.nvim_set_hl(0, 'SmoothCursor', { fg = color })
      vim.fn.sign_define('smoothcursor', { text = '' })
    end
  end,
  desc = "Update SmoothCursor color based on current mode"
})
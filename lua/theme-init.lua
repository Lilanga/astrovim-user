-- Global theme initialization for AstroNvim v5
-- This file ensures THEME global is always available

-- Initialize winblend early for which-key and other plugins
vim.g.winblend = vim.g.winblend or 0

local M = {}

-- Default theme colors based on TokyoNight Storm
local default_theme = {
  colors_name = "tokyonight-storm",
  mode = {
    normal = "#7aa2f7",   -- blue
    insert = "#9ece6a",   -- green  
    visual = "#ff9e64",   -- orange
    replace = "#f7768e",  -- red
    command = "#e0af68"   -- yellow
  },
  grapple = {
    normal = "#565f89",   -- muted blue
    insert = "#566f65",   -- muted green
    visual = "#59596c",   -- muted orange
    replace = "#5d5668",  -- muted red
    command = "#5a5a4a"   -- muted yellow
  },
  tools = {
    normal = "#414868",
    insert = "#49524a",
    visual = "#4a4754",
    replace = "#4d444a",
    command = "#4a4a3a"
  },
  nav_icon_bg = "#9ece6a",
  nav_bg = "#49524a",
  folder_icon_bg = "#f7768e", 
  folder_bg = "#4d444a"
}

-- Safe theme setup function
function M.setup_theme()
  -- Try to setup custom theme
  local ok, theme_util = pcall(require, "util.theme")
  if ok and theme_util and theme_util.setup then
    local theme_ok, custom_theme = pcall(theme_util.setup)
    if theme_ok and custom_theme then
      -- Ensure all required fields exist
      custom_theme.mode = custom_theme.mode or default_theme.mode
      custom_theme.grapple = custom_theme.grapple or default_theme.grapple
      custom_theme.tools = custom_theme.tools or default_theme.tools
      return custom_theme
    end
  end
  
  -- Fallback to default theme
  return default_theme
end

-- Initialize global THEME immediately
function M.init()
  _G.THEME = M.setup_theme()
  
  -- Debug: confirm THEME is set
  if vim.g.theme_debug then
    vim.notify("THEME initialized: " .. vim.inspect(_G.THEME), vim.log.levels.INFO)
  end
  
  -- Set up autocmd to refresh theme on colorscheme change
  vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("ThemeInit", { clear = true }),
    callback = function()
      _G.THEME = M.setup_theme()
      
      -- Debug: confirm THEME is updated
      if vim.g.theme_debug then
        vim.notify("THEME updated on ColorScheme: " .. (_G.THEME and _G.THEME.colors_name or "unknown"), vim.log.levels.INFO)
      end
      
      -- Trigger custom theme update event
      vim.api.nvim_exec_autocmds("User", {
        pattern = "ThemeUpdated",
        data = { theme = _G.THEME }
      })
    end,
    desc = "Update global THEME on colorscheme change"
  })
  
  -- Add a command to check THEME status
  vim.api.nvim_create_user_command("ThemeStatus", function()
    if _G.THEME then
      vim.notify("THEME is loaded: " .. (_G.THEME.colors_name or "unknown"), vim.log.levels.INFO)
      vim.notify("Mode colors: " .. vim.inspect(_G.THEME.mode), vim.log.levels.INFO)
    else
      vim.notify("THEME is not loaded!", vim.log.levels.ERROR)
    end
  end, { desc = "Check THEME global status" })
end

-- Ensure THEME is always accessible
function M.get_theme()
  if not _G.THEME then
    _G.THEME = M.setup_theme()
  end
  return _G.THEME
end

-- Specific color getters with fallbacks
function M.get_mode_color(mode)
  local theme = M.get_theme()
  return (theme.mode and theme.mode[mode]) or default_theme.mode[mode] or default_theme.mode.normal
end

function M.get_grapple_color(mode)
  local theme = M.get_theme()
  return (theme.grapple and theme.grapple[mode]) or default_theme.grapple[mode] or default_theme.grapple.normal
end

function M.get_tool_color(mode)
  local theme = M.get_theme()
  return (theme.tools and theme.tools[mode]) or default_theme.tools[mode] or default_theme.tools.normal
end

return M
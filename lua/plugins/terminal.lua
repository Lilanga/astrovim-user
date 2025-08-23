-- Terminal configuration for AstroNvim v5
-- Uses WezTerm if available, falls back to integrated terminal

local M = {}

-- Function to get the best available shell
local function get_best_shell()
  -- Priority order: NuShell > PowerShell Core > Windows PowerShell > Default shell
  if vim.fn.executable("nu") == 1 then
    return "nu"
  elseif vim.fn.has("win32") == 1 then
    if vim.fn.executable("pwsh") == 1 then
      return "pwsh"
    else
      return "powershell"
    end
  else
    return vim.o.shell
  end
end

-- Function to detect available terminal emulators
local function get_terminal_cmd()
  local shell = get_best_shell()
  
  -- Check for WezTerm first
  if vim.fn.executable("wezterm") == 1 then
    return { "wezterm", "start", "--", shell }
  end
  
  -- Check for Windows Terminal
  if vim.fn.has("win32") == 1 and vim.fn.executable("wt") == 1 then
    -- Windows Terminal profile detection for NuShell
    if shell == "nu" then
      return { "wt", "-p", "nushell" } -- Use nushell profile if exists, fallback to nu command
    else
      return { "wt", "-p", shell }
    end
  end
  
  -- Fallback to system defaults
  return nil -- Use integrated terminal
end

-- Custom terminal functions
function M.open_external_terminal(direction)
  local cmd = get_terminal_cmd()
  if cmd then
    local cwd = vim.fn.getcwd()
    if vim.fn.has("win32") == 1 and cmd[1] == "wezterm" then
      -- WezTerm with working directory
      vim.fn.jobstart(vim.list_extend({ "wezterm", "start", "--cwd", cwd, "--" }, vim.list_slice(cmd, 4)))
    elseif vim.fn.has("win32") == 1 and cmd[1] == "wt" then
      -- Windows Terminal with working directory  
      vim.fn.jobstart({ "wt", "-d", cwd, "-p", cmd[3] })
    else
      vim.fn.jobstart(cmd)
    end
  else
    -- Fallback to integrated terminal
    vim.cmd("ToggleTerm direction=" .. (direction or "horizontal"))
  end
end

-- Function to get terminal info
function M.get_terminal_info()
  local cmd = get_terminal_cmd()
  local shell = get_best_shell()
  local terminal_type
  
  if cmd then
    if cmd[1] == "wezterm" then
      terminal_type = "WezTerm (External)"
    elseif cmd[1] == "wt" then
      terminal_type = "Windows Terminal (External)"
    else
      terminal_type = "External Terminal"
    end
  else
    terminal_type = "Integrated Terminal (ToggleTerm)"
  end
  
  return terminal_type, shell
end

-- Function to get shell display name
function M.get_shell_display_name(shell)
  if shell == "nu" then
    return "NuShell"
  elseif shell == "pwsh" then
    return "PowerShell Core"
  elseif shell == "powershell" then
    return "Windows PowerShell"
  else
    return shell
  end
end

return {
  {
    "akinsho/toggleterm.nvim",
    opts = function(_, opts)
      -- Configure best available shell for integrated terminal
      local shell = get_best_shell()
      local shellcmdflag
      
      -- Configure shell-specific flags
      if shell == "nu" then
        -- NuShell doesn't need special flags for integrated terminal
        shellcmdflag = nil
      elseif vim.fn.has("win32") == 1 and (shell == "pwsh" or shell == "powershell") then
        shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command"
      else
        shellcmdflag = nil
      end

      return vim.tbl_deep_extend("force", opts, {
        shell = shell,
        shellcmdflag = shellcmdflag,
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
  {
    -- Add terminal utility functions globally
    "terminal-utils",
    dir = vim.fn.stdpath("config"),
    name = "terminal-utils",
    lazy = false,
    config = function()
      -- Make terminal functions globally available
      _G.TerminalUtils = M
      
      -- Add command to check terminal status
      vim.api.nvim_create_user_command("TerminalInfo", function()
        local info = M.get_terminal_info()
        local shell = vim.fn.has("win32") == 1 and (vim.fn.executable("pwsh") == 1 and "PowerShell Core" or "Windows PowerShell") or vim.o.shell
        vim.notify(string.format("Terminal: %s\nShell: %s", info, shell), vim.log.levels.INFO)
      end, { desc = "Show terminal configuration info" })
    end,
  },
}
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    _G.THEME = require("user.util.theme").setup()
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

return {}

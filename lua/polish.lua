-- if true then return end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- setup autocmds
require "autocmd"

local function change_color_scheme(scheme)
  vim.cmd('colorscheme ' .. scheme)
end

-- this will trigger the defined autocmds
change_color_scheme('tokyonight')

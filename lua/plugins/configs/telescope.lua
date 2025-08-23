return function(_, opts)
    local telescope = require "telescope"
    telescope.setup(opts)
    
    -- Load extensions if available (AstroNvim v5 compatible)
    if pcall(require, "notify") then
      telescope.load_extension("notify")
    end
    
    if pcall(require, "aerial") then
      telescope.load_extension("aerial")
    end
    
    if pcall(require, "telescope-fzf-native") then
      telescope.load_extension("fzf")
    end
  end
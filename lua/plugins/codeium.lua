-- Disable Codeium in favor of Copilot to prevent conflicts
return {
  -- Disable any codeium plugins that might be imported from astrocommunity
  {
    "Exafunction/codeium.nvim",
    enabled = false, -- Disable codeium to prevent conflicts with copilot
  },
  {
    "Exafunction/codeium.vim", 
    enabled = false, -- Disable codeium.vim as well
  },
  -- Also disable any potential astrocommunity codeium imports
  {
    "astrocommunity.completion.codeium-nvim",
    enabled = false,
  },
  {
    "astrocommunity.completion.codeium-vim",
    enabled = false,
  },
}
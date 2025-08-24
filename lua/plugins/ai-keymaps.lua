return {
  "AstroNvim/astrocore",
  opts = {
    mappings = {
      n = {
        -- AI Assistant keymaps
        ["<leader>A"] = { desc = " AI Assistant" },
        
        -- Copilot keymaps
        ["<leader>Ac"] = { desc = "󰚩 Copilot" },
        ["<leader>Ace"] = { "<cmd>Copilot enable<cr>", desc = "Enable Copilot" },
        ["<leader>Acd"] = { "<cmd>Copilot disable<cr>", desc = "Disable Copilot" },
        ["<leader>Acs"] = { "<cmd>Copilot status<cr>", desc = "Copilot Status" },
      },
    },
  },
}
-- AstroCommunity plugins
-- https://github.com/AstroNvim/astrocommunity

return {
    -- ----------------------------------------------
    -- Add the community repository of plugin specifications
    "AstroNvim/astrocommunity",
  
    -- copilot + cmp extension
    { import = "astrocommunity.completion.copilot-lua" },
    { import = "astrocommunity.completion.copilot-lua-cmp" },
    -- code runner
    -- Overseer task runner & job management
    { import = "astrocommunity.code-runner.overseer-nvim" },
  
    -- diagnostics
    { import = "astrocommunity.diagnostics.lsp_lines-nvim" },
    { import = "astrocommunity.diagnostics.trouble-nvim" },
  
    -- ccc-nvim disabled due to AstroNvim v5 compatibility issues
  
    -- nvim-surround configured manually in init.lua
  
    -- Editor support
    -- Rainbow parens
    { import = "astrocommunity.editing-support.rainbow-delimiters-nvim" },
    { import = "astrocommunity.editing-support.nvim-regexplainer" },
    -- todo-comments.nvim configured manually in init.lua
  
    -- Distraction free editing
    -- { import = "astrocommunity.editing-support.zen-mode-nvim" },
    -- {
    --   "folke/zen-mode.nvim",
    --   opts = {
    --     -- override default configuration
    --     -- https://github.com/folke/zen-mode.nvim#%EF%B8%8F-configuration
    --     plugins = {
    --       options = {
    --         enabled = true,
    --       },
    --       kitty = {
    --         enabled = true,
    --         font = "+4", -- font size increment
    --       },
    --     },
    --   },
    -- },
  
    -- Motion
    -- Navigate with search labels
    { import = "astrocommunity.motion.flash-nvim" }, -- overrides S surround in visual state
  
    -- Packs
    -- Treesitter: clojure , Lsp: clojure-lsp, Lint/format:
    { import = "astrocommunity.pack.clojure" },

    -- Treesitter: dockerfile , Lsp: dockerls & docker_compose_language_service, Lint/format: hadolint
    { import = "astrocommunity.pack.docker" },
    -- Treesitter: json & jsonc, Lsp: jsonls, Lint/format: stylua
    { import = "astrocommunity.pack.json" },
    -- Treesitter: lua, Lsp: lua_ls, Lint/format: stylua
    { import = "astrocommunity.pack.lua" },
  
    -- Pack not used as prettierd too agressive with format
    -- Treesitter: markdown & markdown_inline, Lsp: marksman, Lint/format: prettierd
    { import = "astrocommunity.pack.markdown" },
    -- Treesitter: markdown & markdown_inline, Lsp: marksman, Lint/format: prettierd
    { import = "astrocommunity.pack.yaml" },
    -- Treesitter: typescript & typescriptreact, Lsp: tsserver, Lint/format: eslint_d
    { import = "astrocommunity.pack.typescript" },
    -- switch between projects
    { import = "astrocommunity.project.project-nvim" },
  
    -- nvim-spectre is configured manually in init.lua (no astrocommunity import available)
  
    -- Programing Language support
    { import = "astrocommunity.programming-language-support.nvim-jqx" },
  
    -- Registers
    { import = "astrocommunity.register.nvim-neoclip-lua" },
  
    { import = "astrocommunity.utility.noice-nvim" },

    -- Bars and lines
    { import = "astrocommunity.bars-and-lines.bufferline-nvim" },
  }
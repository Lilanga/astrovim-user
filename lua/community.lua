-- AstroCommunity pack configurations for AstroNvim v6
-- Imported before plugins/ folder in lazy_setup.lua

---@type LazySpec
return {
  "AstroNvim/astrocommunity",

  -- Completion
  { import = "astrocommunity.completion.copilot-lua" },

  -- Code runner
  { import = "astrocommunity.code-runner.overseer-nvim" },

  -- Diagnostics
  { import = "astrocommunity.diagnostics.trouble-nvim" },

  -- Colorschemes
  { import = "astrocommunity.colorscheme.tokyonight-nvim" },
  { import = "astrocommunity.colorscheme.catppuccin" },

  -- Editing support
  { import = "astrocommunity.editing-support.rainbow-delimiters-nvim" },
  { import = "astrocommunity.editing-support.nvim-regexplainer" },
  { import = "astrocommunity.editing-support.mini-splitjoin" },

  -- Motion
  { import = "astrocommunity.motion.flash-nvim" },

  -- Git
  { import = "astrocommunity.git.diffview-nvim" },

  -- Language packs
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.go" },
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.docker" },
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.yaml" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.clojure" },
  { import = "astrocommunity.pack.cs" },
  { import = "astrocommunity.pack.terraform" },

  -- Project
  { import = "astrocommunity.project.project-nvim" },

  -- Registers
  { import = "astrocommunity.register.nvim-neoclip-lua" },

  -- Utility
  { import = "astrocommunity.utility.noice-nvim" },

  -- Bars and lines
  { import = "astrocommunity.bars-and-lines.bufferline-nvim" },

  -- Programming language support
  { import = "astrocommunity.programming-language-support.nvim-jqx" },
}

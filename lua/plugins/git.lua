-- Git workflow plugins
-- gitsigns is included by AstroNvim, diffview via community

return {
  -- diffview for complex diffs (imported via astrocommunity.git.diffview-nvim)

  -- todo-comments for TODO/FIXME annotations
  {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    opts = {},
  },
}

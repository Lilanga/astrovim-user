return {
  "folke/snacks.nvim",
  opts = function(_, opts)
    -- Configure git module for blame functionality
    opts.git = {
      enabled = true,
      -- Configuration for git operations
      blame = {
        enabled = true,
        format = function(blame)
          if not blame or blame.uncommitted then
            return ""
          end
          
          local author = blame.author or "Unknown"
          local time = blame.time and os.date("%Y-%m-%d", blame.time) or "Unknown"
          local summary = blame.summary or ""
          
          -- Truncate long commit messages
          if #summary > 50 then
            summary = summary:sub(1, 47) .. "..."
          end
          
          return string.format("󰊢 %s • %s • %s", author, time, summary)
        end,
      },
    }
    
    return opts
  end,
  
  -- Add keymaps for git blame functionality using snacks git module
  keys = {
    {
      "<leader>gb",
      function()
        -- Use snacks git blame for current line
        Snacks.git.blame_line()
      end,
      desc = "Show Git Blame for Current Line",
    },
    {
      "<leader>gB", 
      function()
        -- Open git blame in a buffer
        Snacks.git.blame()
      end,
      desc = "Show Git Blame for File",
    },
    {
      "<leader>go",
      function()
        -- Open file in browser (GitHub, GitLab, etc.)
        Snacks.gitbrowse()
      end,
      desc = "Open in Git Browser",
    },
  },
}
return {
  {
    "github/copilot.vim",
    event = "InsertEnter",
    config = function()
      -- Disable default tab mapping (we'll use custom ones)
      vim.g.copilot_no_tab_map = true
      
      -- Enable copilot for specific filetypes
      vim.g.copilot_filetypes = {
        ["*"] = true,
        ["gitcommit"] = false,
        ["gitrebase"] = false,
        ["hgcommit"] = false,
        ["svn"] = false,
        ["cvs"] = false,
        ["."] = false,
      }
      
      -- Custom keymaps for copilot
      local keymap = vim.keymap.set
      keymap("i", "<C-J>", 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false })
      keymap("i", "<C-L>", "copilot#AcceptWord()", { expr = true, replace_keycodes = false })
      keymap("i", "<C-H>", "copilot#Dismiss()", { expr = true, replace_keycodes = false })
      keymap("i", "<C-]>", "copilot#Next()", { expr = true, replace_keycodes = false })
      keymap("i", "<C-[>", "copilot#Previous()", { expr = true, replace_keycodes = false })
    end,
  },
  
  -- Copilot Chat for interactive AI conversations
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "github/copilot.vim" },
      { "nvim-lua/plenary.nvim" },
    },
    event = "VeryLazy",
    opts = {
      debug = false,
      show_help = "yes",
      prompts = {
        Explain = "Please explain how the following code works.",
        Review = "Please review the following code and provide suggestions for improvement.",
        Tests = "Please explain how the selected code works, then generate unit tests for it.",
        Refactor = "Please refactor the following code to improve its clarity and readability.",
        FixCode = "Please fix the following code to make it work as intended.",
        FixError = "Please explain the error in the following text and provide a solution.",
        BetterNamings = "Please provide better names for the following variables and functions.",
        Documentation = "Please provide documentation for the following code.",
        SwaggerApiDocs = "Please provide swagger documentation for the following API.",
        SwaggerJSDoc = "Please write JSDoc for the following API using Swagger syntax.",
      },
      auto_follow_cursor = false,
      show_folds = true,
      mappings = {
        complete = {
          detail = "Use @<Tab> or /<Tab> for options.",
          insert = "<Tab>",
        },
        close = {
          normal = "q",
          insert = "<C-c>",
        },
        reset = {
          normal = "<C-r>",
          insert = "<C-r>",
        },
        submit_prompt = {
          normal = "<CR>",
          insert = "<C-CR>",
        },
        accept_diff = {
          normal = "<C-y>",
          insert = "<C-y>",
        },
        yank_diff = {
          normal = "gy",
        },
        show_diff = {
          normal = "gd",
        },
        show_system_prompt = {
          normal = "gp",
        },
        show_user_selection = {
          normal = "gs",
        },
      },
    },
    config = function(_, opts)
      require("CopilotChat").setup(opts)
      
      -- Custom commands
      vim.api.nvim_create_user_command("CopilotChatVisual", function(args)
        require("CopilotChat").ask(args.args, { selection = require("CopilotChat.select").visual })
      end, { nargs = "*", range = true })
      
      vim.api.nvim_create_user_command("CopilotChatInline", function(args)
        require("CopilotChat").ask(args.args, {
          selection = require("CopilotChat.select").visual,
          window = { layout = "float", title = "Copilot Chat" },
        })
      end, { nargs = "*", range = true })
    end,
    keys = {
      -- Show prompts actions with telescope
      {
        "<leader>ap",
        function()
          local actions = require("CopilotChat.actions")
          require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
        end,
        desc = "CopilotChat - Prompt actions",
      },
      {
        "<leader>ap",
        ":lua require('CopilotChat.integrations.telescope').pick(require('CopilotChat.actions').prompt_actions({selection = require('CopilotChat.select').visual}))<CR>",
        mode = "x",
        desc = "CopilotChat - Prompt actions",
      },
      -- Code related commands
      { "<leader>ae", "<cmd>CopilotChatExplain<cr>", desc = "CopilotChat - Explain code" },
      { "<leader>at", "<cmd>CopilotChatTests<cr>", desc = "CopilotChat - Generate tests" },
      { "<leader>ar", "<cmd>CopilotChatReview<cr>", desc = "CopilotChat - Review code" },
      { "<leader>aR", "<cmd>CopilotChatRefactor<cr>", desc = "CopilotChat - Refactor code" },
      { "<leader>an", "<cmd>CopilotChatBetterNamings<cr>", desc = "CopilotChat - Better Naming" },
      -- Chat commands
      { "<leader>ac", "<cmd>CopilotChat<cr>", desc = "CopilotChat - Open in vertical split" },
      { "<leader>ax", "<cmd>CopilotChatInline<cr>", mode = "x", desc = "CopilotChat - Inline chat" },
      { "<leader>ai", "<cmd>CopilotChatInline<cr>", desc = "CopilotChat - Inline chat" },
      -- Custom input for CopilotChat
      {
        "<leader>aq",
        function()
          local input = vim.fn.input("Quick Chat: ")
          if input ~= "" then
            require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
          end
        end,
        desc = "CopilotChat - Quick chat",
      },
      -- Debug
      { "<leader>ad", "<cmd>CopilotChatDebugInfo<cr>", desc = "CopilotChat - Debug Info" },
      -- Fix the issue with folds
      { "<leader>af", "<cmd>CopilotChatFixDiagnostic<cr>", desc = "CopilotChat - Fix Diagnostic" },
      -- Clear buffer and chat history
      { "<leader>al", "<cmd>CopilotChatReset<cr>", desc = "CopilotChat - Clear buffer and chat history" },
      -- Toggle Copilot Chat Vsplit
      { "<leader>av", "<cmd>CopilotChatToggle<cr>", desc = "CopilotChat - Toggle" },
    },
  },
}
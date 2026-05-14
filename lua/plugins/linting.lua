-- Linting configuration using nvim-lint

return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPost", "BufWritePost", "InsertLeave" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      python = { "ruff" },
      go = { "golangcilint" },
      dockerfile = { "hadolint" },
      yaml = { "yamllint" },
      markdown = { "markdownlint" },
      sh = { "shellcheck" },
      terraform = { "tflint" },
    }

    vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
      callback = function() lint.try_lint() end,
    })
  end,
}

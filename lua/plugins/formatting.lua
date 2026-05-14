-- Formatting configuration using conform.nvim
-- Project-aware formatter selection (Biome vs Prettier)

return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  cmd = "ConformInfo",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      javascript = { "biome", "prettierd", "prettier", stop_after_first = true },
      typescript = { "biome", "prettierd", "prettier", stop_after_first = true },
      javascriptreact = { "biome", "prettierd", "prettier", stop_after_first = true },
      typescriptreact = { "biome", "prettierd", "prettier", stop_after_first = true },
      go = { "goimports", "gofumpt" },
      python = { "ruff_format", "black", stop_after_first = true },
      cs = { "csharpier" },
      terraform = { "terraform_fmt" },
      markdown = { "prettier" },
      json = { "jq", "prettier", stop_after_first = true },
      yaml = { "prettier" },
      sh = { "shfmt" },
      dockerfile = { "prettier" },
      css = { "prettier" },
      html = { "prettier" },
    },
    format_on_save = {
      timeout_ms = 3000,
      lsp_format = "fallback",
    },
  },
}

-- AstroLSP configuration for AstroNvim v6
-- Uses vim.lsp.config patterns for Neovim 0.11+

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    features = {
      autoformat = true,
      codelens = true,
      inlay_hints = false,
      semantic_tokens = true,
    },
    formatting = {
      format_on_save = {
        enabled = true,
        ignore_filetypes = {},
      },
      disabled = {},
      timeout_ms = 3000,
    },
    -- Default config applied to all servers via config["*"]
    config = {
      ["*"] = {
        -- default capabilities and flags for all servers
      },
    },
    -- Server handlers - use "*" key for default
    handlers = {
      -- Default handler uses vim.lsp.enable in v6
    },
    autocmds = {
      lsp_document_highlight = {
        cond = "textDocument/documentHighlight",
        {
          event = { "CursorHold", "CursorHoldI" },
          desc = "Document Highlighting",
          callback = function() vim.lsp.buf.document_highlight() end,
        },
        {
          event = { "CursorMoved", "CursorMovedI", "BufLeave" },
          desc = "Document Highlighting Clear",
          callback = function() vim.lsp.buf.clear_references() end,
        },
      },
    },
    mappings = {
      n = {
        ["gl"] = {
          function() vim.diagnostic.open_float() end,
          desc = "Hover diagnostics",
        },
        ["<Leader>lw"] = {
          function() vim.diagnostic.setloclist() end,
          desc = "Workspace diagnostics",
        },
      },
    },
    on_attach = function(client, bufnr)
      -- Custom on_attach logic
    end,
  },
}

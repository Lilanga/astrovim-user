-- Noice.nvim configuration for AstroNvim v6
-- Fancy command line, message routing, and LSP messages
-- Base import comes from astrocommunity.utility.noice-nvim

return {
  "folke/noice.nvim",
  opts = {
    presets = {
      bottom_search = false,
      command_palette = true,
      long_message_to_split = true,
      inc_rename = true,
      lsp_doc_border = true,
    },
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
  },
}

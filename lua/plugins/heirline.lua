return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    local status = {
      user = require "util.statusline",
      astro = require "astroui.status",
    }
    local astroui = require "astroui"
    local mini_icons = require "mini.icons"


    local mode_text_color_1 = {
      "#1C2A43",
      "#002627",
      "#1C1836",
      "#2B0000",
      "#1D1905",
    }

    local mode_text_color_2 = {
      normal = "#E0FFFF",
      insert = "#C8F7C5",
      visual = "#FFECDB",
      replace = "#FFECDB",
      command = "#FFFACD",
    }

    local bufnr = self and self.bufnr or 0
    local ft_icon, _ = mini_icons.get("file", vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":t"))
    if not ft_icon then
      ft_icon, _ = mini_icons.get("filetype", vim.bo[bufnr].filetype)
    end

    -- the first element of the configuration table is the statusline
    opts.statusline = {
      -- default highlight for the entire statusline
      hl = { fg = "fg", bg = "bg" },
      -----------------------------------
      ---- NOTE: Left side of neovim.----
      -----------------------------------

      -- Vim mode compnonent, using custom
      status.astro.component.builder {
        { provider = status.user.mode },
        -- mode_text = { icon = "test", padding = { right = 1, left = 1 } },
        -- hl = function() return { fg = mode_color(mode_text_color_1) } end,
        hl = { fg = "bg" },
        surround = {
          separator = "left",
          color = function()
            local theme_init = require("theme-init")
            local theme = theme_init.get_theme()
            return {
              main = status.user.mode_color(theme.mode),
              right = status.user.mode_color(theme.grapple),
            }
          end,
        },
        update = {
          "ModeChanged",
          callback = vim.schedule_wrap(function() vim.cmd.redrawstatus() end),
        },
      },
      -- Custom component for grapple
      status.astro.component.builder {
        { provider = status.user.grapple },
        hl = function() return { fg = status.user.set_grapple_color(mode_text_color_2) } end,
        surround = {
          separator = "left",
          color = function()
            return {
              main = status.user.mode_color(THEME.grapple),
              right = status.user.mode_color(THEME.tools),
            }
          end,
        },
      },
      -- Custom compnent for macro recordings
      status.astro.component.builder {
        { provider = status.user.macro_recording },
        hl = function() return { fg = status.user.mode_color(mode_text_color_2), bold = true } end,
        surround = {
          separator = "left",
          color = function() return { main = status.user.mode_color(THEME.tools), right = "bg" } end,
        },
        update = {
          "RecordingEnter",
          "RecordingLeave",
          callback = vim.schedule_wrap(function() vim.cmd.redrawstatus() end),
        },
      },
      -------------------------------------
      ---- NOTE: Center side of neovim.----
      -------------------------------------

      -- add a component for the current git branch if it exists and use no separator for the sections
      status.astro.component.git_branch { surround = { separator = "none" } },
      -- add a component for the current git diff if it exists and use no separator for the sections
      status.astro.component.git_diff { padding = { left = 1 }, surround = { separator = "none" } },
      -- fill the rest of the statusline
      -- the elements after this will appear in the middle of the statusline
      status.astro.component.fill(),
      -- add a component to display if the LSP is loading, disable showing running client names, and use no separator
      status.astro.component.lsp { lsp_client_names = false, surround = { separator = "none", color = "bg" } },
      -- fill the rest of the statusline
      -- the elements after this will appear on the right of the statusline
      status.astro.component.fill(),
      ------------------------------------
      ---- NOTE: Right side of neovim.----
      ------------------------------------

      -- add a component for the current diagnostics if it exists and use the right separator for the section
      status.astro.component.diagnostics { surround = { separator = "space_right" } },
      -- add a component to display LSP clients, disable showing LSP progress, and use the right separator
      status.astro.component.lsp { lsp_progress = false, surround = { separator = "space_right" } },
      {
        -- define a simple component where the provider is just a folder icon
        status.astro.component.builder {
          { provider = astroui.get_icon("FolderClosed") },
          padding = { left = 1, right = 1 },
          hl = { fg = "bg" },
          surround = {
            separator = "right",
            color = function() return { main = THEME.folder_icon_bg } end,
          },
        },
        status.astro.component.builder {
          { provider = "" },
          surround = {
            separator = "right_accent",
            color = function() return { main = THEME.folder_icon_bg, right = THEME.folder_bg } end,
          },
        },
        -- add a file information component and only show the current working directory name
        status.astro.component.file_info {
          surround = {
            separator = "none",
            color = function() return THEME.folder_bg end,
          },
        },
      },
      {
        status.astro.component.builder {
          { provider = ft_icon },
          padding = { left = 1, right = 1 },
          hl = { fg = "bg" },
          surround = {
            separator = "right",
            color = function() return { main = THEME.nav_icon_bg, left = THEME.folder_bg } end,
          },
        },
        status.astro.component.builder {
          { provider = "" },
          surround = {
            separator = "right_accent",
            color = function() return { main = THEME.nav_icon_bg, right = THEME.nav_bg } end,
          },
        },
        status.astro.component.nav {
          percentage = { padding = { left = 1, right = 1 } },
          ruler = false,
          scrollbar = false,
          hl = function() return { fg = THEME.nav_icon_bg } end,
          surround = {
            separator = "none",
            color = function() return THEME.nav_bg end,
          },
        },
      },
    }

    opts.winbar = {     -- create custom winbar
      -- store the current buffer number
      init = function(self) self.bufnr = vim.api.nvim_get_current_buf() end,
      fallthrough = false,     -- pick the correct winbar based on condition
      -- inactive winbar
      {
        condition = function() return not status.astro.condition.is_active() end,
        -- show the path to the file relative to the working directory
        status.astro.component.separated_path { path_func = status.astro.provider.filename { modify = ":.:h" } },
        -- add the file name and icon
        status.astro.component.file_info {
          file_icon = { hl = status.astro.hl.file_icon "winbar", padding = { left = 0 } },
          file_modified = false,
          file_read_only = false,
          hl = status.astro.hl.get_attributes("winbarnc", true),
          surround = false,
          update = "BufEnter",
        },
      },
      -- active winbar
      {
        -- show the path to the file relative to the working directory
        status.astro.component.separated_path { path_func = status.astro.provider.filename { modify = ":.:h" } },
        -- add the file name and icon
        status.astro.component.file_info {     -- add file_info to breadcrumbs
          file_icon = { hl = status.astro.hl.filetype_color, padding = { left = 0 } },
          file_modified = false,
          file_read_only = false,
          hl = status.astro.hl.get_attributes("winbar", true),
          surround = false,
          update = "BufEnter",
        },
        -- show the breadcrumbs
        status.astro.component.breadcrumbs {
          icon = { hl = true },
          hl = status.astro.hl.get_attributes("winbar", true),
          prefix = true,
          padding = { left = 0 },
        },
      },
    }

    return opts
  end,
}
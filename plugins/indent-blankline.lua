return {
    {
       "lukas-reineke/indent-blankline.nvim",
       event = "User AstroFile",
       main = "ibl",
       opts = {
         indent = { char = "▏" },
         scope = { show_start = false, show_end = false },
         exclude = {
           buftypes = {
             "nofile",
             "terminal",
           },
           filetypes = {
             "help",
             "startify",
             "aerial",
             "alpha",
             "dashboard",
             "lazy",
             "neogitstatus",
             "NvimTree",
             "neo-tree",
             "Trouble",
           },
         },
       },
       config = require "user.plugins.configs.indent-blankline",
     }
   }
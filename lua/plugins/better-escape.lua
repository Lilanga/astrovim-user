return {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    opts = {
        timeout = vim.o.timeoutlen,
        default_mappings = false,
        mappings = {
            i = {
                f = {
                    d = "<Esc>",
                },
            },
            c = {
                f = {
                    d = "<Esc>",
                },
            },
            t = {
                f = {
                    d = "<C-\\><C-n>",
                },
            },
            v = {
                f = {
                    d = "<Esc>",
                },
            },
            s = {
                f = {
                    d = "<Esc>",
                },
            },
        },
    },
}

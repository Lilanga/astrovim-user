return {
    "Shatur/neovim-session-manager",
    lazy = false,
    config = function()
        require("user.plugins.configs.session-manager")
    end,
    keys = {
        { "<Leader>ps", "<cmd>SessionManager available_commands<CR>",   desc = "session manager" },
        { "<Leader>pS", "<cmd>SessionManager save_current_session<CR>", desc = "save session" },
    }
}

return {
    {
        "tjdevries/express_line.nvim",
        config = function()
            require("plugins.config.statusline-config").setup()
        end,
    },
}

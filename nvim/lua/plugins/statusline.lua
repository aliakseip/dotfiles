return {
    {
        "tjdevries/express_line.nvim",
        config = function()
            require("features.statusline-config").setup()
        end,
    },
}

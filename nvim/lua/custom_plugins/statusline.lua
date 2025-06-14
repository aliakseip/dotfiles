return {
    {
        "tjdevries/express_line.nvim",
        config = function()
            require("lua.custom.statusline-config").setup()
        end,
    },
}

return {
    {
        "echasnovski/mini.nvim",
        enabled = true,
        config = function()
            require("mini.surround").setup()
            require("mini.comment").setup()
            require("mini.ai").setup()
            -- require("mini.git").setup()
            -- require("mini.diff").setup()
            -- require("mini.statusline").setup()
        end,
    },
}

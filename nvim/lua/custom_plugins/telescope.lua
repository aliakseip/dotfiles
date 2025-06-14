return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        enabled = true,
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },
        config = function()
            require("telescope").setup({
                extensions = {
                    fzf = {},
                },
                -- defaults = {
                -- },
                defaults = require("telescope.themes").get_ivy({
                    file_ignore_patterns = {
                        "venv",
                        ".venv",
                        "__pycache__",
                    },
                }),
            })

            require("telescope").load_extension("fzf")

            local builtin = require("telescope.builtin")

            vim.keymap.set("n", "<space>fh", builtin.help_tags)
            vim.keymap.set("n", "<space>fd", builtin.find_files)
            vim.keymap.set("n", "<space>ff", "<cmd>Telescope find_files hidden=true<cr>")
            vim.keymap.set("n", "<space>fg", builtin.live_grep)
            vim.keymap.set("n", "<space>fw", function()
                builtin.grep_string({ search = vim.fn.expand("<cword>") })
            end, { noremap = true, silent = true })
            vim.keymap.set("n", "<space>fW", function()
                builtin.grep_string({ search = vim.fn.expand("<cWORD>") })
            end, { noremap = true, silent = true })
            vim.keymap.set("n", "<space>fb", builtin.buffers)
            vim.keymap.set("n", "<C-p>", builtin.git_files)
            vim.keymap.set("n", "<space>fo", builtin.oldfiles)
            vim.keymap.set("n", "<space>/", builtin.current_buffer_fuzzy_find)
            vim.keymap.set("n", "<space>en", function()
                builtin.find_files({ cwd = vim.fn.stdpath("config") })
            end)
            vim.keymap.set("n", "<space>ep", function()
                builtin.find_files({
                    -- cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
                    cwd = vim.fs.joinpath("lazy", vim.fn.stdpath("data")),
                })
            end)

            require("lua.custom.multigrep").setup()
        end,
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
            require("telescope").setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({}),
                    },
                },
            })
            require("telescope").load_extension("ui-select")
        end,
    },
}

return {
    {
        "nvim-treesitter/nvim-treesitter",
        enabled = true,
        build = ":TSUpdate",
        config = function()
            ---@diagnostic disable-next-line: missing-fields
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "python", "cpp" },
                sync_install = false,
                auto_install = true,
                ignore_install = {},

                highlight = {
                    enable = true,
                    disable = function(_, buf)
                        local max_filesize = 100 * 1024 -- 100 KB
                        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                        if ok and stats and stats.size > max_filesize then
                            return true
                        end
                    end,
                    additional_vim_regex_highlighting = false,
                },
        --         incremental_selection = {
        --             enable = true,
        --             keymaps = {
        --                 init_selection = "<leader>ss",
        --                 node_incremental = "<leader>si",
        --                 scope_incremental = "<leader>sc",
        --                 node_decremental = "<leader>sd",
        --             },
        --         },
        --         textobjects = {
        --             select = {
        --                 enable = true,
        --                 lookahead = true,
        --                 keymaps = {
        --                     ["af"] = "@function.outer",
        --                     ["if"] = "@function.inner",
        --                     ["ac"] = "@class.outer",
        --                     ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
        --                     ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
        --                 },
        --                 selection_modes = {
        --                     ['@parameter.outer'] = 'v', -- charwise
        --                     ['@function.outer'] = 'v',  -- linewise
        --                     ['@class.outer'] = 'v',     -- blockwise
        --                 },
        --                 include_surrounding_whitespace = true,
        --             },
        --         },
            })
        end,
    },
    -- {
    --     "nvim-treesitter/nvim-treesitter-textobjects",
    --     enabled = true,
    -- },
}

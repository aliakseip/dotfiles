vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.undofile = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.g.mapleader = " "
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 0
vim.opt.cursorline = true
vim.opt.laststatus = 3

vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<bs>", "<cmd>noh<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set({ "n", "v" }, "<space>y", [["+y]])
vim.keymap.set("n", "<space>Y", [["+Y]])
vim.keymap.set({ "n", "v" }, "<space>d", [["_d]])
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "<space>w", "<cmd>!chmod +x %<CR>", { silent = true })
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")

vim.keymap.set("n", "<Leader>ds", vim.diagnostic.open_float, { desc = "Show diagnostic" })
vim.keymap.set("n", "<Leader>dv", function()
    local current_config = vim.diagnostic.config()
    local has_virtual_text = current_config and current_config.virtual_text
    vim.diagnostic.config({ virtual_text = not has_virtual_text })
end, { desc = "Toggle diagnostics virtual text" })

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (coping) text',
    group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.keymap.set("n", "<space>st", function()
    vim.cmd.vnew()
    vim.cmd.term()
    vim.cmd.wincmd("J")
    vim.api.nvim_win_set_height(0, 15)
end)


local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        "junegunn/fzf.vim",
        build = "./install --all",
        dependencies = {
            "junegunn/fzf",
        },
        config = function()
            local config_path = vim.fn.stdpath("config")

            vim.keymap.set("n", "<Leader>fd", "<Cmd>Files<CR>", { desc = "Find files" })
            vim.keymap.set("n", "<Leader>fb", "<Cmd>Buffers<CR>", { desc = "Find buffers" })
            vim.keymap.set("n", "<Leader>/", "<Cmd>Rg<CR>", { desc = "Search project" })
            vim.keymap.set("n", "<Leader>en", function()
                vim.cmd("Files " .. config_path)
            end, { desc = "Find in config" })
        end,
    },
    {
        "tjdevries/colorbuddy.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("gruvbuddy")
        end,
    },
    {
        "tjdevries/express_line.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local builtin = require "el.builtin"
            local extensions = require "el.extensions"
            local subscribe = require "el.subscribe"
            local sections = require "el.sections"

            require("el").setup {
                generator = function()
                    local segments = {}

                    table.insert(segments, extensions.mode)
                    table.insert(segments, " ")
                    table.insert(
                        segments,
                        subscribe.buf_autocmd("el-git-branch", "BufEnter", function(win, buf)
                            local branch = extensions.git_branch(win, buf)
                            if branch then
                                return branch
                            end
                        end)
                    )
                    table.insert(
                        segments,
                        subscribe.buf_autocmd("el-git-changes", "BufWritePost", function(win, buf)
                            local changes = extensions.git_changes(win, buf)
                            if changes then
                                return changes
                            end
                        end)
                    )
                    table.insert(segments, function()
                        local task_count = #require("misery.scheduler").tasks
                        if task_count == 0 then
                            return ""
                        else
                            return string.format(" (Queued Events: %d)", task_count)
                        end
                    end)
                    table.insert(segments, sections.split)
                    table.insert(segments, "%f")
                    table.insert(segments, sections.split)
                    table.insert(segments, builtin.filetype)
                    table.insert(segments, "[")
                    table.insert(segments, builtin.line_with_width(3))
                    table.insert(segments, ":")
                    table.insert(segments, builtin.column_with_width(2))
                    table.insert(segments, "]")

                    return segments
                end,
            }
        end,
    },
    {
        "stevearc/oil.nvim",
        config = function()
            require("oil").setup({
                default_file_explorer = false,
                view_options = {
                    show_hidden = true,
                },
            })
            vim.keymap.set("n", "-", "<Cmd>Oil<CR>", { desc = "Browse files from here" })
            vim.keymap.set("n", "<space>-", require("oil").toggle_float)
        end,
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter", -- Only load when you enter Insert mode
        config = function()
            require("nvim-autopairs").setup()
        end,
    },
    {
        "numToStr/Comment.nvim",
        event = "VeryLazy",
        config = function()
            require("Comment").setup()
        end,
    },
    {
        "mbbill/undotree",
        enabled = true,
        config = function()
            vim.keymap.set("n", "<space>u", vim.cmd.UndotreeToggle)
        end
    },
    {
        "lewis6991/gitsigns.nvim",
    },
    {
        "saghen/blink.cmp",
        dependencies = { "rafamadriz/friendly-snippets" },

        version = "1.*",
        opts = {
            keymap = { preset = "default" },

            appearance = {
                nerd_font_variant = "mono"
            },

        },
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "saghen/blink.cmp",
            {
                "folke/lazydev.nvim",
                ft = "lua",
                opts = {
                    library = {
                        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                    },
                },
            },
        },
        config = function()
            local capabilities = require("blink.cmp").get_lsp_capabilities()
            local servers = { "lua_ls", "pyright", "gopls" }

            for _, server in ipairs(servers) do
                vim.lsp.config(server, {
                    capabilities = vim.tbl_deep_extend("force", {}, capabilities),
                })
            end
            vim.lsp.enable(servers)

            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("my.lsp", {}),
                callback = function(args)
                    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
                    if vim.tbl_contains({ "lua", "go" }, vim.bo.filetype) then
                        if not client:supports_method("textDocument/willSaveWaitUntil")
                            and client:supports_method("textDocument/formatting") then
                            vim.api.nvim_create_autocmd("BufWritePre", {
                                group = vim.api.nvim_create_augroup("my.lsp", { clear = false }),
                                buffer = args.buf,
                                callback = function()
                                    vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
                                end,
                            })
                        end
                    end
                end,
            })
        end,

    },
})

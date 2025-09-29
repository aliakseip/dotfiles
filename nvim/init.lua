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


vim.cmd([[
    aunmenu PopUp
    anoremenu PopUp.Inspect     <cmd>Inspect<CR>
    amenu PopUp.-1-             <NOP>
    anoremenu PopUp.Definition  <cmd>lua vim.lsp.buf.definition()<CR>
    anoremenu PopUp.References  <cmd>Telescope lsp_references<CR>
    nnoremenu PopUp.Back        <C-t>
    amenu PopUp.-2-             <NOP>
    amenu PopUp.URL             gx
    ]])

local group = vim.api.nvim_create_augroup("nvim_popupmenu", { clear = true })
vim.api.nvim_create_autocmd("MenuPopup", {
    pattern = "*",
    group = group,
    desc = "Custom PopUp Setup",
    callback = function()
        vim.cmd([[
        amenu disable PopUp.Definition
        amenu disable PopUp.References
        amenu disable PopUp.URL
    ]])
        if vim.lsp.get_clients({ bufnr = 0 })[1] then
            vim.cmd([[
            amenu enable PopUp.Definition
            amenu enable PopUp.References
        ]])
        end

        local urls = require("vim.ui")._get_urls()
        if vim.startswith(urls[1], "http") then
            vim.cmd([[
            amenu enable PopUp.URL
        ]])
        end
    end,
})

vim.opt.laststatus = 3

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        "https://github.com/junegunn/fzf.vim",
        build = "./install --all",
        dependencies = {
            "https://github.com/junegunn/fzf",
        },
        keys = {
            { "<Leader><Leader>", "<Cmd>Files<CR>", desc = "Find files" },
            { "<Leader>,", "<Cmd>Buffers<CR>", desc = "Find buffers" },
            { "<Leader>/", "<Cmd>Rg<CR>", desc = "Search project" },
        },
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
        "https://github.com/stevearc/oil.nvim",
        config = function()
            require("oil").setup()
        end,
        keys = {
            { "-", "<Cmd>Oil<CR>", desc = "Browse files from here" },
        },
    },
     {
        "https://github.com/windwp/nvim-autopairs",
        event = "InsertEnter", -- Only load when you enter Insert mode
        config = function()
            require("nvim-autopairs").setup()
        end,
    },
    {
        "https://github.com/numToStr/Comment.nvim",
        event = "VeryLazy", -- Special lazy.nvim event for things that can load later and are not important for the initial UI
        config = function()
            require("Comment").setup()
        end,
    },
    {
        "https://github.com/VonHeikemen/lsp-zero.nvim",
        dependencies = {
            "https://github.com/williamboman/mason.nvim",
            "https://github.com/williamboman/mason-lspconfig.nvim",
            "https://github.com/neovim/nvim-lspconfig",
            "https://github.com/hrsh7th/cmp-nvim-lsp",
            "https://github.com/hrsh7th/nvim-cmp",
            "https://github.com/L3MON4D3/LuaSnip",
        },
        config = function()
            local lsp_zero = require('lsp-zero')

            lsp_zero.on_attach(function(client, bufnr)
                lsp_zero.default_keymaps({buffer = bufnr})
            end)

            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    -- See https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
                    "gopls", -- Go
                    "pyright", -- Python
                    "lua_ls",
                },
                handlers = {
                    lsp_zero.default_setup,
                },
            })
        end,
    },
    {
        "mbbill/undotree",
        enabled = true,
        config = function()
            vim.keymap.set("n", "<space>u", vim.cmd.UndotreeToggle)
        end
    },
})


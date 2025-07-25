return {
	{
		"mason-org/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"rust_analyzer",
					"gopls",
					"pyright",
					"clangd",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			local builtin = require("telescope.builtin")
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			lspconfig.lua_ls.setup({ capabilities = capabilities })
			lspconfig.rust_analyzer.setup({ capabilities = capabilities })
			lspconfig.gopls.setup({ capabilities = capabilities })
			lspconfig.pyright.setup({ capabilities = capabilities })
			lspconfig.clangd.setup({ capabilities = capabilities })

			vim.keymap.set("n", "gd", builtin.lsp_definitions, {})
			vim.keymap.set("n", "gr", builtin.lsp_references, {})
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "<space>r", vim.lsp.buf.rename, {})
		end,
	},
	vim.diagnostic.config({ virtual_text = true, virtual_lines = false }),
    vim.api.nvim_create_autocmd("BufWritePre", {
        callback = function()
            local filetype = vim.bo.filetype
            if filetype == "go" then
                vim.lsp.buf.format()
            end
        end
    })
}

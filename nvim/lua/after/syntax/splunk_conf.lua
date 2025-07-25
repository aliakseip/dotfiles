vim.api.nvim_set_hl(0, "splunkStanza", { link = "Keyword" })
vim.api.nvim_set_hk(0, "splunkKeyValue", { link = "Identifier" })
vim.api.nvim_set_hl(0, "dplunkComment", { link = "Comment" })

local augroup = vim.api.nvim_create_augroup("SplunkConfSyntax", { clear = true })

local function highlight_splunk_conf(bufnr)
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
	for i, line in ipairs(lines) do
		if line:match("^%[.*%]") then
			vim.api.nvim_buf_add_highlight(bufnr, -1, "splunkStanza", i - 1, 0, -1)
		elseif line:match("^%s*%w+%s*=%s*%S+") then
			vim.api.nvim_buf_add_highlight(bufnr, -1, "splunkKeyValue", i - 1, 0, -1)
		elseif line:match("^#.*") then
			vim.api.nvim_buf_add_highlight(bufnr, -1, "splunkComment", i - 1, 0, -1)
		end
	end
end

vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	pattern = "splunk_conf",
	callback = function()
		local bufnr = vim.api.nvim_get_current_buf()
		highlight_splunk_conf(bufnr)
	end,
})

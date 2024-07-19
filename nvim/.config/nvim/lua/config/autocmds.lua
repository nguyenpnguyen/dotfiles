-- Set python indent to 4 spaces
--[[ vim.api.nvim_create_autocmd("FileType", {
	desc = "Set indent for Python files to 4 spaces",
	pattern = "python",
	callback = function()
		vim.bo.expandtab = true
		vim.bo.smartindent = true
		vim.bo.tabstop = 4
		vim.bo.shiftwidth = 4
	end,
}) ]]

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

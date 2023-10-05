-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.ejs",
  command = "set filetype=ejs",
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.md", "*.html", "*.ejs", "*.tex" },
  command = "setlocal wrap",
})

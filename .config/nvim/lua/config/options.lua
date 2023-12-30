-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local o = vim.o

o.expandtab = true
o.smartindent = true
o.tabstop = 4
o.shiftwidth = 4

vim.g.maplocalleader = ","

-- Vimtex configuration
vim.g.vimtex_compiler_method = "latexmk"
vim.g.vimtex_view_method = "skim"
vim.g.tex_flavor = "latex"

-- Set indentation to 2 for specific filetypes
vim.api.nvim_create_augroup('setIndent', { clear = true })
vim.api.nvim_create_autocmd('Filetype', {
  group = 'setIndent',
  pattern = { 'xml', 'html', 'xhtml', 'css', 'scss', 'javascript', 'typescript', 'json', 'yaml', 'lua', 'jsx', 'tsx',
    'typescriptreact', 'javascriptreact', 'java', 'templ', 'svelte'
  },
  command = 'setlocal shiftwidth=2 tabstop=2'
})

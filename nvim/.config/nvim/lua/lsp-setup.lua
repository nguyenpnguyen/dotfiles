local lsp_ok, lsp = pcall(require, "lspconfig")
if not lsp_ok then
  return
end

local cmq_ok, _ = pcall(require, "cmp_nvim_lsp")
if not cmq_ok then
  return
end

local opts = { noremap = true, silent = true }
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

---------------
--- keymaps ---
---------------
vim.keymap.set(
  "n",
  "d/",
  vim.diagnostic.setloclist,
  vim.tbl_extend("force", opts, { desc = "Lsp send diagnostics to loc list" })
)
vim.keymap.set(
  "n",
  "<leader>df",
  vim.diagnostic.open_float,
  vim.tbl_extend("force", opts, { desc = "Lsp show diagnostic in floating window" })
)

local on_attach = function(client, bufnr)
  vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

  --- toggle inlay hints
  vim.g.inlay_hints_visible = false
  local function toggle_inlay_hints()
    if vim.g.inlay_hints_visible then
      vim.g.inlay_hints_visible = false
      vim.lsp.inlay_hint(bufnr, false)
    else
      if client.server_capabilities.inlayHintProvider then
        vim.g.inlay_hints_visible = true
        vim.lsp.inlay_hint(bufnr, true)
      else
        print("no inlay hints available")
      end
    end
  end

  --- toggle diagnostics
  vim.g.diagnostics_visible = true
  local function toggle_diagnostics()
    if vim.g.diagnostics_visible then
      vim.g.diagnostics_visible = false
      vim.diagnostic.enabled(false, {})
    else
      vim.g.diagnostics_visible = true
      vim.diagnostic.enable()
    end
  end

  --- autocmd to show diagnostics on CursorHold
  vim.api.nvim_create_autocmd("CursorHold", {
    buffer = bufnr,
    desc = "✨lsp show diagnostics on CursorHold",
    callback = function()
      local hover_opts = {
        focusable = false,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        border = "rounded",
        source = "always",
        prefix = " ",
      }
      vim.diagnostic.open_float(nil, hover_opts)
    end,
  })

  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", bufopts, { desc = "✨lsp hover for docs" }))
  vim.keymap.set(
    "n",
    "gD",
    vim.lsp.buf.declaration,
    vim.tbl_extend("force", bufopts, { desc = "✨lsp go to declaration" })
  )
  vim.keymap.set(
    "n",
    "gd",
    vim.lsp.buf.definition,
    vim.tbl_extend("force", bufopts, { desc = "✨lsp go to definition" })
  )
  vim.keymap.set(
    "n",
    "gt",
    vim.lsp.buf.type_definition,
    vim.tbl_extend("force", bufopts, { desc = "✨lsp go to type definition" })
  )
  vim.keymap.set(
    "n",
    "gi",
    vim.lsp.buf.implementation,
    vim.tbl_extend("force", bufopts, { desc = "✨lsp go to implementation" })
  )
  vim.keymap.set("n", "rn", function()
    return ":IncRename " .. vim.fn.expand("<cword>")
  end, { expr = true })
  vim.keymap.set(
    "n",
    "gr",
    vim.lsp.buf.references,
    vim.tbl_extend("force", bufopts, { desc = "✨lsp go to references" })
  )
  vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, vim.tbl_extend("force", bufopts, { desc = "✨lsp format" }))
  vim.keymap.set(
    "n",
    "<leader>l",
    toggle_diagnostics,
    vim.tbl_extend("force", bufopts, { desc = "✨lsp toggle diagnostics" })
  )
  vim.keymap.set(
    "n",
    "<leader>dh",
    toggle_inlay_hints,
    vim.tbl_extend("force", bufopts, { desc = "✨lsp toggle inlay hints" })
  )
  vim.keymap.set(
    "n",
    "<leader>a",
    "<cmd>CodeActionMenu<CR>",
    vim.tbl_extend("force", bufopts, { desc = "✨lsp code action" })
  )
end

vim.lsp.set_log_level("debug")

-- document existing key chains
require('which-key').register {
  ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
  ['<leader>d'] = { name = '[D]iagnostic', _ = 'which_key_ignore' },
  ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
  ['<leader>h'] = { name = 'Git [H]unk', _ = 'which_key_ignore' },
  ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
  ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
  ['<leader>t'] = { name = '[T]oggle', _ = 'which_key_ignore' },
  ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
}
-- register which-key VISUAL mode
-- required for visual <leader>hs (hunk stage) to work
require('which-key').register({
  ['<leader>'] = { name = 'VISUAL <leader>' },
  ['<leader>h'] = { 'Git [H]unk' },
}, { mode = 'v' })

-- mason-lspconfig requires that these setup functions are called in this order
-- before setting up the servers.
require('mason').setup()
require('mason-lspconfig').setup()

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
local servers = {
  clangd = {},
  gopls = {},
  pyright = {},
  rust_analyzer = {},
  tsserver = { 'javascript', 'typescript', 'react', 'svelte' },
  cssls = { 'css', 'svelte' },
  html = { filetypes = { 'html', 'twig', 'hbs', 'templ', 'svelte' } },
  templ = { filetypes = { 'templ', 'go' } },
  tailwindcss = {
    filetypes = { 'html', 'templ', 'astro', 'javascript', 'typescript', 'react', 'svelte' },
    init_options = { userLanguages = { templ = "html" } }
  },
  htmx = { filetypes = { 'html', 'templ' }
  },

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
      diagnostics = { disable = { 'missing-fields' } },
    },
  },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
  end,
}

-- Language specific LSP setup
-- May need to investigate a better way to do this

lsp.tsserver.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "javascript", "typescript", "react", "svelte" },
})

lsp.cssls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "html", "react", "svelte", "templ", "astro" },
})

lsp.html.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "html", "templ", "svelte" },
})

lsp.htmx.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "html", "templ" },
})

lsp.tailwindcss.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "templ", "astro", "javascript", "typescript", "react", "svelte" },
  init_options = { userLanguages = { templ = "html" } },
})

lsp.jdtls.setup({
  settings = {
    java = {
      configuration = {
        runtimes = {
          {
            name = "Java",
            path = "$JAVA",
            default = true,
          }
        }
      }
    }
  }
})
-- vim: ts=2 sts=2 sw=2 et

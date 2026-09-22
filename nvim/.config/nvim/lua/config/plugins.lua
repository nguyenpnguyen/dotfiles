local map = vim.keymap.set

vim.cmd.colorscheme("catppuccin-mocha")

require("Comment").setup()
require("todo-comments").setup({ signs = false })
require("gitsigns").setup({
	signs = {
		add = { text = "+" },
		change = { text = "~" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
	},
})

local harpoon = require("harpoon")
harpoon:setup()
map("n", "<leader>a", function()
	harpoon:list():add()
end, { desc = "[A]dd current file to harpoon" })
map("n", "<C-e>", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Toggle harpoon quick menu" })
for i, key in ipairs({ "h", "j", "k", "l" }) do
	map("n", "<leader>" .. key, function()
		harpoon:list():select(i)
	end, { desc = "Select harpoon list item " .. i })
end
map("n", "<leader>[", function()
	harpoon:list():prev()
end, { desc = "Go to previous buffer in harpoon list" })
map("n", "<leader>]", function()
	harpoon:list():next()
end, { desc = "Go to next buffer in harpoon list" })

require("jupytext").setup({
	style = "markdown",
	output_extension = "md",
	force_ft = "markdown",
})

require("oil").setup({
	view_options = { show_hidden = true },
})
map("n", "<leader>o", "<Cmd>Oil<CR>", { silent = true, desc = "Open Oil" })
map("n", "<leader>e", "<Cmd>Oil --float<CR>", { silent = true, desc = "Open Oil in a float" })

require("conform").setup({
	notify_on_error = true,
	format_on_save = function(bufnr)
		return { timeout_ms = 2000, lsp_fallback = true }
	end,
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "ruff" },
		javascript = { "prettierd", "prettier" },
		typescript = { "prettierd", "prettier" },
		jsx = { "prettierd", "prettier", "rustywind" },
		tsx = { "prettierd", "prettier", "rustywind" },
		html = { "htmlbeautifier", "rustywind" },
		css = { "stylelint" },
		yaml = { "prettierd", "prettier" },
		json = { "prettierd", "prettier" },
		markdown = { "prettierd", "prettier" },
	},
})
map("n", "<leader>f", function()
	require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "[F]ormat buffer" })

local lint = require("lint")
lint.linters_by_ft = {
	javascript = { "eslint_d" },
	typescript = { "eslint_d" },
	css = { "stylelint" },
	python = { "ruff" },
}
local lint_group = vim.api.nvim_create_augroup("lint", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
	group = lint_group,
	callback = function()
		lint.try_lint()
	end,
})

local treesitter = require("nvim-treesitter")
treesitter.setup()
local tree_sitter_languages = {
	"bash",
	"c",
	"css",
	"diff",
	"html",
	"javascript",
	"json",
	"lua",
	"luadoc",
	"markdown",
	"python",
	"tsx",
	"typescript",
	"vim",
	"vimdoc",
	"yaml",
}
local function install_treesitter()
	if vim.fn.executable("tree-sitter") == 1 then
		treesitter.install(tree_sitter_languages)
	end
end
vim.api.nvim_create_autocmd("User", {
	pattern = "MasonToolsUpdateCompleted",
	callback = install_treesitter,
})
install_treesitter()
vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function(event)
		if pcall(vim.treesitter.start, event.buf) then
			vim.wo.foldmethod = "expr"
			vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
		end
	end,
})
require("nvim-ts-autotag").setup({})
require("nvim-treesitter-textobjects").setup({
	select = { lookahead = true },
	move = { set_jumps = false },
})
local ts_select = require("nvim-treesitter-textobjects.select")
local ts_move = require("nvim-treesitter-textobjects.move")
local ts_swap = require("nvim-treesitter-textobjects.swap")
map({ "x", "o" }, "ib", function()
	ts_select.select_textobject("@code_cell.inner", "textobjects")
end, { desc = "Select code block" })
map({ "x", "o" }, "ab", function()
	ts_select.select_textobject("@code_cell.outer", "textobjects")
end, { desc = "Select code block" })
map({ "n", "x", "o" }, "]b", function()
	ts_move.goto_next_start("@code_cell.inner", "textobjects")
end, { desc = "Next code block" })
map({ "n", "x", "o" }, "[b", function()
	ts_move.goto_previous_start("@code_cell.inner", "textobjects")
end, { desc = "Previous code block" })
map("n", "<leader>sbl", function()
	ts_swap.swap_next("@code_cell.outer", "textobjects")
end, { desc = "Swap with next code block" })
map("n", "<leader>sbh", function()
	ts_swap.swap_previous("@code_cell.outer", "textobjects")
end, { desc = "Swap with previous code block" })

require("mini.ai").setup({ n_lines = 500 })
require("mini.surround").setup()
local statusline = require("mini.statusline")
statusline.setup({ use_icons = vim.g.have_nerd_font })
statusline.section_location = function()
	return "%2l:%-2v"
end
require("mini.pairs").setup()
require("mini.tabline").setup()
require("mini.diff").setup()
local minimap = require("mini.map")
minimap.setup()
map("n", "<leader>mt", minimap.toggle, { desc = "Toggle minimap" })
map("n", "<leader>mf", minimap.toggle_focus, { desc = "Toggle focus minimap" })
map("n", "<leader>mr", minimap.refresh, { desc = "Refresh minimap" })

local cmp = require("cmp")
local luasnip = require("luasnip")
luasnip.config.setup({})
require("luasnip.loaders.from_vscode").lazy_load()
cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	completion = { completeopt = "menu,menuone,noinsert" },
	mapping = cmp.mapping.preset.insert({
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-y>"] = cmp.mapping.confirm({ select = true }),
		["<C-Space>"] = cmp.mapping.complete({}),
		["<C-l>"] = cmp.mapping(function()
			if luasnip.expand_or_locally_jumpable() then
				luasnip.expand_or_jump()
			end
		end, { "i", "s" }),
		["<C-h>"] = cmp.mapping(function()
			if luasnip.locally_jumpable(-1) then
				luasnip.jump(-1)
			end
		end, { "i", "s" }),
	}),
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "path" },
	},
})

require("mason").setup()
require("mason-tool-installer").setup({
	ensure_installed = {
		"lua-language-server",
		"ruff",
		"ty",
		"typescript-language-server",
		"css-lsp",
		"html-lsp",
		"json-lsp",
		"tree-sitter-cli",
		"stylua",
		"rustywind",
		"prettierd",
	},
})
require("fidget").setup({})

local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
lsp_capabilities.textDocument.completion.completionItem.snippetSupport = true
vim.lsp.config("*", { capabilities = lsp_capabilities })

local lsp_group = vim.api.nvim_create_augroup("nvim-lsp-attach", { clear = true })
vim.api.nvim_create_autocmd("LspAttach", {
	group = lsp_group,
	callback = function(event)
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		local lsp_map = function(keys, fn, desc)
			map("n", keys, fn, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		local telescope = require("telescope.builtin")
		lsp_map("gd", telescope.lsp_definitions, "[G]oto [D]efinition")
		lsp_map("gr", telescope.lsp_references, "[G]oto [R]eferences")
		lsp_map("gI", telescope.lsp_implementations, "[G]oto [I]mplementation")
		lsp_map("<leader>D", telescope.lsp_type_definitions, "Type [D]efinition")
		lsp_map("<leader>ds", telescope.lsp_document_symbols, "[D]ocument [S]ymbols")
		lsp_map("<leader>ws", telescope.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
		lsp_map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
		lsp_map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
		lsp_map("K", vim.lsp.buf.hover, "Hover Documentation")
		lsp_map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

		if client and client:supports_method("textDocument/documentHighlight") then
			local highlight_group = vim.api.nvim_create_augroup("nvim-lsp-highlight", { clear = false })
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				group = highlight_group,
				callback = vim.lsp.buf.document_highlight,
			})
			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				group = highlight_group,
				callback = vim.lsp.buf.clear_references,
			})
			vim.api.nvim_create_autocmd("LspDetach", {
				group = vim.api.nvim_create_augroup("nvim-lsp-detach", { clear = true }),
				callback = function(detach)
					vim.lsp.buf.clear_references()
					vim.api.nvim_clear_autocmds({ group = highlight_group, buffer = detach.buf })
				end,
			})
		end

		if client and client.server_capabilities.inlayHintProvider then
			lsp_map("<leader>th", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
			end, "[T]oggle Inlay [H]ints")
		end
	end,
})

local servers = {
	ruff = {
		cmd = { "ruff", "server" },
		filetypes = { "python" },
		root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" },
	},
	ty = {
		cmd = { "ty", "server" },
		filetypes = { "python" },
		root_markers = { "ty.toml", "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
		settings = {
			ty = {
				diagnosticMode = "workspace",
				experimental = { autoImport = true },
			},
		},
	},
	ts_ls = {
		cmd = { "typescript-language-server", "--stdio" },
		filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
		root_markers = { { "package-lock.json", "yarn.lock", "pnpm-lock.yaml", "bun.lockb", "bun.lock" }, ".git" },
	},
	cssls = {
		cmd = { "vscode-css-language-server", "--stdio" },
		filetypes = { "css", "scss", "less" },
		root_markers = { "package.json", ".git" },
		init_options = { provideFormatter = true },
	},
	html = {
		cmd = { "vscode-html-language-server", "--stdio" },
		filetypes = { "html" },
		root_markers = { "package.json", ".git" },
		init_options = {
			provideFormatter = true,
			embeddedLanguages = { css = true, javascript = true },
			configurationSection = { "html", "css", "javascript" },
		},
	},
	jsonls = {
		cmd = { "vscode-json-language-server", "--stdio" },
		filetypes = { "json", "jsonc" },
		root_markers = { ".git" },
		init_options = { provideFormatter = true },
	},
	lua_ls = {
		cmd = { "lua-language-server" },
		filetypes = { "lua" },
		root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },
		settings = {
			Lua = {
				runtime = { version = "LuaJIT" },
				workspace = {
					checkThirdParty = false,
					library = { vim.env.VIMRUNTIME, vim.fn.stdpath("config") },
				},
				completion = { callSnippet = "Replace" },
				diagnostics = { disable = { "missing-fields" } },
			},
		},
	},
}
for name, config in pairs(servers) do
	vim.lsp.config(name, config)
end
vim.lsp.enable(vim.tbl_keys(servers))

local peek = require("peek")
peek.setup({ theme = "light" })
vim.api.nvim_create_user_command("PeekOpen", peek.open, {})
vim.api.nvim_create_user_command("PeekClose", peek.close, {})
require("render-markdown").setup({})

local telescope = require("telescope")
telescope.setup({
	defaults = { mappings = { i = { ["<C-Enter>"] = "to_fuzzy_refine" } } },
	extensions = { ["ui-select"] = { require("telescope.themes").get_dropdown() } },
})
pcall(telescope.load_extension, "fzf")
pcall(telescope.load_extension, "ui-select")
local builtin = require("telescope.builtin")
map("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
map("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
map("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
map("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
map("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
map("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
map("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
map("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
map("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
map("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
map("n", "<leader>/", function()
	builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({ winblend = 10, previewer = false }))
end, { desc = "[/] Fuzzily search in current buffer" })
map("n", "<leader>s/", function()
	builtin.live_grep({ grep_open_files = true, prompt_title = "Live Grep in Open Files" })
end, { desc = "[S]earch [/] in Open Files" })
map("n", "<leader>sn", function()
	builtin.find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = "[S]earch [N]eovim files" })

local snacks = require("snacks")
snacks.setup({
	animate = { enabled = true },
	bigfile = { enabled = true },
	dashboard = { enabled = true },
	bufdelete = { enabled = true },
	indent = { enabled = true },
	input = { enabled = true },
	image = { enabled = true },
	notifier = { enabled = true, timeout = 3000 },
	quickfile = { enabled = true },
	scope = { enabled = true },
	scroll = { enabled = true },
	statuscolumn = { enabled = true },
	words = { enabled = true },
	git = { enabled = true },
	gitbrowse = { enabled = true },
	lazygit = { enabled = true },
	terminal = { enabled = true },
})
map("n", "<leader>.", function()
	Snacks.scratch()
end, { desc = "Toggle Scratch Buffer" })
map("n", "<leader>S", function()
	Snacks.scratch.select()
end, { desc = "Select Scratch Buffer" })
map("n", "<leader>n", function()
	Snacks.notifier.show_history()
end, { desc = "Notification History" })
map("n", "<leader>bd", function()
	Snacks.bufdelete()
end, { desc = "Delete Buffer" })
map("n", "<leader>cR", function()
	Snacks.rename.rename_file()
end, { desc = "Rename File" })
map({ "n", "v" }, "<leader>gB", function()
	Snacks.gitbrowse()
end, { desc = "Git Browse" })
map("n", "<leader>gg", function()
	Snacks.lazygit()
end, { desc = "Lazygit" })
map("n", "<leader>un", function()
	Snacks.notifier.hide()
end, { desc = "Dismiss All Notifications" })
map("n", "<C-/>", function()
	Snacks.terminal()
end, { desc = "Toggle Terminal" })
map("n", "<C-_>", function()
	Snacks.terminal()
end, { desc = "which_key_ignore" })
map({ "n", "t" }, "]]", function()
	Snacks.words.jump(vim.v.count1)
end, { desc = "Next Reference" })
map({ "n", "t" }, "[[", function()
	Snacks.words.jump(-vim.v.count1)
end, { desc = "Prev Reference" })
map("n", "<leader>N", function()
	Snacks.win({
		file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
		width = 0.6,
		height = 0.6,
		wo = { spell = false, wrap = false, signcolumn = "yes", statuscolumn = " ", conceallevel = 3 },
	})
end, { desc = "Neovim News" })

require("which-key").setup()
require("which-key").add({
	{ "<leader>c", group = "[C]ode" },
	{ "<leader>d", group = "[D]ocument" },
	{ "<leader>r", group = "[R]ename" },
	{ "<leader>s", group = "[S]earch" },
	{ "<leader>w", group = "[W]orkspace" },
	{ "<leader>t", group = "[T]oggle" },
	{ "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
})

return {
	"stevearc/conform.nvim",
	lazy = false,
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = "",
			desc = "[F]ormat buffer",
		},
	},
	opts = {
		notify_on_error = true,
		format_on_save = function(bufnr)
			-- disable "format_on_save lsp_fallback" for languages that don't
			-- have a well standardized coding style. you can add additional
			-- languages here or re-enable it for the disabled ones.
			local disable_filetypes = {}
			return {
				timeout_ms = 500,
				lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
			}
		end,
		formatters_by_ft = {
			-- c = { "clangd" },
			-- cpp = { "clangd" },
			lua = { "stylua" },
			python = { "ruff" },
			javascript = { "prettierd", "prettier" },
			typescript = { "prettierd", "prettier" },
			jsx = { "prettierd", "prettier", "rustywind" },
			tsx = { "prettierd", "prettier", "rustywind" },
			go = { "gofmt", "goimports" },
			html = { "htmlbeautifier", "rustywind" },
			css = { "stylelint" },
			yaml = { "prettierd", "prettier" },
			json = { "prettierd", "prettier" },
			markdown = { "markdownlint" },
		},
	},
}

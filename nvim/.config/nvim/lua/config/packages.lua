local builds = {
	["LuaSnip"] = { "make", "install_jsregexp" },
	["telescope-fzf-native.nvim"] = { "make" },
	["peek.nvim"] = { "deno", "task", "--quiet", "build:fast" },
}

vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(event)
		local data = event.data
		local command = builds[data.spec.name]
		if (data.kind ~= "install" and data.kind ~= "update") or not command then
			return
		end
		if vim.fn.executable(command[1]) == 0 then
			return
		end

		local result = vim.system(command, { cwd = data.path, text = true }):wait()
		if result.code ~= 0 then
			vim.notify(
				("vim.pack build failed for %s:\n%s"):format(data.spec.name, result.stderr or ""),
				vim.log.levels.WARN
			)
		end
	end,
})

local function github(repo, name)
	local spec = { src = "https://github.com/" .. repo }
	if name then
		spec.name = name
	end
	return spec
end

vim.pack.add({
	github("catppuccin/nvim", "catppuccin"),
	github("windwp/nvim-ts-autotag"),
	github("hrsh7th/nvim-cmp"),
	github("L3MON4D3/LuaSnip"),
	github("rafamadriz/friendly-snippets"),
	github("saadparwaiz1/cmp_luasnip"),
	github("hrsh7th/cmp-path"),
	github("stevearc/conform.nvim"),
	github("tpope/vim-fugitive"),
	github("tpope/vim-rhubarb"),
	github("lewis6991/gitsigns.nvim"),
	github("ThePrimeagen/harpoon"),
	github("nvim-lua/plenary.nvim"),
	github("GCBallesteros/jupytext.nvim"),
	github("mfussenegger/nvim-lint"),
	github("williamboman/mason.nvim"),
	github("WhoIsSethDaniel/mason-tool-installer.nvim"),
	github("j-hui/fidget.nvim"),
	github("toppair/peek.nvim"),
	github("MeanderingProgrammer/render-markdown.nvim"),
	github("echasnovski/mini.nvim"),
	github("tpope/vim-sleuth"),
	github("numToStr/Comment.nvim"),
	github("folke/todo-comments.nvim"),
	github("stevearc/oil.nvim"),
	github("nvim-tree/nvim-web-devicons"),
	github("folke/snacks.nvim"),
	github("nvim-telescope/telescope.nvim"),
	github("nvim-telescope/telescope-fzf-native.nvim"),
	github("nvim-telescope/telescope-ui-select.nvim"),
	github("nvim-treesitter/nvim-treesitter"),
	github("nvim-treesitter/nvim-treesitter-textobjects"),
	github("christoomey/vim-tmux-navigator"),
	github("folke/which-key.nvim"),
}, { confirm = false, load = true })

vim.api.nvim_create_user_command("PackUpdate", function()
	vim.pack.update()
end, { desc = "Update native packages" })

return {
	"stevearc/oil.nvim",
	opts = {
		view_options = {
			show_hidden = true,
		},
		--Toggle oil
		vim.keymap.set("n", "<leader>o", "<Cmd>Oil<CR>", { silent = true }),
		vim.keymap.set("n", "<leader>e", "<Cmd>Oil --float<CR>", { silent = true }),
	},
	-- Optional dependencies
	dependencies = { "nvim-tree/nvim-web-devicons" },
}

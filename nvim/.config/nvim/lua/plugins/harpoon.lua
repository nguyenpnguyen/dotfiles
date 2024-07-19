return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("harpoon"):setup()
	end,
	keys = {
		{
			"<leader>a",
			function()
				require("harpoon"):list():add()
			end,
			desc = "[A]dd current file to harpoon",
		},
		{
			"<C-e>",
			function()
				local harpoon = require("harpoon")
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end,
			desc = "Toggle harpoon quick menu",
		},
		{
			"<leader>h",
			function()
				require("harpoon"):list():select(1)
			end,
			desc = "Select harpoon list item 1",
		},
		{
			"<leader>j",
			function()
				require("harpoon"):list():select(2)
			end,
			desc = "Select harpoon list item 2",
		},
		{
			"<leader>k",
			function()
				require("harpoon"):list():select(3)
			end,
			desc = "Select harpoon list item 3",
		},
		{
			"<leader>l",

			function()
				require("harpoon"):list():select(4)
			end,
			desc = "Select harpoon list item 4",
		},
		{
			"<leader>[",
			function()
				require("harpoon"):list():prev()
			end,
			desc = "Go to previous buffer in harpoon list",
		},
		{
			"<leader>]",

			function()
				require("harpoon"):list():prev()
			end,
			desc = "Go to next buffer in harpoon list",
		},
	},
}

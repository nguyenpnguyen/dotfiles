return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local map = vim.keymap.set
		local harpoon = require("harpoon")
		harpoon:setup()

		-- Harpoon keymaps
		map("n", "<leader>a", function()
			harpoon:list():add()
		end, { desc = "Add current file to harpoon" })

		map("n", "<C-e>", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end)

		map("n", "<C-h>", function()
			harpoon:list():select(1)
		end)
		map("n", "<C-j>", function()
			harpoon:list():select(2)
		end)
		map("n", "<C-k>", function()
			harpoon:list():select(3)
		end)
		map("n", "<C-l>", function()
			harpoon:list():select(4)
		end)

		-- Toggle previous & next buffers stored within Harpoon list
		map("n", "<leader>[", function()
			harpoon:list():prev()
		end, { desc = "Go to previous buffer in harpoon list" })
		map("n", "<leader>]", function()
			harpoon:list():next()
		end, { desc = "Go to next buffer in harpoon list" })
	end,
}

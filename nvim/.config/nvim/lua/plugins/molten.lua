return {
	"benlubas/molten-nvim",
	version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
	dependencies = { "3rd/image.nvim" },
	build = ":UpdateRemotePlugins",
	init = function()
		-- these are examples, not defaults. Please see the readme
		vim.g.molten_image_provider = "image.nvim"
		vim.g.molten_output_win_max_height = 20
		vim.g.molten_wrap_output = true
		vim.g.molten_virt_text_output = true
		vim.g.molten_virt_lines_off_by_1 = true
		vim.keymap.set(
			"n",
			"<localleader>e",
			":MoltenEvaluateOperator<CR>",
			{ desc = "evaluate operator", silent = true }
		)
		vim.keymap.set(
			"n",
			"<localleader>os",
			":noautocmd MoltenEnterOutput<CR>",
			{ desc = "open output window", silent = true }
		)
		vim.keymap.set("n", "<localleader>rr", ":MoltenReevaluateCell<CR>", { desc = "re-eval cell", silent = true })
		vim.keymap.set(
			"v",
			"<localleader>r",
			":<C-u>MoltenEvaluateVisual<CR>gv",
			{ desc = "execute visual selection", silent = true }
		)
		vim.keymap.set("n", "<localleader>oh", ":MoltenHideOutput<CR>", { desc = "close output window", silent = true })
		vim.keymap.set("n", "<localleader>md", ":MoltenDelete<CR>", { desc = "delete Molten cell", silent = true })

		-- if you work with html outputs:
		vim.keymap.set(
			"n",
			"<localleader>mx",
			":MoltenOpenInBrowser<CR>",
			{ desc = "open output in browser", silent = true }
		)
	end,
}

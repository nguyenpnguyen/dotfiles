return
{
	'akinsho/toggleterm.nvim',
	version = "*",
	opts = {
		size = function(term)
			if term.direction == "horizontal" then
				return 10
			elseif term.direction == "vertical" then
				return vim.o.columns * 0.3
			end
		end,
		open_mapping = [[<leader>t]],
		autochdir = true,
		direction = 'vertical',
		shade_terminals = false,
		insert_mappings = false,
	}
}

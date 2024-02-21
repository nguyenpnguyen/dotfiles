return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require('harpoon'):setup()
  end,
  keys = {
    { '<leader>hx', function() require('harpoon'):list():append() end,                                 desc = 'Add file to harpoon' },
    { '<leader>hm', function() require('harpoon').ui:toggle_quick_menu(require('harpoon'):list()) end, desc = 'Open harpoon menu' },
    { '<leader>1',  function() require('harpoon'):list():select(1) end,                                desc = 'Go to harpoon file 1' },
    { '<leader>2',  function() require('harpoon'):list():select(2) end,                                desc = 'Go to harpoon file 2' },
    { '<leader>3',  function() require('harpoon'):list():select(3) end,                                desc = 'Go to harpoon file 3' },
    { '<leader>4',  function() require('harpoon'):list():select(4) end,                                desc = 'Go to harpoon file 4' },
    { '<leader>5',  function() require('harpoon'):list():select(5) end,                                desc = 'Go to harpoon file 5' },
    { '<leader>6',  function() require('harpoon'):list():prev() end,                                   desc = 'Go to previous harpoon file' },
    { '<leader>7',  function() require('harpoon'):list():next() end,                                   desc = 'Go to next harpoon file' },
  }
}

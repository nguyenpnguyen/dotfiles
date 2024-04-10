return {
  "echasnovski/mini.starter",
  opts = {
    items = { { name = "", action = "", section = "" } },
    header = function()
      local nonsense = string.format(
        "%s\n%s\n%s",
        -- stylua: ignore
        "I use neovim btw",
        "and arch as well btw",
        "with a tiling window manager, btw"
      )
      return nonsense
    end,
    footer = "btw",
  },
}

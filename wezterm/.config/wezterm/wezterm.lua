local wezterm = require("wezterm")
local act = wezterm.action
local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- Color scheme
config.color_scheme = "Catppuccin Macchiato"

-- Tab config
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true

config.inactive_pane_hsb = {
	saturation = 0.7,
	brightness = 0.6,
}
-- Font config
config.font = wezterm.font("FiraCode Nerd Font")
config.font_size = 15.0

-- Keybindings
-- timeout_milliseconds defaults to 1000 and can be omitted
config.leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
	-- Split pane
	{
		key = "|",
		mods = "LEADER",
		action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "_",
		mods = "LEADER",
		action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
	},

	-- Move pane focus
	{
		key = "h",
		mods = "CMD|SHIFT",
		action = act.ActivatePaneDirection("Left"),
	},
	{
		key = "l",
		mods = "CMD|SHIFT",
		action = act.ActivatePaneDirection("Right"),
	},
	{
		key = "k",
		mods = "CMD|SHIFT",
		action = act.ActivatePaneDirection("Up"),
	},
	{
		key = "j",
		mods = "CMD|SHIFT",
		action = act.ActivatePaneDirection("Down"),
	},

	-- Adjust pane size
	{
		key = "h",
		mods = "LEADER",
		action = act.AdjustPaneSize({ "Left", 5 }),
	},
	{
		key = "j",
		mods = "LEADER",
		action = act.AdjustPaneSize({ "Down", 5 }),
	},
	{ key = "k", mods = "LEADER", action = act.AdjustPaneSize({ "Up", 5 }) },
	{
		key = "l",
		mods = "LEADER",
		action = act.AdjustPaneSize({ "Right", 5 }),
	},

	-- Close pane
	{
		key = "w",
		mods = "LEADER",
		action = act.CloseCurrentPane({ confirm = true }),
	},
	{
		key = "w",
		mods = "CTRL",
		action = act.CloseCurrentTab { confirm = false },
	},
	{
		key = "t",
		mods = "CTRL",
		action = act.SpawnTab 'CurrentPaneDomain',
	},
	{
		key = "t",
		mods = "CTRL|SHIFT",
		action = act.SpawnTab {
			DomainName = 'unix',
		},
	},
	-- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
	-- {
	-- 	key = "a",
	-- 	mods = "LEADER|CTRL",
	-- 	action = act.SendKey({ key = "a", mods = "CTRL" }),
	-- },
}

-- Use ctrl modifier for tab switching
for i = 1, 9 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = 'CTRL',
		action = act.ActivateTab(i - 1),
	})

	table.insert(config.keys, {
		key = 'F' .. tostring(i),
		mods = 'CTRL',
		action = act.ActivateTab(i - 1),
	})
end

return config

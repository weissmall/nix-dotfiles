local wezterm = require("wezterm")
local bar = wezterm.plugin.require("https://github.com/adriankarlen/bar.wezterm")

local defaultConfig = {
	position = "bottom",
	max_width = 32,
	padding = {
		left = 1,
		right = 1,
		tabs = {
			left = 0,
			right = 2,
		},
	},
	separator = {
		space = 1,
		left_icon = wezterm.nerdfonts.fa_long_arrow_right,
		right_icon = wezterm.nerdfonts.fa_long_arrow_left,
		field_icon = wezterm.nerdfonts.indent_line,
	},
	modules = {
		tabs = {
			active_tab_fg = 4,
			inactive_tab_fg = 6,
			new_tab_fg = 2,
		},
		workspace = {
			enabled = false,
			icon = wezterm.nerdfonts.cod_window,
			color = 8,
		},
		leader = {
			enabled = true,
			icon = wezterm.nerdfonts.oct_rocket,
			color = 2,
		},
		zoom = {
			enabled = false,
			icon = wezterm.nerdfonts.md_fullscreen,
			color = 4,
		},
		pane = {
			enabled = false,
			icon = wezterm.nerdfonts.cod_multiple_windows,
			color = 7,
		},
		username = {
			enabled = true,
			icon = wezterm.nerdfonts.fa_user,
			color = 6,
		},
		hostname = {
			enabled = false,
			icon = wezterm.nerdfonts.cod_server,
			color = 8,
		},
		clock = {
			enabled = false,
			icon = wezterm.nerdfonts.md_calendar_clock,
			format = "%H:%M",
			color = 5,
		},
		cwd = {
			enabled = true,
			icon = wezterm.nerdfonts.oct_file_directory,
			color = 7,
		},
		spotify = {
			enabled = false,
			icon = wezterm.nerdfonts.fa_spotify,
			color = 3,
			max_width = 64,
			throttle = 15,
		},
	},
}

local function apply(config, opts)
	local finalOpts = opts or defaultConfig
	bar.apply_to_config(config, finalOpts)
end

return {
	apply = apply,
}

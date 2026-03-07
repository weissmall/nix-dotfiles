local w = require("wezterm")
local act = w.action

local M = {
	defaultOpacity = 0.93,
	currentOpacity = 0.93,
	config = nil,
}

function M.setConfig(config)
	M.config = config
end

function M.setKeybinds(config, tables)
	config.leader = M.getLeaderKey()
	M.setKeyTables(config)
	config.keys = {
		{
			key = "r",
			mods = "ALT",
			action = act.PromptInputLine({
				description = "Enter new name for tab",
				action = w.action_callback(function(window, pane, line)
					if line then
						window:active_tab():set_title(line)
					end
				end),
			}),
		},
		{
			key = "h",
			mods = "LEADER",
			action = w.action.SplitPane({
				direction = "Left",
				size = { Percent = 50 },
			}),
		},
		{
			key = "l",
			mods = "LEADER",
			action = w.action.SplitPane({
				direction = "Right",
				size = { Percent = 50 },
			}),
		},
		{
			key = "j",
			mods = "LEADER",
			action = w.action.SplitPane({
				direction = "Down",
				size = { Percent = 50 },
			}),
		},
		{
			key = "k",
			mods = "LEADER",
			action = w.action.SplitPane({
				direction = "Up",
				size = { Percent = 50 },
			}),
		},

		{
			key = "r",
			mods = "LEADER",
			action = act.ActivateKeyTable({
				name = "resize_table",
				one_shot = false,
			}),
		},
		{
			key = "m",
			mods = "LEADER",
			action = act.ActivateKeyTable({
				name = "move_table",
				one_shot = false,
			}),
		},
		{
			key = "t",
			mods = "ALT",
			action = act.ActivateKeyTable({
				name = "tab_mode",
				one_shot = false,
				until_unknown = true,
			}),
		},
		{
			key = "p",
			mods = "ALT",
			action = act.ActivateKeyTable({
				name = "pane_mode",
				one_shot = false,
			}),
		},
		{
			key = "Tab",
			mods = "CTRL",
			action = act.DisableDefaultAssignment,
		},
		{
			key = "t",
			mods = "LEADER",
			action = act.EmitEvent("w-toggle-opacity"),
		},
		{
			key = "o",
			mods = "LEADER",
			action = act.PromptInputLine({
				description = "Enter new opacity",
				action = w.action_callback(function(window, _, line)
					local overrides = window:get_config_overrides() or {}
					if line then
						overrides.window_background_opacity = tonumber(line) / 100
					else
						overrides.window_background_opacity = M.defaultOpacity
					end
					window:set_config_overrides(overrides)
				end),
			}),
		},
	}
end

function M.getLeaderKey()
	return {
		key = "Space",
		mods = "ALT",
		timeout_milliseconds = 2000,
	}
end

function M.unpacked(t)
	return table.unpack(t)
end

function M.getResizeTable()
	return {
		{ key = "LeftArrow", action = act.AdjustPaneSize({ "Left", 1 }) },
		{ key = "h", action = act.AdjustPaneSize({ "Left", 1 }) },

		{ key = "RightArrow", action = act.AdjustPaneSize({ "Right", 1 }) },
		{ key = "l", action = act.AdjustPaneSize({ "Right", 1 }) },

		{ key = "UpArrow", action = act.AdjustPaneSize({ "Up", 1 }) },
		{ key = "k", action = act.AdjustPaneSize({ "Up", 1 }) },

		{ key = "DownArrow", action = act.AdjustPaneSize({ "Down", 1 }) },
		{ key = "j", action = act.AdjustPaneSize({ "Down", 1 }) },

		-- Cancel the mode by pressing escape
		{ key = "Escape", action = "PopKeyTable" },
	}
end

function M.getMoveTable()
	return {
		{ key = "LeftArrow", action = act.ActivatePaneDirection("Left") },
		{ key = "h", action = act.ActivatePaneDirection("Left") },

		{ key = "RightArrow", action = act.ActivatePaneDirection("Right") },
		{ key = "l", action = act.ActivatePaneDirection("Right") },

		{ key = "UpArrow", action = act.ActivatePaneDirection("Up") },
		{ key = "k", action = act.ActivatePaneDirection("Up") },

		{ key = "DownArrow", action = act.ActivatePaneDirection("Down") },
		{ key = "j", action = act.ActivatePaneDirection("Down") },

		-- Cancel the mode by pressing escape
		{ key = "Escape", action = "PopKeyTable" },
	}
end

function M.getTabModeTable()
	return {
		{
			key = "h",
			action = act.ActivateTabRelative(-1),
		},
		{
			key = "l",
			action = act.ActivateTabRelative(1),
		},
		{
			key = "c",
			action = act.CloseCurrentTab({ confirm = true }),
		},
		{
			key = "b",
			action = act.ShowTabNavigator,
		},
		{
			key = "n",
			action = act.SpawnTab("CurrentPaneDomain"),
		},
		{
			key = "Escape",
			action = "PopKeyTable",
		},
	}
end

function M.getPaneModeTable()
	return {
		{
			key = "h",
			action = act.ActivatePaneDirection("Left"),
		},
		{
			key = "j",
			action = act.ActivatePaneDirection("Down"),
		},
		{
			key = "k",
			action = act.ActivatePaneDirection("Up"),
		},
		{
			key = "l",
			action = act.ActivatePaneDirection("Right"),
		},
		{
			key = "Escape",
			action = "PopKeyTable",
		},
	}
end

function M.setKeyTables(config)
	config.key_tables = {
		resize_table = M.getResizeTable(),
		move_table = M.getMoveTable(),
		tab_mode = M.getTabModeTable(),
		pane_mode = M.getPaneModeTable(),
	}
end

w.on("update-right-status", function(window, pane)
	local name = window:active_key_table()
	if name then
		name = "TABLE: " .. name
	end
	window:set_right_status(name or "")
end)

w.on("w-toggle-opacity", function(window, pane)
	local overrides = window:get_config_overrides() or {}
	if not overrides.window_background_opacity or overrides.window_background_opacity == 1 then
		overrides.window_background_opacity = M.defaultOpacity
	else
		overrides.window_background_opacity = 1
	end
	window:set_config_overrides(overrides)
end)

return M

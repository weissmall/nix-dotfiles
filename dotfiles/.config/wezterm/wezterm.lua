local w = require("wezterm")
local ui = require("ui")
local keybings = require("keybinds")
local tabbar = require("tabbar")
local workspaces = require("plugins.workspaces")
local bar = require("plugins.bar")

local config = w.config_builder()
config.window_frame = nil
config.enable_wayland = false
config.window_decorations = "NONE"
config.scrollback_lines = 50000
config.debug_key_events = true
-- config.window_padding = {
-- 	left = 8,
-- 	right = 0,
-- 	top = 0,
-- 	bottom = 0,
-- }

ui.setup(config)
keybings.setConfig(config)
keybings.setKeybinds(config)

tabbar:default():setup(config)
workspaces.apply(config)
bar.apply(config)

return config

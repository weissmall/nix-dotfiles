local wezterm = require("wezterm")

---@class Tabbar
---@field enable boolean
---@field atBottom boolean
---@field zeroBasedIndices boolean
---@field maxWidth integer
local Tabbar = {}

---Main constructor
---@param o Tabbar
---@return Tabbar
function Tabbar:new(o)
	o = o or {} -- create object if user does not provide one
	setmetatable(o, self)
	self.__index = self
	return o
end

---Constructor with default values
---@return Tabbar
function Tabbar:default()
	local instance = Tabbar:new({
		atBottom = true,
		zeroBasedIndices = false,
		enable = true,
		maxWidth = 8,
	})

	setmetatable(instance, self)
	self.__index = self
	return instance
end

---Apply provided values to Wezterm config
---@param config table
function Tabbar:setup(config)
	config.tab_bar_at_bottom = self.atBottom
	config.tab_and_split_indices_are_zero_based = self.zeroBasedIndices
	config.tab_max_width = self.maxWidth
	config.enable_tab_bar = self.enable
	config.use_fancy_tab_bar = false
	config.hide_tab_bar_if_only_one_tab = false
end

return Tabbar

KeymapMode = {
	--- @type boolean
	isActive = false,

	--- @type function
	toggleOn = nil,

	--- @type function
	toggleOff = nil,
}

---
--- @param toggleOn function
--- @param toggleOff function
---
function KeymapMode:new(toggleOn, toggleOff)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	o.toggleCallback = callback

	return o
end

function KeymapMode:toggle()
	if self.isActive then
		self.toggleOff()
		self.isActive = false
	else
		self.toggleOn()
		self.isActive = true
	end
end

return {
	KeymapMode = KeymapMode,
}

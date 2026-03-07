-- local function setup()
-- end

---@module 'lazy'
---@type LazySpec
return {
	"apple/pkl-neovim",
	enabled = false,
	config = function(self, _)
		local hasConfigs, configs = pcall(require, "nvim-treesitter.configs")
		if hasConfigs then
			configs.setup({
				ensuer_installed = "pkl",
				highlight = {
					enable = true,
				},
				indent = {
					enable = true,
				},
			})
		end
	end,
	-- setup = setup,
}

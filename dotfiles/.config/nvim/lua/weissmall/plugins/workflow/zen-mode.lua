---@module 'lazy'
---@type LazySpec
return {
	"folke/zen-mode.nvim",
	lazy = true,
	---@type LazyKeysSpec[]
	keys = {
		{
			"<leader>zm",
			"<cmd>ZenMode<cr>",
			desc = "[Z]en[M]ode",
		},
	},
}

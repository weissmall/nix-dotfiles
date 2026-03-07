---@module 'lazy'
---@type LazySpec
return {
	"obsidian-nvim/obsidian.nvim",
	version = "*",
	lazy = true,
	ft = { "markdown" },
	init = function()
		vim.opt.conceallevel = 1
	end,
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	---@module 'obsidian'
	---@type obsidian.config
	opts = {
		workspaces = {
			{
				name = "weissmall",
				path = "~/Documents/Weissmall",
			},
		},
	},
	---@type LazyKeysSpec[]
	keys = {
		-- {
		-- 	"<leader>zm",
		-- 	"<cmd>ZenMode<cr>",
		-- 	desc = "[Z]en[M]ode",
		-- },
	},
}

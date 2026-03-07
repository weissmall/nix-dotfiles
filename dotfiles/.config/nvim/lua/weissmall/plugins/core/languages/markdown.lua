return {
	"MeanderingProgrammer/render-markdown.nvim",
	init = function(_)
		vim.treesitter.language.register("markdown", "telekasten")
	end,
	opts = {
		file_types = {
			"markdown",
		},
	},
	ft = { "markdown" },
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons", -- if you prefer nvim-web-devicons
	},
}

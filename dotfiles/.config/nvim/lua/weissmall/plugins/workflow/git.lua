---@module "lazy"
---@type LazySpec
return {
	{
		"lewis6991/gitsigns.nvim",
		opts = function(_, opts)
			opts = opts or {}
			return vim.tbl_deep_extend(
				"force",
				opts,
				---@module "gitsigns"
				---@type Gitsigns.Config
				{
					current_line_blame = true,
				}
			)
		end,
	},
	{
		"tpope/vim-fugitive",
		cmd = "Git",
		lazy = true,
	},
}

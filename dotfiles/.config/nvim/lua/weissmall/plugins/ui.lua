---@module 'lazy'
---@type LazySpec[]
return {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		---@module 'noice'
		---@type NoiceConfig
		---@diagnostic disable-next-line: missing-fields
		opts = {
			lsp = {
				-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					-- ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
				},
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
				inc_rename = false,
				lsp_doc_border = true,
			},
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
	},
	{
		"rcarriga/nvim-notify",
		opts = {
			timeout = 1,
			background_colour = "#000000",
			level = 1,
			max_width = 30,
			max_height = 100,
			on_open = function() end,
			on_close = function() end,
			fps = 15,
		},
		---@type LazyKeysSpec[]
		keys = {
			{
				"<leader>nd",
				function()
					require("notify").dismiss({
						pending = true,
						silent = true,
					})
				end,
				desc = "[N]otifications [D]elete",
			},
			{
				"<leader>nh",
				"<cmd>Noice telescope<cr>",
				desc = "[N]oice/[N]otification [H]istory",
			},
		},
	},
}

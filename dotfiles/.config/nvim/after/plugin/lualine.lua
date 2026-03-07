-- require("lualine").setup({
--   theme = 'tokyonight-night'
-- })

-- Bubbles config for lualine
-- Author: lokesh-krishna
-- MIT license, see LICENSE for more details.

-- stylua: ignore
local colors = {
  blue   = '#80a0ff',
  cyan   = '#79dac8',
  black  = '#080808',
  white  = '#c6c6c6',
  red    = '#ff5189',
  violet = '#d183e8',
  grey   = '#303030',
}

local bubbles_theme = {
	normal = {
		a = { fg = colors.black, bg = colors.cyan },
		b = { fg = colors.white, bg = colors.grey },
		c = { fg = colors.white },
	},

	insert = { a = { fg = colors.black, bg = colors.blue } },
	visual = { a = { fg = colors.black, bg = colors.cyan } },
	replace = { a = { fg = colors.black, bg = colors.red } },

	inactive = {
		a = { fg = colors.white, bg = colors.black },
		b = { fg = colors.white, bg = colors.black },
		c = { fg = colors.white },
	},
}

function cwdName()
	return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
end

require("lualine").setup({
	options = {
		theme = bubbles_theme,
		component_separators = "",
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			"lazy",
			"NvimTree",
			"toggleterm",
			-- "dapui_scopes",
			-- "dapui_breakpoints",
			-- "dapui_stacks",
			-- "dapui_watches",
			-- "dapui_console",
			-- "dap-repl",
		},
	},
	sections = {
		lualine_a = {
			{ "mode", separator = { left = "" }, right_padding = 2 },
		},
		lualine_b = {
			function()
				return "(" .. cwdName() .. ")"
			end,
			"filename",
			"branch",
			function()
				local reg = vim.fn.reg_recording()
				if reg == "" then
					return ""
				end -- not recording
				return "recording to " .. reg
			end,
		},
		lualine_c = {
			"%=", --[[ add your center compoentnts here in place of this comment ]]
		},
		lualine_x = {},
		lualine_y = { "filetype", "progress" },
		lualine_z = {
			{ "location", separator = { right = "" }, left_padding = 2 },
		},
	},
	inactive_sections = {
		lualine_a = { "filename" },
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = { "location" },
	},
	tabline = {},
	extensions = {},
})

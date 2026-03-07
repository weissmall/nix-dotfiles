local dashboard = require("dashboard")

dashboard.setup({
	theme = "doom",
	config = {
		week_header = {
			enable = true,
		},
		disable_mode = true,
		vertical_center = true,
		center = {
			{
				icon = " ",
				icon_hl = "Title",
				desc = "Find File",
				desc_hl = "String",
				key = "ff",
				keymap = "<leader>",
				key_hl = "Number",
				key_format = " %s", -- remove default surrounding `[]`
				action = "lua print(2)",
			},
			{
				icon = " ",
				icon_hl = "Title",
				desc = "Find Grep",
				desc_hl = "String",
				key = "fg",
				keymap = "<leader>",
				key_hl = "Number",
				key_format = " %s", -- remove default surrounding `[]`
				action = "lua print(2)",
			},
			{
				icon = " ",
				icon_hl = "Title",
				desc = "Quick jump",
				desc_hl = "String",
				key = "e",
				keymap = "<leader>",
				key_hl = "Number",
				key_format = " %s", -- remove default surrounding `[]`
				action = "lua print(2)",
			},
			{
				icon = " ",
				icon_hl = "Title",
				desc = "File Tree",
				desc_hl = "String",
				key = "ft",
				keymap = "<leader>",
				key_hl = "Number",
				key_format = " %s", -- remove default surrounding `[]`
				action = "lua print(2)",
			},
			{
				icon = " ",
				icon_hl = "Title",
				desc = "Another File Manager",
				desc_hl = "String",
				key = "fm",
				keymap = "<leader>",
				key_hl = "Number",
				key_format = " %s", -- remove default surrounding `[]`
				action = "lua print(2)",
			},
			{
				icon = " ",
				icon_hl = "Title",
				desc = "Quit",
				desc_hl = "String",
				key = "qa",
				keymap = "<leader>",
				key_hl = "Number",
				key_format = " %s", -- remove default surrounding `[]`
				action = "lua print(2)",
			},
		},
		footer = {},
	},
})

-- dashboard.setup({
--   theme = 'hyper',
--   config = {
--     week_header = {
--       enable = true,
--     },
--     shortcut = {
--       { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
--       {
--         icon = ' ',
--         icon_hl = '@variable',
--         desc = 'Files',
--         group = 'Label',
--         action = 'Telescope find_files',
--         key = 'f',
--       },
--       {
--         desc = ' Apps',
--         group = 'DiagnosticHint',
--         action = 'Telescope app',
--         key = 'a',
--       },
--       {
--         desc = ' dotfiles',
--         group = 'Number',
--         action = 'Telescope dotfiles',
--         key = 'd',
--       },
--     },
--   },
-- })
-- dashboard.setup({
--   theme = 'doom',
--   config = {
--     header = {}, --your header
--     center = {
--       {
--         icon = ' ',
--         icon_hl = 'Title',
--         desc = 'Find File           ',
--         desc_hl = 'String',
--         key = 'b',
--         keymap = 'SPC f f',
--         key_hl = 'Number',
--         key_format = ' %s', -- remove default surrounding `[]`
--         action = 'lua print(2)'
--       },
--       {
--         icon = ' ',
--         desc = 'Find Dotfiles',
--         key = 'f',
--         keymap = 'SPC f d',
--         key_format = ' %s', -- remove default surrounding `[]`
--         action = 'lua print(3)'
--       },
--     },
--     footer = {}  --your footer
--   }
-- })

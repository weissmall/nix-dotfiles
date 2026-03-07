local default_values = {
	ring = {
		history_length = 100,
		storage = "shada",
		storage_path = vim.fn.stdpath("data") .. "/databases/yanky.db",
		sync_with_numbered_registers = true,
		ignore_registers = { "_" },
		cancel_event = "update",
		update_register_on_cycle = false,
	},
	system_clipboard = {
		sync_with_ring = true,
		clipboard_register = nil,
	},
	highlight = {
		on_put = true,
		on_yank = true,
		timer = 500,
	},
	preserve_cursor_position = {
		enabled = true,
	},
	picker = {
		select = {
			action = nil,
		},
		telescope = {
			use_default_mappings = true,
			mappings = nil,
		},
	},
	textobj = {
		enabled = false,
	},
}

---@class YankyConfigRing
---@field history_length
---@field storage
---@field storage_path

---@class YankyConfig
---@field YankyConfigRing
---@field YankyConfigClipboard
---@field YankyConfigHighlight
---@field YankyConfigCursorPosition
---@field YankyConfigPicker
---@field YankyConfigTextobj

---@module 'lazy'
---@type LazySpec
return {
	"gbprod/yanky.nvim",
	lazy = false,
	---@module 'yanky'
	opts = default_values,
	---@type LazyKeysSpec[]
	keys = {
		-- {
		-- 	"<leader>zm",
		-- 	"<cmd>ZenMode<cr>",
		-- 	desc = "[Z]en[M]ode",
		-- },
		{
			"<leader>yh",
			"<cmd>YankyRingHistory<cr>",
			desc = "[Y]anky [H]istory",
		},
	},
}

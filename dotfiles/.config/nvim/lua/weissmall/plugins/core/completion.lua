---@module 'blink'
---@type blink.cmp.KeymapConfig
local keymap = {
	-- preset = "super-tab",
	["<C-k>"] = { "select_prev", "fallback" },
	["<C-j>"] = { "select_next", "fallback" },
	["<C-space>"] = { "show", "show_documentation", "hide_documentation", "hide" },
	["K"] = { "show_signature", "hide_signature", "fallback" },
	["<Tab>"] = {
		function(cmp)
			if cmp.snippet_active() then
				return cmp.accept()
			else
				return cmp.select_and_accept()
			end
		end,
		"snippet_forward",
		"fallback",
	},
	["<C-y>"] = { "select_and_accept", "fallback" },
	["<Esc>"] = { "cancel", "fallback" },
}

---@module 'lazy'
---@type LazySpec[]
return {
	{
		"saghen/blink.cmp",
		commit = "52cd2aae77db635af85d6e642fe19c56782c0e5c",
		dependencies = {
			"Kaiser-Yang/blink-cmp-avante",
		},
		event = { "InsertEnter", "CmdlineEnter" },
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			snippets = {
				preset = "mini_snippets",
			},
			cmdline = {
				enabled = true,
				completion = {
					menu = {
						auto_show = true,
					},
				},
				keymap = keymap,
			},
			sources = {
				default = { "avante", "lsp", "path", "snippets", "buffer" },
				providers = {
					snippets = {
						should_show_items = function(ctx, items)
							return ctx.trigger.initial_kind ~= "trigger_character"
						end,
					},
					avante = {
						module = "blink-cmp-avante",
						name = "Avante",
						opts = {
							-- options for blink-cmp-avante
						},
					},
				},
			},
			keymap = keymap,
			fuzzy = {
				implementation = "lua",
				sorts = {
					"exact",
					"score",
					"sort_text",
				},
			},
		},
	},
	dependencies = {
		"echasnovski/mini.snippets",
	},
	{
		"echasnovski/mini.snippets",
		opts = function(_, opts)
			opts = opts or {}
			local loader = require("mini.snippets").gen_loader
			return vim.tbl_deep_extend("force", opts, {
				snippets = {
					loader.from_file("~/.config/nvim/snippets/lua.json"),
				},
			})
		end,
	},
}

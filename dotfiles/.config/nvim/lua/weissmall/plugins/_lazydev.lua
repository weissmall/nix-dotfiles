local lazydev = {
	"folke/lazydev.nvim",
}

-- local blink = { -- optional blink completion source for require statements and module annotations
-- 	"Saghen/blink.cmp",
-- 	opts = {
-- 		sources = {
-- 			-- add lazydev to your completion providers
-- 			completion = {
-- 				enabled_providers = { "lsp", "path", "snippets", "buffer", "lazydev" },
-- 			},
-- 			providers = {
-- 				-- dont show LuaLS require statements when lazydev has items
-- 				lsp = { fallback_for = { "lazydev" } },
-- 				lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
-- 			},
-- 		},
-- 	},
-- }

return {
	lazydev,
	{},
}

---@module 'lazy'
---@type LazySpec
return {
	"tomasky/bookmarks.nvim",
	cond = false,
	opts = {
		-- Save file
		save_file = vim.fn.expand("$HOME/.nvim-bookmarks"),
		keywords = {
			["@t"] = "☑️ ", -- mark annotation startswith @t ,signs this icon as `Todo`
			["@w"] = "⚠️ ", -- mark annotation startswith @w ,signs this icon as `Warn`
			["@f"] = "⛏ ", -- mark annotation startswith @f ,signs this icon as `Fix`
			["@n"] = " ", -- mark annotation startswith @n ,signs this icon as `Note`
		},
		on_attach = function(_)
			local bookmarks = require("bookmarks")
			vim.keymap.set("n", "mm", bookmarks.bookmark_toggle)
			vim.keymap.set("n", "mc", bookmarks.bookmark_clean)
			vim.keymap.set("n", "ml", bookmarks.bookmark_list)
		end,
	},
}

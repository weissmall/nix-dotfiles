---@module 'lazy'
---@type LazySpec
return {
	"neotest",
	opts = function(_, opts)
		vim.tbl_extend("force", opts, {})
		return {
			log_level = 0,
			adapters = {
				require("neotest-dart")({
					command = "flutter",
					use_lsp = true,
				}),
				require("neotest-vitest")({
					vitestCommand = "npx vitest run",
				}),
				require("neotest-golang")({
					dap_mode = "dap-go",
				}),
			},
		}
	end,
	dependencies = {
		"neotest-dart",
		"neotest-vitest",
		"fredrikaverpil/neotest-golang",
	},
	lazy = true,
	---@type LazyKeysSpec[]
	keys = {
		{
			"<leader>tc",
			function()
				require("neotest").run.run()
			end,
		},
		{
			"<leader>tdc",
			function()
				require("neotest").run.run({ suite = false, strategy = "dap" })
			end,
		},
		{
			"<leader>twf",
			function()
				require("neotest").watch.watch({ vim.fn.expand("%"), suite = true, vitestCommand = "vitest --watch" })
			end,
		},
		{
			"<leader>tf",
			function()
				require("neotest").run.run(vim.fn.expand("%"))
			end,
		},
		{
			"<leader>tpo",
			function()
				require("neotest").output_panel.open()
			end,
		},
		{
			"<leader>tpc",
			function()
				require("neotest").output_panel.close()
			end,
		},
		{
			"<leader>tso",
			function()
				require("neotest").summary.open()
			end,
		},
		{
			"<leader>tsc",
			function()
				require("neotest").summary.close()
			end,
		},
	},
}

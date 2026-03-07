---@module 'lazy'
---@type LazySpec
return {
	"rcarriga/nvim-dap-ui",
	lazy = true,
	cmd = "DapContinue",
	dependencies = {
		"mfussenegger/nvim-dap",
		"nvim-neotest/nvim-nio",
		"mxsdev/nvim-dap-vscode-js",
		"microsoft/vscode-js-debug",
	},
	config = true,
	---@type LazyKeysSpec[]
	keys = {
		{
			"<leader>do",
			function()
				require("dapui").open()
			end,
		},
		{
			"<leader>dc",
			function()
				require("dapui").close()
			end,
		},
	},
}

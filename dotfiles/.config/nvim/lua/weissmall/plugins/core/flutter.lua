---@module 'lazy'
---@type LazySpec
return {
	"akinsho/flutter-tools.nvim",
	lazy = true,
	ft = { "dart" },
	opts = {
		ui = {
			border = "rounded",
			notification_style = "plugin",
		},
		decorations = {
			statusline = {
				app_version = true,
				device = true,
				project_config = false,
			},
		},
		-- debugger = {
		-- 	enabled = true,
		-- 	run_via_dap = true,
		-- 	exception_breakpoints = {},
		-- },
		debugger = {
			enabled = true,
			-- run_via_dap = true,
			exception_breakpoints = {},
			evaluate_to_string_in_debug_views = false,
		},
		fvm = false,
		dev_log = {
			enabled = false,
		},
		lsp = {
			color = {
				enabled = false,
				background = true,
				background_color = nil,
				foreground = false,
				virtual_text = true,
				virtual_text_str = "■",
			},
			capabilities = vim.lsp.protocol.make_client_capabilities(),
			settings = {
				showTodos = true,
				completeFunctionCalls = true,
				-- analysisExcludedFolders = { "<path-to-flutter-sdk-packages>" },
				renameFilesWithClasses = "always",
				enableSnippets = false,
				updateImportsOnRename = true,
			},
		},
	},
}

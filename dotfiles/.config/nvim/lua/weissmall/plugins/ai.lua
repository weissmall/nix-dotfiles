local function getOpenRouterModel(model)
	return {
		__inherited_from = "openai",
		endpoint = "https://openrouter.ai/api/v1",
		api_key_name = "OPENROUTER_API_KEY",
		model = model,
	}
end

local function enabledCond(env)
	local fullEnv = "NVIM_USE_" .. env
	local value = vim.uv.os_getenv(fullEnv) == "true"
	if value == true then
		return true
	end
	return false
end

---@module 'lazy'
---@type LazySpec[]
return {
	{
		enabled = true,
		"olimorris/codecompanion.nvim",
		lazy = true,
		cond = enabledCond("CC"),
		cmd = { "CodeCompanion" },
		opts = {
			strategies = {
				chat = {
					adapter = "openrouter",
				},
				inline = {
					adapter = "openrouter",
				},
			},
			adapters = {
				-- dipal = function()
				-- 	return require("codecompanion.adapters").extend("ollama", {
				-- 		env = {
				-- 			url = "http://176.53.196.38:26262",
				-- 		},
				-- 	})
				-- end,
				openrouter = function()
					return require("codecompanion.adapters").extend("openai_compatible", {
						env = {
							url = "https://openrouter.ai/api",
							api_key = vim.uv.os_getenv("OPENROUTER_API_KEY"),
							chat_url = "/v1/chat/completions",
						},
						schema = {
							model = {
								default = "anthropic/claude-3.7-sonnet",
							},
						},
					})
				end,
			},
		},
	},
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		enabled = true,
		cond = enabledCond("AVANTE"),
		version = false, -- Never set this value to "*"! Never!
		opts = {
			mode = "agentic",
			auto_suggestions_provider = "copilot",
			cursor_applying_provider = nil,
			-- provider = "codestral",
			-- vendors = {
			--   ["claude"] = getOpenRouterModel("anthropic/claude-3.7-sonnet"),
			--   ["codestral"] = getOpenRouterModel("mistralai/codestral-2501"),
			--   ["codestral-mamba"] = getOpenRouterModel("mistralai/codestral-mamba"),
			--   ["qwen32"] = getOpenRouterModel("qwen/qwen-2.5-coder-32b-instruct"),
			--   ["qwen7"] = getOpenRouterModel("qwen/qwen2.5-coder-7b-instruct"),
			--   ["gpt4o-mini"] = getOpenRouterModel("openai/gpt-4o-mini"),
			-- },
			behaviour = {
				auto_suggestions = true, -- Experimental stage
				enable_cursor_planning_mode = true,
				auto_set_highlight_group = true,
				auto_set_keymaps = true,
				auto_apply_diff_after_generation = false,
				support_paste_from_clipboard = false,
				minimize_diff = true, -- Whether to remove unchanged lines when applying a code block
				enable_token_counting = true, -- Whether to enable token counting. Default to true.
			},
			mappings = {
				--- @class AvanteConflictMappings
				diff = {
					ours = "co",
					theirs = "ct",
					all_theirs = "ca",
					both = "cb",
					cursor = "cc",
					next = "]x",
					prev = "[x",
				},
				suggestion = {
					accept = "<M-l>",
					next = "<M-]>",
					prev = "<M-[>",
					dismiss = "<C-]>",
				},
				jump = {
					next = "]]",
					prev = "[[",
				},
				submit = {
					normal = "<CR>",
					insert = "<C-s>",
				},
				cancel = {
					normal = { "<C-c>", "<Esc>", "q" },
					insert = { "<C-c>" },
				},
			},
			hints = { enabled = true },
			suggestion = {
				debounce = 400,
				throttle = 400,
			},
		},
		-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
		build = "make",
		-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			--- The below dependencies are optional,
			-- "echasnovski/mini.pick", -- for file_selector provider mini.pick
			"nvim-telescope/telescope.nvim", -- for file_selector provider telescope
			-- "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
			-- "ibhagwan/fzf-lua", -- for file_selector provider fzf
			"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
			{
				-- "github/copilot.vim",
				"zbirenbaum/copilot.lua",
				opts = true,
			}, -- for providers='copilot'
			-- {
			-- 	-- support for image pasting
			-- 	"HakonHarnes/img-clip.nvim",
			-- 	event = "VeryLazy",
			-- 	opts = {
			-- 		-- recommended settings
			-- 		default = {
			-- 			embed_image_as_base64 = false,
			-- 			prompt_for_file_name = false,
			-- 			drag_and_drop = {
			-- 				insert_mode = true,
			-- 			},
			-- 			-- required for Windows users
			-- 			use_absolute_path = true,
			-- 		},
			-- 	},
			-- },
			-- {
			-- 	-- Make sure to set this up properly if you have lazy=true
			-- 	"MeanderingProgrammer/render-markdown.nvim",
			-- 	opts = {
			-- 		file_types = { "markdown", "Avante" },
			-- 	},
			-- 	ft = { "markdown", "Avante" },
			-- },
		},
	},
	{
		"github/copilot.vim",
		cond = enabledCond("COPILOT"),
		lazy = false,
		init = function()
			vim.g.copilot_no_tab_map = true
			-- vim.g.copilot_proxy = vim.uv.os_getenv("PROXY_URL")
		end,
		keys = {
			{
				"<A-l>",
				"copilot#Accept()",
				mode = "i",
				desc = "Accept Copilot suggestion",
				replace_keycodes = false,
				expr = true,
			},
			{ "<A-w>", "<Plug>(copilot-accept-word)", mode = "i", desc = "Accept Copilot word" },
			{ "<A-j>", "<Plug>(copilot-next)", mode = "i", desc = "Next Copilot suggestion" },
			{
				"<A-k>",
				"<Plug>(copilot-previous)",
				mode = "i",
				desc = "Previous Copilot suggestion",
			},
			{ "<leader>cc", ":Copilot<CR>", desc = "Toggle Copilot" },
		},
	},
	{
		"xTacobaco/cursor-agent.nvim",
		config = function()
			vim.keymap.set("n", "<leader>ca", ":CursorAgent<CR>", { desc = "Cursor Agent: Toggle terminal" })
			vim.keymap.set("v", "<leader>ca", ":CursorAgentSelection<CR>", { desc = "Cursor Agent: Send selection" })
			vim.keymap.set("n", "<leader>cA", ":CursorAgentBuffer<CR>", { desc = "Cursor Agent: Send buffer" })
		end,
		keys = {
			{
				"<leader>caa",
				function()
					vim.ui.input({
						prompt = "Ask Cursor:",
					}, function(input)
						require("cursor-agent").ask({ prompt = input })
					end)
				end,
				mode = "n",
				desc = "[C]ursor [A]gent [A]sk",
			},
			{
				"<leader>cat",
				":CursorAgent<CR>",
				mode = "n",
				desc = "[C]ursor [A]gent [T]erminal",
			},
			{
				"<leader>cas",
				":CursorAgentSelection<CR>",
				mode = "v",
				desc = "[C]ursor [A]gent send [S]election",
			},
			{
				"<leader>cab",
				":CursorAgentBuffer<CR>",
				mode = "n",
				desc = "[C]ursor [A]gent send [B]uffer",
			},
		},
	},
}

local telescope = require("telescope")
local builtin = require("telescope.builtin")

telescope.load_extension("projects")
telescope.load_extension("noice")
telescope.load_extension("flutter")

local function showProjects()
  require("telescope").extensions.projects.projects({})
end

local function tlWrapper(fn)
  return function()
    fn({
      layout_strategy = "vertical",
      layout_config = {
        width = 0.8,
      },
    })
  end
end

vim.keymap.set("n", "<leader>ff", tlWrapper(builtin.find_files), {})
-- vim.keymap.set("n", "<C-p>", builtin.git_files, {})
vim.keymap.set("n", "<leader>fg", tlWrapper(builtin.live_grep), {})
vim.keymap.set("n", "<leader>fof", tlWrapper(builtin.oldfiles), {})
vim.keymap.set("n", "<leader>b", tlWrapper(builtin.buffers), {})

vim.keymap.set("n", "<leader>r", tlWrapper(showProjects))

local function flutterCommands()
  return require("telescope").extensions.flutter.commands()
end
vim.keymap.set("n", "<leader>fc", flutterCommands)

--vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
--vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
telescope.setup({
  defaults = {
    layout_strategy = "vertical",
    layout_config = {
      vertical = {
        width = 0.8,
      },
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,                -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case",    -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
    just = {
      -- I rather suggest dropdown!
      -- theme = "ivy",
      -- A good option is to show a popup window.
      -- You can do that with tmux or toggleterm.
      -- action = function(command)
      --   vim.fn.system(command)
      --   print("Executed", command)
      -- end,
    },
  },
})

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require("telescope").load_extension("fzf")
require("telescope").load_extension("just")

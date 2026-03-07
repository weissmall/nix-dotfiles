local tree = require("nvim-tree")
--
-- -- local function label(path)
-- -- 	path = path:gsub(os.getenv("HOME"), "~", 1)
-- -- 	return path:gsub("([a-zA-Z])[a-z0-9]+", "%1") .. (path:match("[a-zA-Z]([a-z0-9]*)$") or "")
-- -- end
--
local VIEW_WIDTH_FIXED = 30
local view_width_max = VIEW_WIDTH_FIXED -- fixed to start
--
-- -- toggle the width and redraw
-- local function toggle_width_adaptive()
-- 	if view_width_max == -1 then
-- 		view_width_max = VIEW_WIDTH_FIXED
-- 	else
-- 		view_width_max = -1
-- 	end
--
-- 	require("nvim-tree.api").tree.reload()
-- end
--
local nvimTreeFocusOrToggle = function()
  local nvimTree = require("nvim-tree.api")
  local currentBuf = vim.api.nvim_get_current_buf()
  local currentBufFt = vim.api.nvim_get_option_value("filetype", { buf = currentBuf })
  if currentBufFt == "NvimTree" then
    nvimTree.tree.toggle()
  else
    nvimTree.tree.focus()
  end
end

-- vim.keymap.set("n", "<leader>ft", nvimTreeFocusOrToggle)
-- vim.keymap.set("n", "<leader>fta", toggle_width_adaptive, { desc = "[F]ile [T]ree toggle [A]daptive width" })
-- -- vim.keymap.set("n", "<leader>ftf", vim.cmd.NvimTreeFocus)
-- -- vim.keymap.set("n", "<leader>ftff", vim.cmd.NvimTreeFindFile)
-- vim.keymap.set("n", "<leader>ftc", vim.cmd.NvimTreeClose)
local function get_view_width_max()
  return view_width_max
end
tree.setup({ renderer = {} })
tree.setup({
  sync_root_with_cwd = true,
  respect_buf_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = true,
  },
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = {
      min = 30,
      max = get_view_width_max,
    },
  },
  renderer = {
    -- root_folder_label = label,
    -- group_empty = label,
    group_empty = true,
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    -- icons = {
    -- 	error = "E",
    -- 	warning = "W",
    -- 	info = "I",
    -- 	hint = "H",
    -- },
  },
  filters = {
    git_ignored = false,
    dotfiles = false,
    git_clean = false,
    no_buffer = false,
    no_bookmark = false,
  },
})

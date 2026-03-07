vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

vim.keymap.set("n", "<leader>gaa", "<Cmd>Git add .<CR>")
vim.keymap.set("n", "<leader>gl", "<Cmd>Git pull<CR>")
vim.keymap.set("n", "<leader>gp", "<Cmd>Git push<CR>")
vim.keymap.set("n", "<leader>gst", "<Cmd>Git status<CR>")
vim.keymap.set("n", "<leader>gc", "<Cmd>Git commit<CR>")

local function gitPushOrigin()
	local handle = io.popen("git rev-parse --abbrev-ref HEAD")
	local result = handle:read("*l")
	handle:close()

	local command = "Git push origin " .. result
	vim.api.nvim_command(command)
end

local function dump(o)
	if type(o) == "table" then
		local s = "{ "
		for k, v in pairs(o) do
			if type(k) ~= "number" then
				k = '"' .. k .. '"'
			end
			s = s .. "[" .. k .. "] = " .. dump(v) .. ","
		end
		return s .. "} "
	else
		return tostring(o)
	end
end

vim.keymap.set("n", "<leader>ggp", gitPushOrigin)

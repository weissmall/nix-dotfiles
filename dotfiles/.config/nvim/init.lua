-- By default title is off. Needed for detecting window as neovim instance (sworkstyle)
if vim.g.vscode then
else
  require("weissmall")
end

vim.cmd("set title")

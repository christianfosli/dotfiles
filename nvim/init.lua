--- My neovim config ---

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- helper function for setting options | see issue #13479
-- vim.o = global option, vim.bo = buffer option, vim.wo = window option
local scopes = { o = vim.o, b = vim.bo, w = vim.wo }
local function opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= 'o' then scopes['o'][key] = value end
end

opt('o', 'ignorecase', true)
opt('o', 'smartcase', true)
opt('o', 'clipboard', 'unnamedplus')
opt('b', 'spelllang', 'en,nb')

-- vscode can use neovim as a backend with the vscode-neovim extension
-- however, most settings and plugins don't make sense then
if vim.g.vscode == nil then
  opt('w', 'number', true)
  opt('o', 'autowrite', true)
  opt('o', 'hidden', true)

  if vim.fn.has('termguicolors') == 1 then
    vim.cmd 'set termguicolors'
  end

  require 'plugins'
  require 'keybinds'
  require 'autocmd'
else
  require 'vscode'
end

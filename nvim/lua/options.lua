-- vim.o = global option, vim.bo = buffer option, vim.wo = window option | see iss #13479
local scopes = { o = vim.o, b = vim.bo, w = vim.wo }
local function opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= 'o' then scopes['o'][key] = value end
end

vim.cmd([[
  if has("termguicolors")
    set termguicolors
  endif
]])

opt('w', 'number', true)
opt('o', 'ignorecase', true)
opt('o', 'smartcase', true)
opt('o', 'autowrite', true)
opt('o', 'hidden', true)
opt('b', 'spelllang', 'en,nb')

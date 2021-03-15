--- Settings used by neovim when invoked through vscode ---
vim.cmd([[nnoremap <silent> <leader>a <Cmd>call VSCodeNotify('editor.action.codeAction')<CR>]])
vim.cmd([[nnoremap <silent> <leader>k <Cmd>call VSCodeNotify('editor.action.triggerParameterHints')<CR>]])
-- many more are defined by default

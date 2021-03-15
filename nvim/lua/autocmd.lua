-- Helper function because no native API exists yet
-- Ref https://github.com/norcalli/nvim_utils/blob/master/lua/nvim_utils.lua#L554-L567
function nvim_create_augroups(definitions)
  for group_name, definition in pairs(definitions) do
    vim.api.nvim_command('augroup '..group_name)
    vim.api.nvim_command('autocmd!')
    for _, def in ipairs(definition) do
      local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
      vim.api.nvim_command(command)
    end
    vim.api.nvim_command('augroup END')
  end
end

local autocmds = {
  format_ts = {
    { 'FileType', 'typescript,typescriptreact', 'setlocal formatprg=prettier\\ --parser\\ typescript' };
  };
  format_js = {
    { 'FileType', 'javascript,javascriptreact', 'setlocal formatprg=prettier\\ --parser\\ babel-flow' };
  };
  terraform_ft = {
    { 'BufNewFile,BufRead', '*.tf,*.tfvars', 'set filetype=terraform' };
  };
  fsharp_ft = {
    { 'BufNewFile,BufRead', '*.fs,*.fsx,*.fsi', 'set filetype=fsharp' };
  };
  fix_windows_terminal = {
    { 'VimLeave', '*', 'set guicursor=a:ver25' };
  };
}

nvim_create_augroups(autocmds)

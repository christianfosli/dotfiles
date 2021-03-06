--- Color Scheme ---
vim.cmd 'packadd! nvim-highlite'
vim.cmd 'colorscheme highlite'

--- Smart Indentation ---
vim.cmd 'packadd! sleuth'

--- Auto Pairs ---
vim.cmd 'packadd! nvim-autopairs'
require'nvim-autopairs'.setup()

--- Fuzzy Finder ---
vim.cmd 'set runtimepath+=~/.skim'

--- TreeSitter config ---
vim.cmd 'packadd! nvim-tresitter'
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
  },
}

--- Language Server Config ---
vim.cmd 'packadd! nvim-lspconfig'
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gf', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', '<C-]>', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  -- hint: go back with `<C-t>`
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>k', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<leader>l', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  -- Set keybinds conditional on server capabilities
  if client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("n", "gq", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_formatting then
    vim.api.nvim_exec([[
      augroup lsp_format_on_save
        autocmd! * <buffer>
        autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 3000)
      augroup END
    ]], false)
  end

  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=DarkYellow guibg=LightYellow
      hi LspReferenceText cterm=bold ctermbg=DarkYellow guibg=LightYellow
      hi LspReferenceWrite cterm=bold ctermbg=DarkYellow guibg=LightYellow
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
end

local nvim_lsp = require'lspconfig'
local pid = vim.fn.getpid()

nvim_lsp.pyright.setup { on_attach = on_attach }
nvim_lsp.rust_analyzer.setup { on_attach = on_attach }
nvim_lsp.terraformls.setup { on_attach = on_attach }
nvim_lsp.tsserver.setup { on_attach = on_attach }
nvim_lsp.fsautocomplete.setup {
  cmd = { 'dotnet', '/home/cfosli/.local/lib/fsautocomplete/fsautocomplete.dll', '--background-service-enabled' };
  on_attach = on_attach
}

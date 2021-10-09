local M = {}

function M.on_attach(_, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  local opts = { noremap=true, silent=true }

  buf_set_keymap('n', 'K',              '<cmd>lua require"lspsaga.hover".render_hover_doc()<CR>', opts)
  buf_set_keymap('n', '<leader>cc',     '<cmd>lua require"lspsaga.signaturehelp".signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>ca',     '<cmd>lua require"lspsaga.codeaction".code_action()<CR>', opts)
  buf_set_keymap('v', '<leader>ca',     '<cmd>lua require"lspsaga.codeaction".range_code_action()<CR>', opts)
  buf_set_keymap('n', '<leader>gd',     '<cmd>lua require"lspsaga.provider".preview_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua require"lspsaga.rename".rename()<CR>', opts)

  buf_set_keymap('n', 'gr',         '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'gD',         '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd',         '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gy',         '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', 'gi',         '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)

  buf_set_keymap('n', '<leader>s',  '<cmd>lua require"lsp.callbacks.diagnostics".prev()<CR>', opts)
  buf_set_keymap('n', '<leader>d',  '<cmd>lua require"lsp.callbacks.diagnostics".next()<CR>', opts)
end

return M

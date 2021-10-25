local M = {}

function M.on_attach(_, bufnr)
  local opts = { noremap=true, silent=true }
  local function buf_set_keymap(...)
    local p = {...}
    vim.api.nvim_buf_set_keymap(bufnr, p[1], p[2], p[3], opts)
  end

  buf_set_keymap('n', 'K',              '<cmd>lua require"lspsaga.hover".render_hover_doc()<CR>')
  buf_set_keymap('n', '<leader>cc',     '<cmd>lua require"lspsaga.signaturehelp".signature_help()<CR>')
  buf_set_keymap('n', '<leader>ca',     '<cmd>lua require"lspsaga.codeaction".code_action()<CR>')
  buf_set_keymap('v', '<leader>ca',     '<cmd>lua require"lspsaga.codeaction".range_code_action()<CR>')
  buf_set_keymap('n', '<leader>gd',     '<cmd>lua require"lspsaga.provider".preview_definition()<CR>')
  buf_set_keymap('n', '<leader>rn',     '<cmd>lua require"lspsaga.rename".rename()<CR>')

  buf_set_keymap('n', 'gr',             '<cmd>lua require("telescope.builtin").lsp_references()<cr>')
  buf_set_keymap('n', 'gD',             '<cmd>lua vim.lsp.buf.declaration()<CR>')
  buf_set_keymap('n', 'gd',             '<cmd>lua vim.lsp.buf.definition()<CR>')
  buf_set_keymap('n', 'gy',             '<cmd>lua vim.lsp.buf.type_definition()<CR>')
  buf_set_keymap('n', 'gi',             '<cmd>lua vim.lsp.buf.implementation()<CR>')

  buf_set_keymap('n', '<leader>s',      '<cmd>lua require"lsp".prev_diagnostic()<CR>')
  buf_set_keymap('n', '<leader>d',      '<cmd>lua require"lsp".next_diagnostic()<CR>')
end

return M

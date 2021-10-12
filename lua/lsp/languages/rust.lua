local M = {}

function M.setup()
  require'lspconfig'.rust_analyzer.setup{
    on_attach = require'lsp.utils'.on_attach
  }
end

return M

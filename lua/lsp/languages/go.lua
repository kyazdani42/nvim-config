local M = {}

function M.setup()
  require'lspconfig'.gopls.setup{
    on_attach = require'lsp.utils'.on_attach
  }
end

return M

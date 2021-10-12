local M = {}

function M.setup()
  require'lspconfig'.java_language_server.setup{
    on_attach = require'lsp.utils'.on_attach
  }
end

return M

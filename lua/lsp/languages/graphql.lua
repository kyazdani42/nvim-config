local M = {}

function M.setup()
  require'lspconfig'.graphql.setup {
    on_attach = require'lsp.utils'.on_attach
  }
end

return M

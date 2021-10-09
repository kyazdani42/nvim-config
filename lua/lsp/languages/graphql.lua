local M = {}

function M.setup()
  require'lspconfig'.graphql.setup {}
end

return M

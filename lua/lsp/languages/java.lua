local M = {}

function M.setup()
  require'lspconfig'.java_language_server.setup{}
end

return M

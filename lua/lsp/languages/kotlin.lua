local M = {}

function M.setup()
  require'lspconfig'.kotlin_language_server.setup{}
end

return M

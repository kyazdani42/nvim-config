local M = {}

function M.setup()
  require'lspconfig'.gopls.setup{}
end

return M

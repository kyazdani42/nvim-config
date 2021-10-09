local api = vim.api
local M = {}

local function location_cb(err, _, result)
  if err then return api.nvim_err_writeln(err) end
  if not result then
    return require'utils'.warn('No definition found')
  end

  local res = vim.tbl_islist(result) and result[1] or result
  vim.lsp.util.jump_to_location(res)
end

function M.setup()
  vim.lsp.handlers['textDocument/definition'] = location_cb
  vim.lsp.handlers['textDocument/references'] = require'lsp.callbacks.references'.references_cb
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      underline = true,
      signs = false,
      virtual_text = {
        spacing = 2,
        prefix = ''
      },
    }
  )

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  require'lsp.languages.lua'.setup(capabilities)
  require'lsp.languages.ecma'.setup(capabilities)
end

return M

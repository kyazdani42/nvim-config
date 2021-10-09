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
  vim.cmd [[
    sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=
    sign define DiagnosticSignWarn text=⚠ texthl=DiagnosticSignWarn linehl= numhl=
    sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=
    sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=
  ]]
  vim.lsp.handlers['textDocument/definition'] = location_cb
  vim.lsp.handlers['textDocument/references'] = require'lsp.callbacks.references'.references_cb
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      -- TODO: enable underline when https://github.com/alacritty/alacritty/pull/4660 is merged
      underline = false,
      signs = false,
      virtual_text = {
        spacing = 0,
        prefix = ' '
      },
    }
  )

  local capabilities = vim.lsp.protocol.make_client_capabilities()

  local langs = {'lua', 'ecma', 'rust', 'go', 'graphql', 'java', 'kotlin'}
  for _, lang in pairs(langs) do
    require('lsp.languages.'..lang).setup(capabilities)
  end
end

return M

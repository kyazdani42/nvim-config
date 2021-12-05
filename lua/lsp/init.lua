local api = vim.api
local M = {}

local function definition_handler(err, result)
  if err then return api.nvim_err_writeln(err) end
  if not result then
    return require'utils'.warn('No definition found')
  end

  local res = vim.tbl_islist(result) and result[1] or result
  vim.lsp.util.jump_to_location(res)
end

local function to_diagnostic(where)
  return function()
    local diagnostics = vim.lsp.diagnostic.get(vim.api.nvim_get_current_buf())

    if #diagnostics == 0 then
      return require'utils'.warn("No diagnostics")
    end

    require'lspsaga.diagnostic'.navigate(where){}
  end
end

M.prev_diagnostic = to_diagnostic "prev"
M.next_diagnostic = to_diagnostic "next"

function M.setup()
  vim.cmd [[
    sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=
    sign define DiagnosticSignWarn text=⚠ texthl=DiagnosticSignWarn linehl= numhl=
    sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=
    sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=
  ]]

  vim.lsp.handlers['textDocument/definition'] = definition_handler
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      -- TODO: enable underline when https://github.com/alacritty/alacritty/pull/4660 is merged
      underline = false,
      signs = false,
      virtual_text = {
        spacing = 1,
        prefix = ' '
      },
    }
  )

  local capabilities = require'cmp_nvim_lsp'.update_capabilities(vim.lsp.protocol.make_client_capabilities())

  local langs = {'lua', 'ecma', 'rust', 'go', 'graphql', 'java', 'kotlin'}
  for _, lang in pairs(langs) do
    require('lsp.languages.'..lang).setup(capabilities)
  end
end

return M

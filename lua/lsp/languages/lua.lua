local M = {}

function M.setup(cap)
  local luapath = vim.fn.stdpath('cache')..'/lspconfigs/sumneko_lua'
  local luabin = luapath..'/bin/Linux/lua-language-server'
  if not vim.loop.fs_access(luabin, 'R') then
    return
  end

  require'lspconfig'.sumneko_lua.setup {
    cmd = { luabin, '-E', luapath..'/main.lua'},
    on_attach = require'lsp.utils'.on_attach,
    settings =  {
      Lua = {
        runtime = {
          version = "LuaJIT",
          path = vim.split(package.path, ';')
        },
        completion = { keywordSnippet = "Disable" },
        diagnostics = {
          globals = {"vim", "map", "filter", "range", "reduce", "head", "tail", "nth", "use", "describe", "it", "dump"},
        },
        workspace = {
          library = {
            [vim.fn.expand('$VIMRUNTIME/lua')] = true,
            [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
          }
        }
      },
    },
    capabilities = cap,
  }
end

return M

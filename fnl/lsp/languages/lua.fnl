(module lsp.languages.lua
  {autoload {lspconfig lspconfig
             utils lsp.utils}})

(local luapath (.. (vim.fn.stdpath "cache") "lspconfigs/sumneko_lua"))
(local luabin (vim.fn.system "whereis lua-language-server | awk print '{$2}'"))

(local workspace
  {:library {(vim.fn.expand "$VIMRUNTIME/lua") true
             (vim.fn.expand "$VIMRUNTIME/lua/vim/lsp") true}})

(local diagnostics
   {:globals ["vim" "map" "filter" "range" "reduce" "head" "tail" "nth" "use" "describe" "it" "dump"]})

(local runtime
   {:version "LuaJIT"
    :path (vim.split package.path ";")})

(defn setup [capabilites]
    (lspconfig.sumneko_lua.setup 
      {:on_attach utils.on_attach
       :capabilities capabilities
       :telemetry {:enable false}
       :settings {:Lua {:diagnostics diagnostics
                        :workspace workspace
                        :runtime runtime}}}))

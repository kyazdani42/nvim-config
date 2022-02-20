(module lsp.languages.lua
  {autoload {lspconfig lspconfig
             utils lsp.utils}})

(def- luapath (.. (vim.fn.stdpath "cache") "lspconfigs/sumneko_lua"))
(def- luabin (vim.fn.system "whereis lua-language-server | awk '{print $2}'"))

(def- workspace
  {:library {(vim.fn.expand "$VIMRUNTIME/lua") true
             (vim.fn.expand "$VIMRUNTIME/lua/vim/lsp") true}})

(def- diagnostics
   {:globals ["vim" "map" "filter" "range" "reduce" "head" "tail" "nth" "use" "describe" "it" "dump"]})

(def- runtime
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

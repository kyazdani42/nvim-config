(module lsp.languages.lua
  {autoload {lspconfig lspconfig
             utils lsp.utils}})

(local luapath (.. (vim.fn.stdpath "cache") "lspconfigs/sumneko_lua"))
(local luabin (.. luapath "/bin/Linux/lua-language-server"))

(local workspace
  {:library {(vim.fn.expand "$VIMRUNTIME/lua") true
             (vim.fn.expand "$VIMRUNTIME/lua/vim/lsp") true}})

(local diagnostics
   {:globals ["vim" "map" "filter" "range" "reduce" "head" "tail" "nth" "use" "describe" "it" "dump"]})

(local runtime
   {:version "LuaJIT"
    :path (vim.split package.path ";")})

(defn setup [capabilites]
  (when (vim.loop.fs_access luabin "R")
    (lspconfig.sumneko_lua.setup 
      {:on_attach utils.on_attach
       :cmd [luabin "-E" (.. luapath "/main.lua")]
       :capabilities capabilities
       :settings {:Lua {:completion {:keywordSnippet "Disabled"}
                        :diagnostics diagnostics
                        :workspace workspace
                        :runtime runtime}}})))

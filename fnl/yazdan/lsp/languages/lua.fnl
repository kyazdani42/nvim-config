(module yazdan.lsp.languages.lua
  {autoload {lspconfig lspconfig
             lua-dev lua-dev
             utils yazdan.lsp.utils}})

(defn setup [capabilites]
    (lspconfig.sumneko_lua.setup (lua-dev.setup {:lspconfig {:on_attach utils.on_attach
                                                             :telemetry {:enable false}
                                                             :capabilities capabilities}})))

(module yazdan.lsp.languages.lua
  {autoload {neodev neodev
             utils yazdan.lsp.utils}})

(defn setup [capabilites]
  (neodev.setup {})
  (let [cfg (require :lspconfig)]
    (cfg.sumneko_lua.setup {:on_attach utils.on_attach
                            :settings {:Lua {:telemetry {:enable false}
                                             :capabilities capabilities}}})))

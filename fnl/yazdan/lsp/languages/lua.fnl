(module yazdan.lsp.languages.lua
  {autoload {nvim aniseed.nvim
             neodev neodev
             utils yazdan.lsp.utils}})

(defn setup [capabilites]
  (neodev.setup)

  (let [cfg (require :lspconfig)]
    (cfg.lua_ls.setup {:on_attach utils.on_attach
                       :settings {:Lua {:version "LuaJIT"
                                        :telemetry {:enable false}
                                        :workspace {:library (nvim.get_runtime_file "" true)
                                                    :checkThirdParty false}
                                        :capabilities capabilities}}})))

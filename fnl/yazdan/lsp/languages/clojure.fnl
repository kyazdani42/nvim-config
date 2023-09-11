(module yazdan.lsp.languages.clojure
  {autoload {lspconfig lspconfig
             utils yazdan.lsp.utils}})

(defn setup []
  (lspconfig.clojure_lsp.setup {:on_attach utils.on_attach}))

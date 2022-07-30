(module yazdan.lsp.languages.haskell
  {autoload {lspconfig lspconfig
             utils yazdan.lsp.utils}})

(defn setup []
  (lspconfig.hls.setup {:on_attach utils.on_attach}))

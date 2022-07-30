(module yazdan.lsp.languages.go
  {autoload {lspconfig lspconfig
             utils yazdan.lsp.utils}})

(defn setup []
  (lspconfig.gopls.setup {:on_attach utils.on_attach}))

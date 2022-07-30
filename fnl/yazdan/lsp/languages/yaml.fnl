(module yazdan.lsp.languages.yaml
  {autoload {lspconfig lspconfig
             utils yazdan.lsp.utils}})

(defn setup []
  (lspconfig.yamlls.setup {:on_attach utils.on_attach}))

(module lsp.languages.yaml
  {autoload {lspconfig lspconfig
             utils lsp.utils}})

(defn setup []
  (lspconfig.yamlls.setup {:on_attach utils.on_attach}))
